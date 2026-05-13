$ErrorActionPreference = "Stop"

$checksumsUrl = "https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/SHA256SUMS-v0.1.28.txt"
$checksumsPath = Join-Path (Get-Location) "SHA256SUMS-v0.1.28.txt"

if (-not (Test-Path -LiteralPath $checksumsPath)) {
  Write-Host "Downloading checksums..."
  Invoke-WebRequest -Uri $checksumsUrl -OutFile $checksumsPath
}

$checked = 0
$missing = 0
$failed = 0

Get-Content -LiteralPath $checksumsPath | ForEach-Object {
  if ([string]::IsNullOrWhiteSpace($_)) {
    return
  }

  $parts = $_ -split "\s+", 2
  if ($parts.Count -ne 2) {
    throw "Invalid checksum line: $_"
  }

  $expected = $parts[0].Trim().ToUpperInvariant()
  $name = $parts[1].Trim()
  $path = Join-Path (Get-Location) $name

  if (-not (Test-Path -LiteralPath $path)) {
    Write-Host "MISSING $name"
    $script:missing += 1
    return
  }

  $actual = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToUpperInvariant()
  if ($actual -ne $expected) {
    Write-Host "FAIL    $name"
    Write-Host "  expected $expected"
    Write-Host "  actual   $actual"
    $script:failed += 1
    return
  }

  Write-Host "OK      $name"
  $script:checked += 1
}

Write-Host ""
Write-Host "Checked: $checked"
Write-Host "Missing: $missing"
Write-Host "Failed:  $failed"

if ($failed -gt 0) {
  exit 1
}
