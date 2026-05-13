$ErrorActionPreference = "Stop"

$version = "0.1.28"
$installerName = "Shoty_0.1.28_x64-setup.exe"
$expectedSha256 = "5E5A9DBF60AAAF371E00E31C2A4AE804C5EF58A58F7DC97FAB9B3A1F81520F8A"
$url = "https://github.com/doublezero332/shoty-windows-releases/releases/download/v$version/$installerName"
$downloadDir = Join-Path $env:TEMP "shoty-install-$version"
$installerPath = Join-Path $downloadDir $installerName

New-Item -ItemType Directory -Force -Path $downloadDir | Out-Null
Write-Host "Downloading Shoty $version..."
Invoke-WebRequest -Uri $url -OutFile $installerPath

$actualSha256 = (Get-FileHash -LiteralPath $installerPath -Algorithm SHA256).Hash
if ($actualSha256 -ne $expectedSha256) {
  Remove-Item -LiteralPath $installerPath -Force -ErrorAction SilentlyContinue
  throw "Checksum mismatch. Expected $expectedSha256 but got $actualSha256."
}

Write-Host "Checksum verified: $actualSha256"
Write-Host "Starting Shoty installer..."
Start-Process -FilePath $installerPath -Wait
