#!/usr/bin/env nix-shell
#!nix-shell -i bash -p grim slurp curl jq wofi libnotify wl-clipboard

echo "GPT-4 Vision Screenshot Tool"

# New variable for settings
declare showErrorNotifications showSuccessNotifications showInfoNotifications

showErrorNotifications="true"

log_error () {
    if [[ "$showErrorNotifications" == "true" ]]; then
        echo "Error: $1" >&2
        notify-send "GPT-4 Vision Error" "$1"
    fi
}

log_info() {
    if [[ "$showInfoNotifications" == "true" ]]; then
        echo "Info: $1"
        notify-send "GPT-4 Vision Info" "$1"
    fi
}

log_success() {
    if [[ "$showSuccessNotifications" == "true" ]]; then
        echo "Success: $1"
        notify-send "GPT-4 Vision Success" "$1"
    fi
}

# Continualy call `wofi`` to build a list of actions
build_action_list() {
    # Create an array to store the actions the user can select from
    actions_to_select=(
        "copyToClipboard"
        "showInNotification"
        "Done"
    )
    actions_selected=()

    # Continually call `wofi` to build a list of actions
    while true; do
        action=$(printf "%s\n" "${actions_to_select[@]}" | wofi --dmenu -e --prompt "Select an action to perform:" --insensitive)

        # If the user selects "Done", break the loop
        if [[ "$action" == "Done" ]]; then
            break
        fi

        # Add the selected action to the list of actions
        actions_selected+=("$action")

        # Remove the selected action from the list of actions dont even allow any blank space
        actions_to_select=("${actions_to_select[@]/$action/}")
    done
}

# Initialize variables
folder_path=""

# Process arguments
for arg in "$@"; do
    if [[ -n "$arg" ]]; then
        # Assuming the argument is the folder path
        folder_path="$arg"
    fi
done

# Use the script's directory as the default folder path if not provided
if [[ -z "$folder_path" ]]; then
    folder_path=$(dirname "$(readlink -f "$BASH_SOURCE")")
fi

# Check if the folder path is provided
if [[ -z "$folder_path" ]]; then
    echo "Usage: $0 <folder_path>"
    exit 1
fi

# Read settings from the file
config_file="${folder_path}/config.json"
if [ ! -f "$config_file" ]; then
    log_error "Config file not found in specified folder."
    log_error "config_file: $config_file"
    exit 1
fi

# Set all setting variables to be used later in the script
showErrorNotifications=$(jq -r '.settings.showErrorNotifications' "$config_file")
showSuccessNotifications=$(jq -r '.settings.showSuccessNotifications' "$config_file")
showInfoNotifications=$(jq -r '.settings.showInfoNotifications' "$config_file")
api_key_path=$(jq -r '.apiKeyPath' "$config_file")
api_key=$(cat "$api_key_path")

# Check if the API key is provided
if [[ -z "$api_key" ]]; then
    log_error "API key not found in the config file."
    exit 1
fi

# Capture the screenshot directly to base64
encoded_image=$(grim -g "$(slurp -w 0)" - | base64 -w 0)

# Verify that the image was captured successfully
if [[ -z "$encoded_image" ]]; then
    log_error "Failed to capture the screenshot."
    exit 1
fi

# Read the prompts from config.json instead of prompts.json
prompts_file="${folder_path}/config.json"
if [ ! -f "$prompts_file" ]; then
    log_error "Config file not found in specified folder."
    exit 1
fi

# Prepare the selection options, including a way for users to input custom text
user_prompt=$(jq -r '.prompts[] | .userPrompt' "$prompts_file" | wofi --dmenu -e --prompt "Select your question or text for the image:" --insensitive)

# Determine if the input is a predefined prompt or a custom input
prompt=$(jq -r --arg userPrompt "$user_prompt" '.prompts[] | select(.userPrompt == $userPrompt) | .prompt' "$prompts_file")
actions=$(jq -r --arg userPrompt "$user_prompt" '.prompts[] | select(.userPrompt == $userPrompt) | .actions[] | .type' "$prompts_file")

# Validate the custom input to ensure it is not empty
if [[ -z "$prompt" && -z "$user_prompt" ]]; then
    log_error "The prompt cannot be empty."
    exit 1
fi

# If the user entered a custom prompt we have to assign actions to it manually
if [[ -z "$actions" ]]; then
    build_action_list
    actions="${actions_selected[@]}"
fi

# if the actions are empty, we have to assign the default actions
if [[ -z "$actions" ]]; then
    log_info "No actions selected, using default actions."
    actions="copyToClipboard showInNotification"
fi


# Use the first prompt as default if no selection is made
if [[ -z "$prompt" ]]; then
    prompt=$user_prompt
fi

# Prepare the JSON payload and write to a temporary file
payload_file=$(mktemp)
cat >"$payload_file" <<EOM
{
  "model": "gpt-4-vision-preview",
  "messages": [
    {
      "role": "user",
      "content": [
        {
          "type": "text",
          "text": "$prompt"
        },
        {
          "type": "image_url",
          "image_url": {
            "url": "data:image/jpeg;base64,$encoded_image"
          }
        }
      ]
    }
  ],
  "max_tokens": 3000
}
EOM

# echo "Payload file: $payload_file"

log_info "Sending the request to the OpenAI API..."

# Send the request to the OpenAI API using --data-binary to read from the file
response=$(curl -s -X POST https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $api_key" \
  --data-binary "@$payload_file")

# Process the response
response_message=$(echo "$response" | jq -r '.choices[0].message.content')

# Print the whole response for debugging purposes
# echo "$response"




# Handle actions...
if echo "$actions" | grep -q "copyToClipboard"; then
    echo "$response_message" | wl-copy
    log_success "Response copied to clipboard."
fi

if echo "$actions" | grep -q "showInNotification"; then
    notify-send "GPT-4 Vision Response" "$response_message"
fi

if echo "$actions" | grep -q "pipeTo_tempedit"; then
    echo "$response_message" | tempedit.sh
fi

# Here's an example of handling a "runCommand" action, assuming only one such action exists per prompt for simplicity.
command=$(jq -r --arg userPrompt "$user_prompt" '.prompts[] | select(.userPrompt == $userPrompt) | .actions[] | select(.type == "runCommand") | .command' "$prompts_file")
arguments=$(jq -r --arg userPrompt "$user_prompt" '.prompts[] | select(.userPrompt == $userPrompt) | .actions[] | select(.type == "runCommand") | .arguments[]' "$prompts_file")

if [[ "$command" != "null" && "$command" != "" ]]; then
    log_info "Running command: $command with arguments: $arguments"
    $command "${arguments[@]}"
fi

# Cleanup and exit
rm "$payload_file"