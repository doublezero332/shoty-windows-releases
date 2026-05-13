# Install Shoty on Windows

Version: `0.1.28`

Download page:

- https://doublezero332.github.io/shoty-windows-releases/

Latest release:

- https://github.com/doublezero332/shoty-windows-releases/releases/latest

## Recommended

Interactive installer:

```powershell
irm https://raw.githubusercontent.com/doublezero332/shoty-windows-releases/main/install.ps1 | iex
```

Passive MSI installer:

```powershell
irm https://raw.githubusercontent.com/doublezero332/shoty-windows-releases/main/install-msi.ps1 | iex
```

These scripts read `latest.json`, download the current EXE/MSI, and verify SHA-256 before starting installation.

## Direct Downloads

- EXE: https://github.com/doublezero332/shoty-windows-releases/releases/latest/download/ShotySetup.exe
- MSI: https://github.com/doublezero332/shoty-windows-releases/releases/latest/download/Shoty.msi
- Portable ZIP: https://github.com/doublezero332/shoty-windows-releases/releases/latest/download/ShotyPortable.zip

## Package Managers

Scoop:

```powershell
scoop bucket add shoty https://github.com/doublezero332/shoty-windows-releases
scoop install shoty
```

WinGet local manifest before the official PR is merged:

```powershell
winget install --manifest .\d\DoubleZero\Shoty\0.1.28 --accept-package-agreements --accept-source-agreements
```

Chocolatey package source:

```powershell
choco install shoty --source="'https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/'"
```

## Verify

Download checksums:

- https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/SHA256SUMS-v0.1.28.txt

Run verifier:

```powershell
irm https://raw.githubusercontent.com/doublezero332/shoty-windows-releases/main/verify.ps1 | iex
```

Current verifier coverage:

- Checked: 14
- Missing: 0
- Failed: 0

## Trust Status

These are unsigned Windows beta artifacts. Windows SmartScreen / Unknown publisher warnings are expected until Authenticode signing or Microsoft Store certification is complete.

Official channels still pending:

- WinGet PR: https://github.com/microsoft/winget-pkgs/pull/373873
- Microsoft Store Partner Center submission and certification.
- Authenticode signing for direct app.shoty.ai/updater distribution.
