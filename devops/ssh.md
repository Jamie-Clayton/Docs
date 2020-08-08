# Windows SSH instructions

## Create a public/private Key

```powershell
# Navigate to the folder that stores ssh keys (convention)
cd ~\.ssh\

# Create a new ssh key pair
ssh-keygen -t rsa -b 4096 -C me@example.com
```

You will be prompted for the name.

### Name Options

1. Leave it blank and a c:\users\\%profilename%\id_rsa file with no file extension is created (default SSH private key storage).
2. Provide a Name with no file extension
3. Provide a full path.  By convention c:\users\\%profilename%\\.ssh\ should contain all your personal keys. These paths may not be visible in windows explorer (due to the dot at the start of the folder name.

You will be prompted for a passphrase.

### Passphrase Options

1. Leave it blank, and you will not be prompted for passphrase when using it. BUT anyone can then use the key is compromised.
2. Provide a passphrase, where normal password.

## Windows Cheat sheet

Ensure that the appropriate open ssh services are running on windows and they are configured for use by Git

```powershell
# Get the version of SSH
ssh -V

# Find all the services running
Get-Service | select -property name,starttype

# Show the ssh-agent status (We need it running if you want to use SSH keys in windows)
Get-Service ssh-agent

# Set the service to manual start (or off if you no longer want it running)
Set-Service -Name ssh-agent -StartupType Manual

# Set the service to automatic start
Set-Service -Name ssh-agent -StartupType Automatic

# Start the service
Start-Service ssh-agent

# View the ssh components installed in windows.
explorer C:\Windows\System32\OpenSSH\
```

Create SSH keys (Public and Private) for authentication with git

```powershell
# Navigate to the folder that stores ssh keys (convention)
cd ~\.ssh\

# Create a new ssh key pair
ssh-keygen -t rsa -b 4096 -C "me@example.com"

# Copy your public/private key pair to your password manager/vault (you should maintain security on the private key (no file extension))
# Name the file appropriately.

# Review the ssh key details needed for your github.com, dev.azure.com, bitbucket.org git accounts.
VsCode ~\.ssh\id_rsa.pub
VsCode ~\.ssh\me-github.pub

# Navigate to https://github.com/settings/keys and place the contents of the pub file into github settings for your profile.

# Open Sourcetree -> Tools -> Add sshkey and navigate to your private key (no extension).
# Confirm a repository that has a ssh url works as expected.

# https://github.com/PowerShell/Win32-OpenSSH/issues/1234
# Bug in ssh-add on windows that causes ssh-add calls to misbehave.
# As a workaround to unblock you, could you create/install a dummy sshd service like this:
sc.exe create sshd binPath=C:\Windows\System32\OpenSSH\ssh.exe

# Run the SSH-Agent (or locate OpenSSH Authentication Agent in Services MMC)
Start-Service ssh-agent

# Add ssh private key to acceptable keys
cd ~/.ssh
ls  
ssh-add \me-github

# Confirm the key was added
ssh-add -L

# Test github connection.
ssh -vT git@github.com

# Enable the firewall access
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH SSH Server' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22 -Program "C:\System32\OpenSSH\sshd.exe"

# Test the Git fetch/pull/push commands to confirm the key has been correctly registered.
git fetch origin
git pull origin
git push origin

# VSCode may not correctly prompt for SSH password credential.
git config --global credential.helper wincred
```

## References

[GIT with SSH](https://dev.to/bdbch/setting-up-ssh-and-git-on-windows-10-2khk)

[Troubleshooting Windows OpenSSH](https://github.com/PowerShell/Win32-OpenSSH/issues/1133)

[Microsoft OpenSSH overview](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_overview)

[Powershell OpenSSH Wiki](https://github.com/powershell/Win32-OpenSSH/wiki)

[OpenSSH on Windows 1709 walk through](https://devblogs.microsoft.com/powershell/using-the-openssh-beta-in-windows-10-fall-creators-update-and-windows-server-1709/)

[ssh-add on Windows workaround](https://github.com/PowerShell/Win32-OpenSSH/issues/1234)

[Troubleshooting Open SSH connections](https://winscp.net/eng/docs/guide_windows_openssh_server)

[Git Credential caching](https://stackoverflow.com/a/58107764/342719)