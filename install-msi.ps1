$ErrorActionPreference = "Stop"

$manifestUrl = "https://raw.githubusercontent.com/doublezero332/shoty-windows-releases/main/latest.json"
$manifest = Invoke-RestMethod -Uri $manifestUrl
$artifact = @($manifest.artifacts | Where-Object { $_.type -eq "msi" -and $_.architecture -eq "x64" } | Select-Object -First 1)[0]
if (-not $artifact) {
  throw "No x64 MSI installer artifact was found in $manifestUrl."
}

$version = $manifest.version
$installerName = $artifact.name
$expectedSha256 = $artifact.sha256
$url = $artifact.url
$downloadDir = Join-Path $env:TEMP "shoty-install-$version"
$installerPath = Join-Path $downloadDir $installerName

New-Item -ItemType Directory -Force -Path $downloadDir | Out-Null
Write-Host "Downloading Shoty $version MSI..."
Invoke-WebRequest -Uri $url -OutFile $installerPath

$actualSha256 = (Get-FileHash -LiteralPath $installerPath -Algorithm SHA256).Hash
if ($actualSha256 -ne $expectedSha256) {
  Remove-Item -LiteralPath $installerPath -Force -ErrorAction SilentlyContinue
  throw "Checksum mismatch. Expected $expectedSha256 but got $actualSha256."
}

Write-Host "Checksum verified: $actualSha256"
Write-Host "Starting Shoty MSI installer..."
$process = Start-Process -FilePath "msiexec.exe" -ArgumentList @("/i", "`"$installerPath`"", "/passive", "/norestart") -Wait -PassThru
if ($process.ExitCode -ne 0) {
  throw "MSI install failed with exit code $($process.ExitCode)."
}
