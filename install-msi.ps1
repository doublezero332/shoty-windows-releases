$ErrorActionPreference = "Stop"

$version = "0.1.28"
$installerName = "Shoty_0.1.28_x64_en-US.msi"
$expectedSha256 = "75A8EC991CB3DD3DB634B46A048C14A4DCC8F54785433A2190D1737863D8C654"
$url = "https://github.com/doublezero332/shoty-windows-releases/releases/download/v$version/$installerName"
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
