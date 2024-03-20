# PowerShell script to offer a choice between a standard scan and an intense offline scan, with input validation

# Initialize user choice
$userChoice = $null

# Loop until the user provides a valid response
while ($userChoice -ne 'Y' -and $userChoice -ne 'N') {
    # Prompt the user for their choice

    Echo: MSDefender Options 
      Echo  "Yes will restart the system and perform a deep scan of the system, the scan may take some time"  
      Echo "No will run a scan on the system without needing to restart, runs a standard scan on the OS" 
    $userChoice = Read-Host "Would you like to run a more intense scan of the system for rootkits and other infections? Hit Y for yes and N for no. (Y/N)"
  
    # Check the user's choice

    # Deep MS Defender scan offline, performs scan before boot to check for rootkits and BIOS infection
    if ($userChoice -eq 'Y') {
        # User chose to run the more intense offline scan
        Write-Output "Initiating Windows Defender Offline scan. Your system will restart."


        # Encode the script block to Base64 to use in the scheduled task
        $EncodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($CheckThreatsScript.ToString()))

        # Create a scheduled task to run once at system startup to check for threats
        $Action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "-encodedCommand $EncodedCommand"
        $Trigger = New-ScheduledTaskTrigger -AtStartup
        $Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount
        $Settings = New-ScheduledTaskSettingsSet -DeleteExpiredTaskAfter "PT1M" -StartWhenAvailable
        Register-ScheduledTask -TaskName "CheckDefenderThreatsPostOfflineScan" -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings

        # Initiate the offline scan
        Start-MpWDOScan
    }

    # Standard MSDefender Scan
    elseif ($userChoice -eq 'N') {
        # User chose not to run the more intense offline scan, proceed with the standard full scan
        Write-Output "Initiating standard Windows Defender full scan."

        # Ensure Windows Defender is up to date with the latest release
        Update-MpSignature

        Start-MpScan 


        # Output message indicating the scan has started
        Write-Output "Monitoring for threats during the scan. This may take a while..."

        # Define the function to check for threats and output status
        function CheckForThreats {
            $Threats = Get-MpThreatDetection
            if ($Threats) {
                Write-Output "Threats detected: System might be compromised."
                $Threats | ForEach-Object {
                    Write-Output "Threat: $($_.ThreatName) Severity: $($_.SeverityId)"
                }
            } else {
                Write-Output "No threats detected so far."
            }
        }

# Post scan Actions
# Ensures real-time monitoring/protection is enabled on the device
        # Monitor the scan progress and check for threats
        do {
            CheckForThreats
            Start-Sleep -Seconds 30  # Check every 30 seconds
        } while ((Get-MpScan).ScanStatus -eq "Scanning")

        # Final check for threats after scan completion
        CheckForThreats

        # Output final status
        Write-Output "Windows Defender scan has completed."
        if ($Threats){
        Write-Output "Threat detected, system is likely compromised"
        $Threats | ForEach-Object{
            Write-Output "Threat: $($_.ThreatName) Severity: $($_.SeverityId)"
        }
    } else {
        Write-Output " No threats detected, system has no known infections"
    }if ($Threats){
        Write-Output "Threat detected, system is likely compromised"
        $Threats | ForEach-Object{
            Write-Output "Threat: $($_.ThreatName) Severity: $($_.SeverityId)"
        }
    } else {
        Write-Output " No threats detected, system has no known infections"
    }
    }
    else {
        # The user input is invalid, prompt again
        Write-Output "Invalid input. Please select either Y or N."
        $userChoice = $null  # Reset user choice to prompt again
    }
}
