# Install Chocolately via https://chocolatey.org/
choco feature enable -n allowGlobalConfirmation

# Install infrastructure as code tool - Terraform.io and Packer.io
choco install terraform --version 0.11.8 --yes
choco install packer --yes --force

# Confirm Installation
terraform -version

# Navigated to Terraform Git clones
cd C:\Users\jamie.clayton\Documents\Terraform\
cd aws-287-Dominos-Supply_Chain

# Open Microsoft Visual Code with the active folder loaded
Code folder .