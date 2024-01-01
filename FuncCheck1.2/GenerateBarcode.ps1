# Ensure the script can run with proper execution policy for this session
Set-ExecutionPolicy Bypass -Scope Process

# Install the BarcodeLib via NuGet (Make sure NuGet is installed and configured on your system)
Install-PackageProvider -Name NuGet -Force
Register-PackageSource -Name NuGetOrg -Location https://www.nuget.org/api/v2 -ProviderName NuGet -Force
Install-Package -Name BarcodeLib -Source NuGetOrg -Force

# Locate the BarcodeLib.dll
$nugetPackagePath = Join-Path -Path $env:UserProfile -ChildPath "\.nuget\packages\"
$barcodeLibName = "barcodelib"
$barcodeLibFileName = "BarcodeLib.dll"
$barcodeLibPaths = Get-ChildItem -Path $nugetPackagePath -Recurse -Filter $barcodeLibFileName | Where-Object { $_.DirectoryName -like "*$barcodeLibName*" }
$barcodeLibPath = ($barcodeLibPaths | Sort-Object -Property DirectoryName -Descending)[0].FullName

# If BarcodeLib.dll is found, proceed with barcode generation
if ($barcodeLibPath -ne $null)
{
    # Add the BarcodeLib to the script
    Add-Type -Path $barcodeLibPath

    # Instantiate the barcode generator and use it
    $barcode = New-Object BarcodeLib.Barcode
    $serialNumber = $args[0] # Get serial number from arguments passed to script
    $barcode.Encode([BarcodeLib.TYPE]::CODE128, $serialNumber)

    # Save the generated barcode image
    $outputPath = "serialNumberBarcode.png"
    $barcode.SaveImage($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

    # Output the path or further action (e.g., display or print the barcode)
    Write-Host "Barcode generated at: $outputPath"
}
else
{
    Write-Host "BarcodeLib.dll not found. Ensure it's installed and try again."
}
