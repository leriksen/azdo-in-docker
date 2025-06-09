#!/usr/bin/env bash

export AZP_URL="https://dev.azure.com/leiferiksenau"
export AZP_TOKEN="$(cat .azp_token)"
export AZP_POOL="azdo-in-docker"
export AZP_AGENT_NAME="agent01"

# uncomment if running on a linux VM eg parallels or azure vm
# sudo apt install -y docker
sudo docker run -e AZP_URL="${AZP_URL}" -e AZP_TOKEN="${AZP_TOKEN}" -e AZP_POOL="${AZP_POOL}" -e AZP_AGENT_NAME="${AZP_AGENT_NAME}" --name "azp-agent-linux" leriksen/pipelines-azp-docker