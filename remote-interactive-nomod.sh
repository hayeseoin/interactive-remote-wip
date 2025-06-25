#!/bin/bash

# Run with:
# curl -s http://some-endpoint.com/remote-interactive.sh | bash

echo "Please enter a parameter here"
read -r arg1

echo "You entered $arg1"