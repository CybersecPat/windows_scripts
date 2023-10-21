# Define the action to be taken, in this case, modifying the registry to disable telemetry and web search.
$actionScript = {
    # Disable Telemetry
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0

    # Since we're modifying the HKCU hive for all users, we'll iterate through each user's profile
    Get-WmiObject Win32_UserProfile | Where-Object { $_.Special -eq $false } | ForEach-Object {
        $userKey = $_.LocalPath -replace 'C:\\Users\\', 'HKU\\'
        # Attempt to set values; errors will be silently ignored (e.g., if a user hive isn't loaded)
        try {
            # Disable Bing Search in Start Menu for the user
            Set-ItemProperty -Path "$userKey\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "$userKey\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 0 -ErrorAction SilentlyContinue
        } catch {}
    }
}

# Convert the script block to a string
$actionString = [scriptblock]::Create($actionScript).ToString()

# Define the action that the scheduled task will perform, which is to execute the above PowerShell commands
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-NoProfile -NoExit -Command $actionString"

# Define the trigger for the scheduled task to be 'At log on' for any user
$trigger = New-ScheduledTaskTrigger -AtLogOn

# Register the scheduled task
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "DisableTelemetryAndWebSearch" -Description "Disables telemetry and web search in the taskbar search menu for all users." -User "SYSTEM" -RunLevel Highest

