# Define paths
$packagesPath = "$PSScriptRoot\..\packages"
$tempPath = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath "gamemaker_packages"
$rootDatafilesPath = "$PSScriptRoot\..\datafiles"
$gamesJsonPath = Join-Path -Path $rootDatafilesPath -ChildPath "games.json"

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
    
    # Execute the stitch merge command
    & stitch merge --source="$directoryPath"
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

# Step 4: Save the cumulative games data to datafiles/games.json in the root directory
$finalJson = @{ games = $gamesArray } | ConvertTo-Json -Depth 2
Set-Content -Path $gamesJsonPath -Value $finalJson
Write-Host "Accumulated games JSON saved to $gamesJsonPath"

# Step 5: Delete the gamemaker_packages directory and its contents
Remove-Item -Path $tempPath -Recurse -Force
Write-Host "Temporary unpacking directory 'gamemaker_packages' has been deleted."
