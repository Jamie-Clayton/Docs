# Install Chocolatey first

# Install infrastructure as code tool - Terraform.io and Packer.io
choco install terraform --yes
choco install packer --yes --force

# Confirm Installation
terraform -version

# Navigated to Terraform folders
cd ~\Documents\Terraform\

# Open Microsoft Visual Code with the active folder loaded
Code folder .