#!/usr/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any command in a pipeline fails.
sudo apt update
sudo apt install python3
sudo apt install python-is-python3
sudo apt install python3-pip
sudo apt install python3-venv
sudo apt install pipx
pipx install --include-deps ansible
pipx ensurepath
