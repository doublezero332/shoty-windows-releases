# Shoty Windows Releases

Public Windows beta release artifacts for Shoty.

## Latest Windows beta

Version: `0.1.28`

Download page:

- https://doublezero332.github.io/shoty-windows-releases/

Direct downloads:

- [Shoty_0.1.28_x64-setup.exe](https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/Shoty_0.1.28_x64-setup.exe)
- [Shoty_0.1.28_x64_en-US.msi](https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/Shoty_0.1.28_x64_en-US.msi)
- [SHA256SUMS.txt](https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/SHA256SUMS.txt)
- [latest.json](https://raw.githubusercontent.com/doublezero332/shoty-windows-releases/main/latest.json)

PowerShell install:

```powershell
irm https://raw.githubusercontent.com/doublezero332/shoty-windows-releases/main/install.ps1 | iex
```

Version-pinned PowerShell install:

```powershell
irm https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/install.ps1 | iex
```

MSI/passive install:

```powershell
irm https://raw.githubusercontent.com/doublezero332/shoty-windows-releases/main/install-msi.ps1 | iex
```

Version-pinned MSI/passive install:

```powershell
irm https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/install-msi.ps1 | iex
```

Checksums:

```text
5E5A9DBF60AAAF371E00E31C2A4AE804C5EF58A58F7DC97FAB9B3A1F81520F8A  Shoty_0.1.28_x64-setup.exe
75A8EC991CB3DD3DB634B46A048C14A4DCC8F54785433A2190D1737863D8C654  Shoty_0.1.28_x64_en-US.msi
```

## Install notes

These Windows artifacts are unsigned beta builds. Windows SmartScreen / Unknown publisher warnings are expected until a public-trust Authenticode signing surface or Microsoft Store certification is available.

To verify a download in PowerShell:

```powershell
Get-FileHash .\Shoty_0.1.28_x64_en-US.msi -Algorithm SHA256
```

## WinGet status

A WinGet submission is open at https://github.com/microsoft/winget-pkgs/pull/373873.
It is currently blocked on Microsoft CLA agreement by the GitHub account holder.
