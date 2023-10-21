# Define all ASR Rule GUIDs
$asrRuleGUIDs = @(
    "D4F940AB-401B-4EFC-AADC-AD5F3C50688A", # Block executable content from email and webmail
    "3B576869-A4EC-4529-8536-B80A7769E899", # Use advanced protection against ransomware
    "75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84", # Block all Office applications from creating child processes
    "DCB3B048-4DCA-4EDE-8D3A-40B9D6882D72", # Block Office applications from injecting into process
    "D1E49AAC-8F56-4280-B9BA-993A6D77406C", # Block JavaScript or VBScript from launching downloaded executable content
    "7674BA52-37EB-4A4F-A9A1-F0F9A1619A2C", # Block execution of potentially obfuscated scripts
    "B2B3F03D-6A65-4F7B-A9C7-1C7EF74A9BA4", # Block Win32 API calls from Office macro
    "92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B", # Block executable files from running unless they meet a prevalence, age, or trusted list criterion
    "01443614-CD74-433A-B99E-2ECDC07BFC25", # Use advanced protection against threats, even if it means not being optimal for system performance
    "D4F940AB-401B-4EFC-AADC-AD5F3C50688A", # Block executable content from email client and webmail
    "ACDC6F1A-B0B3-4F80-8F8B-13BDEE3D7B7C", # Block executable content from Office Open XML macros
    "9E6C4E1F-7D60-472F-BA1A-A39EF669E4B2", # Block credential stealing from LSASS
    "DC92C352-DBEC-4FCF-A1E0-FEB5C45DF40B", # Block process creations originating from PSExec and WMI commands
    "5BEB7EFE-FD9A-4556-801D-275E5FFC04CC", # Block non-enterprise app installations
    "3B576869-A4EC-4529-8536-B80A7769E899", # Use advanced protection against threats
    "D3E037E1-3EB8-44C8-A917-57927947596D", # Block Office communication application from creating child processes
    "BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550", # Block Adobe Reader from creating child processes
    "E6DB77E5-3DF2-4CF1-B95A-636979351E5B"  # Block persistence through WMI event subscription
)

# Enable each ASR rule
foreach ($guid in $asrRuleGUIDs) {
    Set-MpPreference -AttackSurfaceReductionRules_Ids $guid -AttackSurfaceReductionRules_Actions Enabled
}

Write-Host "All ASR rules have been enabled!"
