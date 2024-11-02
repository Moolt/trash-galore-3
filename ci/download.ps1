$zipUrl = "todo"
$zipPath = "packages.zip"
$extractPath = "packages"

# Create the packages directory if it doesn't exist
if (!(Test-Path -Path $extractPath)) {
    New-Item -ItemType Directory -Path $extractPath
}

Write-Host "Downloading zip file..."
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath

Write-Host "Extracting zip file..."
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

Write-Host "Deleting zip file..."
Remove-Item -Path $zipPath -Force

Write-Host "Download, extraction, and cleanup complete!"
