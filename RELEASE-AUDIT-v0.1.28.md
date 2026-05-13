# Shoty v0.1.28 Windows Beta Release Audit

Date: 2026-05-13

## Objective

Release a Windows build of Shoty as quickly as possible without paid signing,
while keeping official-channel blockers explicit.

## Public Release Status

Public Windows beta release is live.

- Download page: https://doublezero332.github.io/shoty-windows-releases/
- Public release: https://github.com/doublezero332/shoty-windows-releases/releases/tag/v0.1.28
- Release manifest: https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/latest.json
- Full checksums: https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/SHA256SUMS-v0.1.28.txt
- Stable latest EXE link: https://doublezero332.github.io/shoty-windows-releases/download/windows/exe/
- Stable latest MSI link: https://doublezero332.github.io/shoty-windows-releases/download/windows/msi/
- Stable latest portable ZIP link: https://doublezero332.github.io/shoty-windows-releases/download/windows/portable/

## Artifacts

| Artifact | SHA-256 | Status |
| --- | --- | --- |
| `Shoty_0.1.28_x64-setup.exe` | `5E5A9DBF60AAAF371E00E31C2A4AE804C5EF58A58F7DC97FAB9B3A1F81520F8A` | public |
| `Shoty_0.1.28_x64_en-US.msi` | `75A8EC991CB3DD3DB634B46A048C14A4DCC8F54785433A2190D1737863D8C654` | public |
| `Shoty_0.1.28_windows_x64_portable.zip` | `20948539487946DB89D2BEBCAC3194DE9DA0C971A6C5CD85E9C77A0B5331B6D9` | public |
| `install.ps1` | `E226D9D664E81B03AB2D585086949C035EF8FBAFB860CA2EC300D295910ED62C` | public |
| `install-msi.ps1` | `C282CB08BF550253C0048226FA363A6509C0B518317DFD2B3EFB7B7077372F92` | public |
| `verify.ps1` | `CEE89F3B360FAA8C357639B2BC368FADAE5707FD1913F9E704FEE47BCA687D2F` | public |
| `latest.json` | `3E392678B7560F52B7E7839CBF19CFEEF5F7E86610BE432827BE5BBAE6500F4A` | public |
| `bucket/shoty.json` | `F4A48C759DB327C004C082FDA278B926B248372A5CE993B8084A0E98870B07FE` | public |
| `shoty.0.1.28.nupkg` | `2536CC61E330C425E222BEAF8150FF61253CF81143785C864DB112330F293A77` | public |
| `SHA256SUMS-v0.1.28.txt` | `58A860300542C8D10D9EA1292E37DC406038E0ADE1D3C63EE2C33CC5FFC201BC` | public |
| `RELEASE-AUDIT-v0.1.28.md` | See Release asset digest | public |

## Install Paths

Interactive installer:

```powershell
irm https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/install.ps1 | iex
```

MSI/passive installer:

```powershell
irm https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/install-msi.ps1 | iex
```

Scoop:

```powershell
scoop bucket add shoty https://github.com/doublezero332/shoty-windows-releases
scoop install shoty
```

Chocolatey package source:

```powershell
choco install shoty --source="'https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/'"
```

Portable:

1. Download `Shoty_0.1.28_windows_x64_portable.zip`.
2. Extract it.
3. Run `shoty-app.exe`.

Verify downloaded artifacts:

```powershell
irm https://github.com/doublezero332/shoty-windows-releases/releases/download/v0.1.28/verify.ps1 | iex
```

## Verification Evidence

- Download page returned HTTP 200 and contained EXE, MSI, portable ZIP, checksums, verify script, and Scoop install paths.
- Stable latest pages returned HTTP 200 and contained the expected v0.1.28 target filenames:
  - `/download/windows/exe/` -> `Shoty_0.1.28_x64-setup.exe`
  - `/download/windows/msi/` -> `Shoty_0.1.28_x64_en-US.msi`
  - `/download/windows/portable/` -> `Shoty_0.1.28_windows_x64_portable.zip`
- Public release assets returned HTTP 302 to GitHub release asset storage.
- `latest.json` parsed successfully and contains three public artifacts.
- `SHA256SUMS-v0.1.28.txt` was verified with `verify.ps1` against a local artifact folder:
  - Checked: 9
  - Missing: 0
  - Failed: 0
- An earlier checksum verification run caught a stale `latest.json` hash; the checksum file was corrected and the latest verification passed with 9 OK.
- Portable ZIP was inspected and contains:
  - `shoty-app.exe`
  - FFmpeg DLLs
  - `resources\ffmpeg\windows\x86_64\ffmpeg.exe`
  - `resources\ffmpeg\windows\x86_64\ffprobe.exe`
  - `README-PORTABLE.txt`
- Portable `shoty-app.exe` launch smoke:
  - Process started successfully.
  - Process was still running after 8 seconds.
  - Process was then stopped manually.
- Scoop manifest validation succeeded against the official Scoop schema using `ajv-cli --strict=false`.
- Chocolatey `.nupkg` package was generated with NuGet CLI and inspected:
  - `shoty.nuspec`
  - `tools/chocolateyInstall.ps1`
  - `tools/chocolateyUninstall.ps1`
  - PowerShell parser checks passed for install/uninstall scripts.
- WinGet manifest local validation succeeded with `winget validate`.
- WinGet PR is open and approved but blocked on Microsoft CLA:
  - https://github.com/microsoft/winget-pkgs/pull/373873
  - DoubleZero/company CLA comment: `@microsoft-github-policy-service agree company="DoubleZero"`
- AWS official deployment path was checked:
  - AWS profile `shoty-release` maps to `arn:aws:iam::316956664287:user/shoty-release-windows`.
  - `s3://shoty-uploads` list access failed with `AccessDenied` for `s3:ListBucket`.
  - Official deploy script requires Authenticode verification before upload.

## Not Complete For Official Distribution

These blockers remain:

- Authenticode signing is not complete. EXE/MSI status is `NotSigned`.
- Microsoft Store certification is not complete.
- WinGet publication is not complete because Microsoft CLA is pending.
- Official `app.shoty.ai`/S3 release path is not used because the current artifacts are unsigned and the deploy script requires Authenticode verification before upload.

## Conclusion

The v0.1.28 Windows beta is publicly released and installable through GitHub
Release, GitHub Pages, PowerShell scripts, Scoop, Chocolatey package artifact,
and portable ZIP.

This is not yet a signed official Windows release.

