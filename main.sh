#!/bin/bash

#!/bin/bash

# === Configuration ===

REMOTE_SCRIPTS=(
  "plain=https://hayeseoin-u6avxgte.s3.eu-central-1.amazonaws.com/remote-plain.sh"
  "env=https://hayeseoin-u6avxgte.s3.eu-central-1.amazonaws.com/remote-env-vars.sh"
  "args=https://hayeseoin-u6avxgte.s3.eu-central-1.amazonaws.com/remote-args.sh"
  "interactive=https://hayeseoin-u6avxgte.s3.eu-central-1.amazonaws.com/remote-interactive.sh"
)

# Parse key=value pairs into associative array
for entry in "${REMOTE_SCRIPTS[@]}"; do
  key="${entry%%=*}"
  value="${entry#*=}"
  SCRIPT_MAP["$key"]="$value"
done

# === UI ===

clear
echo "======================================="
echo "       🛠️  Remote Script Launcher       "
echo "======================================="
echo ""
echo "Available scripts:"
echo ""

# Display numbered list
keys=("${!SCRIPT_MAP[@]}")
for i in "${!keys[@]}"; do
  index=$((i + 1))
  printf "  [%d] %s\n" "$index" "${keys[i]}"
done

echo "Select a script to run [1-${#keys[@]}]: " choice
read -r choice_script < /dev/tty