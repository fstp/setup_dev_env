#!/bin/bash
set -ux
terraform output -json main_ip | jq -r '.[]' > inventory
