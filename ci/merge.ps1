# Define the path to the "packages" directory and the temp subdirectory for unpacking
$packagesPath = "$PSScriptRoot\..\packages"
$tempPath = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath "gamemaker_packages"

# Check if the "packages" directory exists
if (-not (Test-Path -Path $packagesPath)) {
    Write-Host "The directory 'packages' does not exist."
    exit
}

# Create the gamemaker_packages directory in the temp path
New-Item -ItemType Directory -Path $tempPath -Force | Out-Null

# Step 1: Find and rename all .yymps files to .zip
Get-ChildItem -Path $packagesPath -Filter *.yymps | ForEach-Object {
    $newName = $_.FullName -replace '\.yymps$', '.zip'
    Rename-Item -Path $_.FullName -NewName $newName
}

# Step 2: Find all .zip files and unpack each to a new directory in gamemaker_packages in the temp folder
Get-ChildItem -Path $packagesPath -Filter *.zip | ForEach-Object {
    $zipFilePath = $_.FullName
    $destinationPath = Join-Path -Path $tempPath -ChildPath $_.BaseName
    
    # Create the destination directory in the gamemaker_packages path
    New-Item -ItemType Directory -Path $destinationPath -Force | Out-Null
    
    # Unzip the .zip file to the new directory in the gamemaker_packages path
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFilePath, $destinationPath)
}

# Step 3: Execute `stitch merge` for each directory and print its name
Write-Host "Executing 'stitch merge' and listing directories:"
Get-ChildItem -Path $tempPath -Directory | ForEach-Object {
    $directoryPath = $_.FullName
    Write-Host "Processing directory: $directoryPath"
    
    # Execute the stitch merge command
    & stitch merge --source="$directoryPath"
    
    # Print confirmation of execution
    Write-Host "Executed 'stitch merge' for: $directoryPath"
}

# Step 4: Delete the gamemaker_packages directory and its contents
Remove-Item -Path $tempPath -Recurse -Force
Write-Host "Temporary unpacking directory 'gamemaker_packages' has been deleted."
