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

echo ""
read -rp "Select a script to run [1-${#keys[@]}]: " choice < /dev/tty

# Validate input
if [[ ! "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#keys[@]} )); then
  echo "❌ Invalid choice."
  exit 1
fi

selected_key="${keys[choice-1]}"
selected_url="${SCRIPT_MAP[$selected_key]}"

echo ""
echo "🔧 Running: $selected_key"
echo "📡 Fetching from: $selected_url"
echo ""

# === Fetch, run, clean up ===

tmp_script=$(mktemp)

if curl -fsSL "$selected_url" -o "$tmp_script"; then
  chmod +x "$tmp_script"
  "$tmp_script"
  rm -f "$tmp_script"
else
  echo "❌ Failed to download script."
  exit 1
fi