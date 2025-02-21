# Define paths
$packagesPath = "$PSScriptRoot\..\packages"
$tempPath = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath "gamemaker_packages"
$rootDatafilesPath = "$PSScriptRoot\..\datafiles"
$gamesJsonPath = Join-Path -Path $rootDatafilesPath -ChildPath "games.json"
$projectPath = ".\trash-galore-3.yyp"

# Initialize the cumulative games array
$gamesArray = @()

# Check if the "packages" directory exists
if (-not (Test-Path -Path $packagesPath)) {
    Write-Host "The directory 'packages' does not exist."
    exit
}

# Create necessary directories
New-Item -ItemType Directory -Path $tempPath -Force | Out-Null
New-Item -ItemType Directory -Path $rootDatafilesPath -Force | Out-Null

# Step 1: Rename .yymps files to .zip
Get-ChildItem -Path $packagesPath -Filter *.yymps | ForEach-Object {
    $newName = $_.FullName -replace '\.yymps$', '.zip'
    Rename-Item -Path $_.FullName -NewName $newName
}

# Step 2: Unpack each .zip to the temp gamemaker_packages directory
Get-ChildItem -Path $packagesPath -Filter *.zip | ForEach-Object {
    $zipFilePath = $_.FullName
    $destinationPath = Join-Path -Path $tempPath -ChildPath $_.BaseName
    New-Item -ItemType Directory -Path $destinationPath -Force | Out-Null
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFilePath, $destinationPath)
}

# Step 3: Process each unpacked directory
Get-ChildItem -Path $tempPath -Directory | ForEach-Object {
    $directoryPath = $_.FullName
    Write-Host "Processing directory: $directoryPath"
    
    $apiScriptPath = Join-Path -Path $directoryPath -ChildPath "scripts/scr_api"

    # START Delete api script -----------------
    if (Test-Path -Path $apiScriptPath -PathType Container) {
        # Remove the directory and its contents
        Remove-Item -Path $apiScriptPath -Recurse -Force
        Write-Output "Directory '$apiScriptPath' has been deleted."
    } else {
        Write-Output "Directory '$apiScriptPath' does not exist."
    }

    # Read all lines from the file
    $packageProject = Get-ChildItem -Path $directoryPath -Filter "*.yyp" | Select-Object -First 1
    $lines = Get-Content -Path $packageProject.FullName

    # Filter out any lines that contain the string "name":"scr_api"
    $filteredLines = $lines | Where-Object { $_ -notmatch '"name":"scr_api"' }

    # Write the filtered content back to the file
    $filteredLines | Set-Content -Path $packageProject.FullName

    # END Delete api script -----------------

    # Execute the stitch merge command
    & stitch debork --target-project="$directoryPath" --force
    & stitch merge --source="$directoryPath" --force
    Write-Host "Executed 'stitch merge' for: $directoryPath"
    
    # Look for datafiles/game.json and add its content to gamesArray
    $gameJsonPath = Join-Path -Path $directoryPath -ChildPath "datafiles/game.json"
    if (Test-Path -Path $gameJsonPath) {
        # Read game.json content
        $gameData = Get-Content -Path $gameJsonPath | ConvertFrom-Json
        $gamesArray += $gameData
        
        # Delete the processed game.json file
        Remove-Item -Path $gameJsonPath -Force
        Write-Host "Processed and deleted $gameJsonPath"
    }
}

# Step 4: Handles nested datafiles directory caused by stitch
# Define the source and destination directories
$nestedDir = "./datafiles/datafiles"
$parentDir = "./datafiles"

# Check if the nested directory exists
if (Test-Path -Path $nestedDir) {
    Write-Host "Nested directory found. Moving contents..."

    # Get all files and directories in the nested directory
    Get-ChildItem -Path $nestedDir -Force | ForEach-Object {
        # Move each item to the parent directory
        Move-Item -Path $_.FullName -Destination $parentDir -Force
    }

    # Verify if the nested directory is empty
    if ((Get-ChildItem -Path $nestedDir -Force).Count -eq 0) {
        Write-Host "Contents moved successfully. Removing nested directory..."

        # Remove the nested directory
        Remove-Item -Path $nestedDir -Force -Recurse
        Write-Host "Nested directory removed."
    } else {
        Write-Host "Nested directory is not empty. Check for hidden or inaccessible files."
    }
} else {
    Write-Host "Nested directory does not exist. No action taken."
}

# Read the content of the file
$content = Get-Content -Path $projectPath

# Replace the string "datafiles/datafiles" with "datafiles"
$updatedContent = $content -replace "datafiles/datafiles", "datafiles"

# Write the updated content back to the output file
Set-Content -Path $projectPath -Value $updatedContent

# Assure game.json is deleted
if (Test-Path "./datafiles/game.json") {
    Remove-Item -Path "./datafiles/game.json"
}

# Step 5:
Start-Job -ScriptBlock { & stitch open --project .\trash-galore-3.yyp --ide 2024.8.1.171 --runtime 2024.8.1.218 }
Start-Sleep -Seconds 60
Stop-Process -Name "GameMaker"

Start-Sleep -Seconds 10

Start-Job -ScriptBlock { & stitch open --project .\trash-galore-3.yyp --ide 2024.8.1.171 --runtime 2024.11.0.226 }
Start-Sleep -Seconds 60
Stop-Process -Name "GameMaker"

# Step 6: Save the cumulative games data to datafiles/games.json in the root directory
$finalJson = @{ games = $gamesArray } | ConvertTo-Json -Depth 5
Set-Content -Path $gamesJsonPath -Value $finalJson
Write-Host "Accumulated games JSON saved to $gamesJsonPath"

# Step 7: Delete the gamemaker_packages directory and its contents
Remove-Item -Path $tempPath -Recurse -Force
Write-Host "Temporary unpacking directory 'gamemaker_packages' has been deleted."