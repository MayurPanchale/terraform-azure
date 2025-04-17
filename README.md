## 🏗 Azure DevOps with Terraform
This project demonstrates how to use Terraform in Azure DevOps to manage infrastructure as code (IaC) within a CI/CD pipeline.

## 🔍 How Terraform Works in Azure DevOps
Terraform Init — Initializes the backend and downloads providers.

Terraform Plan — Shows the changes Terraform will make.

Terraform Apply — Applies the planned changes.

State Management — Terraform uses a remote state stored in an Azure Storage Account for consistency.

All steps can be automated via Azure DevOps pipelines, using either YAML or Classic Release Pipelines.

## 🐧 Install Azure DevOps Agent on Linux (Ubuntu)
Follow these steps to install a self-hosted agent on a Linux VM for running Terraform pipelines.

### ✅ Step 1: Install Required Dependencies
bash

sudo apt update
sudo apt install -y curl tar libicu70
💡 For older Ubuntu versions:

bash

sudo apt install libicu-dev
✅ Step 2: Create Agent Directory
bash

mkdir myagent && cd myagent
✅ Step 3: Download the Agent
bash

curl -O https://vstsagentpackage.azureedge.net/agent/4.254.0/vsts-agent-linux-x64-4.254.0.tar.gz
✅ Step 4: Extract the Archive
bash

tar zxvf vsts-agent-linux-x64-4.254.0.tar.gz
✅ Step 5: Configure the Agent
Before running the configuration script, gather:

Your Azure DevOps organization URL (e.g., https://dev.azure.com/your-org-name)

A Personal Access Token (PAT) with scopes:

Agent Pools (Read & manage)

Pipelines (Read & execute)

Then configure the agent:

bash

./config.sh
Follow the prompts:

Server URL: e.g. https://dev.azure.com/your-org-name

Authentication: Choose PAT and enter your token

Agent Pool: Select Default or your custom pool

Agent Name: Any unique name

Work Folder: Press Enter to use default

✅ Step 6: Install and Start the Agent as a Service
bash

sudo ./svc.sh install
sudo ./svc.sh start
Check status:

bash

sudo ./svc.sh status
✅ Step 7: Confirm Agent is Connected
Go to: https://dev.azure.com/<your-org-name>/_settings/agentpools

Click your agent pool

You should see your new agent listed as online

🧼 Optional: Manual Start/Stop
The agent is set to auto-start via systemd, but you can control it manually:

bash

sudo ./svc.sh stop
sudo ./svc.sh start
🚀 Goal: Deploy Terraform via Classic Release Pipeline
🔷 Step 1: Create a Release Pipeline
Go to Pipelines > Releases > New Pipeline

Select "Empty job" when prompted

🔷 Step 2: Link Build Artifact
In the Artifacts section, click "Add an artifact"

Choose:

Source type: Build

Source: Your Terraform CI pipeline

Default version: Latest

Source alias: terraform_artifact (or custom)

Click Add to save.

🔷 Step 3: Use Your Self-Hosted Agent
Click on the Stage (e.g., Stage 1) → Tasks

Select the Agent job

In Agent pool, choose your self-hosted pool (e.g., SelfHostedPool)

Leave Agent Specification as default (your local agent handles this)

✅ Done! You're now set up to run Terraform deployments from your own Linux-based Azure DevOps agent.

Let me know if you want to add sections on:

YAML-based pipelines

Troubleshooting common agent errors

Terraform backend configuration in detail

Ready to keep going?


## ⚙️ Terraform Backend Setup in Azure
Terraform uses a backend to store the state file remotely and safely. In Azure, this is typically an Azure Storage Account.

📦 Components You Need
Resource Group – e.g., demo-resources

Storage Account – e.g., mvpstorage33

Storage Container – e.g., prod-tfstate

State File Name – e.g., terraform.tfstate
