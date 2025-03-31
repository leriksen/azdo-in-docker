#!/usr/bin/env zsh

export AZP_URL="https://dev.azure.com/leiferiksenau"
export AZP_TOKEN="$(cat .azp_token)"
export AZP_POOL="docker-vm"
export AZP_AGENT_NAME="agent01"

sudo apt install -y docker
sudo docker run -e AZP_URL="${AZP_URL}" -e AZP_TOKEN="${AZP_TOKEN}" -e AZP_POOL="${AZP_POOL}" -e AZP_AGENT_NAME="${AZP_AGENT_NAME}" --name "azp-agent-linux" leriksen/pipelines-azp-docker