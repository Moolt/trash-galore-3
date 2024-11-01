# Define the directories to check
$directories = @("output", "cache", "build")

# Loop through each directory and check if it exists
foreach ($dir in $directories) {
    if (!(Test-Path -Path .\$dir)) {
        # Directory does not exist, so create it
        New-Item -ItemType Directory -Path .\$dir
        Write-Output "Directory '$dir' created."
    } else {
        # Directory exists
        Write-Output "Directory '$dir' already exists."
    }
}

Remove-Item -Path "output" -Recurse