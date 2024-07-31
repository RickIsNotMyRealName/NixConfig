#! /usr/bin/env nix-shell
#! nix-shell -i bash ./shell.nix

# Function to clean up the temporary file
cleanup() {
  echo "Cleaning up..."
  rm -f "$TMP_FILE"
}

# Create a temporary file
TMP_FILE=$(mktemp /tmp/my-temp-file.XXXXXX)

# Ensure the temporary file is deleted when the script exits
trap cleanup EXIT

# Check if there is input available on stdin and if so, read it into the temporary file
if [ ! -t 0 ]; then
  cat - >"$TMP_FILE"
fi

# Open the temporary file with VS Code in a new window
code -n $TMP_FILE
