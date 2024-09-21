#!/bin/bash

# List of container IDs
CTIDS=(111 112 113)

# Check if a script file is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <script-file>"
    exit 1
fi

SCRIPT_FILE="$1"

# Verify that the script file exists and is readable
if [ ! -f "$SCRIPT_FILE" ]; then
    echo "Error: Script file '$SCRIPT_FILE' not found."
    exit 1
fi

# Iterate over each container ID and execute the script inside it
for CTID in "${CTIDS[@]}"; do
    echo "Executing script in container $CTID..."

    # Execute the script inside the container using zsh
    pct exec "$CTID" -- /run/current-system/sw/bin/zsh -s < "$SCRIPT_FILE"
    
    # Check the exit status of the pct exec command
    if [ $? -eq 0 ]; then
        echo "✅ Successfully executed in container $CTID."
    else
        echo "❌ Error executing in container $CTID." >&2
    fi

    echo "----------------------------------------"
done
