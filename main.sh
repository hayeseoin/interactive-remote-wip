#!/bin/bash

#!/bin/bash

# === Configuration ===

REMOTE_SCRIPTS=(
  "plain=https://hayeseoin-u6avxgte.s3.eu-central-1.amazonaws.com/remote-plain.sh"
  "env=https://hayeseoin-u6avxgte.s3.eu-central-1.amazonaws.com/remote-env-vars.sh"
  "args=https://hayeseoin-u6avxgte.s3.eu-central-1.amazonaws.com/remote-args.sh"
  "interactive=https://hayeseoin-u6avxgte.s3.eu-central-1.amazonaws.com/remote-interactive.sh"
)

# === UI ===

clear
echo "======================================="
echo "       🛠️  Remote Script Launcher       "
echo "======================================="
echo ""
echo "Available scripts:"
echo ""

echo "Select a script to run [1-${#keys[@]}]: "
read -r choice_script < /dev/tty