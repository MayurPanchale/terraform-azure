# Azure DevOps with Terraform 🏗

This project demonstrates how to use **Terraform** in **Azure DevOps** to manage infrastructure as code in a CI/CD pipeline.

---

## 🔍 How Terraform Works








## Step-by-Step: Install Azure DevOps Agent on Linux
🐧 This guide assumes you're running Ubuntu or similar Linux distro and you're already connected to your VM via SSH.

✅ Step 1: Install Required Dependencies
bash


sudo apt update
sudo apt install -y curl tar libicu70
💡 If libicu70 isn't available (for older Ubuntu versions), use:
sudo apt install libicu-dev

✅ Step 2: Create a Folder for the Agent
bash


mkdir myagent && cd myagent
✅ Step 3: Download the Agent
bash


curl -O https://vstsagentpackage.azureedge.net/agent/4.254.0/vsts-agent-linux-x64-4.254.0.tar.gz
✅ Step 4: Extract the Archive
bash


tar zxvf vsts-agent-linux-x64-4.254.0.tar.gz
✅ Step 5: Configure the Agent
Before this step, you'll need:

Your Azure DevOps org URL (e.g., https://dev.azure.com/your-org-name)

A Personal Access Token (PAT) with scope:
Agent Pools (read & manage) and Pipelines (read & execute)

👉 Create one here: https://dev.azure.com → User icon → Personal access tokens

Then run:

bash


./config.sh
And follow prompts:

Server URL: e.g., https://dev.azure.com/your-org-name

Authentication: PAT

Agent Pool: use Default or your custom one

Agent Name: any name you like

Work folder: press Enter to accept default

✅ Step 6: Install and Start as a Service
bash


sudo ./svc.sh install
sudo ./svc.sh start
To check status:

bash


sudo ./svc.sh status
✅ Step 7: Confirm It's Connected
Go to: 🔗 https://dev.azure.com/<your-org-name>/_settings/agentpools
➡️ Click the agent pool
➡️ You should see your new agent online

🧼 Optional: Auto Start on Boot
The above steps already configure it as a systemd service — it will auto-start after reboot. You can manually start/stop with:

bash


sudo ./svc.sh stop
sudo ./svc.sh start
✅ You're Done!
You now have a fully working self-hosted Azure DevOps agent on your Linux VM 🎉


## ✅ Goal: Deploy Terraform from Classic Release Pipeline using Your Self-Hosted Agent

🔷 STEP 1: Create a Classic Release Pipeline
Go to Pipelines > Releases > New Pipeline

Select "Empty job" when prompted to start from scratch.

🔷 STEP 2: Link Build Artifact
In the Artifacts section (top), click "Add an artifact"

Choose:

Source type: Build

Source: Your Terraform CI pipeline

Default version: Latest

Source alias: terraform_artifact (or any name)

Click Add.

🔷 STEP 3: Configure Agent Job (Use Your Self-Hosted Agent)
Click on the Stage (e.g., Stage 1) → Tasks

Select the Agent job

In the Agent pool, choose the pool where your self-hosted agent is registered

e.g., SelfHostedPool

Leave Agent Specification as default (your agent controls that)