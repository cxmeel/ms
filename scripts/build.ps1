# Extract the repository name from `wally.toml`
$wally = Get-Content -Path wally.toml -Raw
$regex = [regex] '(?<=name = ")(.*)(?=")'
$match = $regex.Match($wally)

$repoFullName = $match.Groups[1].Value
$projectName = $repoFullName.Split('/')[1]

# Create ".\dist" if it doesn't exist
New-Item -ItemType Directory -Force -Path ".\dist" -ErrorAction SilentlyContinue | Out-Null

$rojoProjectFile = ".\default.project.json"
$outputFileName = ".\dist\$projectName.rbxm"

# Install toolchain
aftman install

# Build and output direct to the plugins folder
rojo build $rojoProjectFile -o $outputFileName
