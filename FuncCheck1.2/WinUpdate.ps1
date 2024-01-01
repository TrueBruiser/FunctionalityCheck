# PowerShell script to automatically search, download, and install Windows updates

# Temporarily bypass the execution policy for this session
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

# Function to search for updates
function Search-Updates {
    $UpdateSession = New-Object -ComObject Microsoft.Update.Session
    $UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
    $SearchResult = $UpdateSearcher.Search("IsInstalled=0 and Type='Software'")
    return $SearchResult
}

# Function to download updates
function Download-Updates {
    param ($UpdatesToDownload)
    $UpdateSession = New-Object -ComObject Microsoft.Update.Session
    $Downloader = $UpdateSession.CreateUpdateDownloader()
    $Downloader.Updates = $UpdatesToDownload
    $Downloader.Download()
}

# Function to install updates
function Install-Updates {
    param ($UpdatesToInstall)
    $UpdateSession = New-Object -ComObject Microsoft.Update.Session
    $Installer = $UpdateSession.CreateUpdateInstaller()
    $Installer.Updates = $UpdatesToInstall
    $Installer.Install()
}

# Search for updates
Write-Host "Searching for Windows updates..."
$SearchResult = Search-Updates

# Check if updates are found
if ($SearchResult.Updates.Count -eq 0) {
    Write-Host "No new updates found."
    exit
}

# Prepare updates for download
$UpdatesToDownload = New-Object -ComObject Microsoft.Update.UpdateColl
foreach ($Update in $SearchResult.Updates) {
    $UpdatesToDownload.Add($Update) | Out-Null
}

# Download updates
Write-Host "Downloading updates..."
Download-Updates -UpdatesToDownload $UpdatesToDownload

# Install updates
Write-Host "Installing updates..."
Install-Updates -UpdatesToInstall $UpdatesToDownload

Write-Host "Windows update process completed."

# Check if a restart is needed
$UpdateSession = New-Object -ComObject Microsoft.Update.Session
$UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
$SearchResult = $UpdateSearcher.Search("IsInstalled=0 and RebootRequired=1")

if ($SearchResult.Updates.Count -gt 0) {
    Write-Host "A system restart is required to complete the update process."
    # Uncomment the following line if you want the script to initiate a restart
    Restart-Computer
}
