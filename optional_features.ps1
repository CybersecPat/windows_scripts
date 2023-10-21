# Ensure the script is running with elevated privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Please run this script with administrator privileges!"
    exit
}

# Enable WSL
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# Enable Hyper-V. This includes all Hyper-V tools, including PowerShell modules, GUI, and core features.
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# Enable Virtualization Platform (Required for WSL2)
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform

# Enable Windows Sandbox
Add-WindowsCapability -Online -Name "Sandbox.App"

Write-Host "Features have been enabled. You may need to restart your computer."
