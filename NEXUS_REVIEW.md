# Nexus Mods manual-review notes

Official Nexus page:

https://www.nexusmods.com/thebloodofdawnwalker/mods/554

Public release:

- Mod: **True Daywalker**
- Version: **0.3.0 Beta**
- Nexus file ID: **7978725**
- Short unique file ID: **KMWM7k8SR**
- Supported game build: **CL-258504**

## Why the archive contains executable-like files

True Daywalker is a native runtime mod rather than a data-only `.pak` or Lua
mod.

The release contains:

- a native x64 `version.dll` proxy;
- small PowerShell scripts for guarded installation, uninstallation, and
  appearance configuration;
- `.cmd` wrappers that launch those PowerShell scripts;
- a plain INI configuration file and README.

The `version.dll` proxy runs inside the Dawnwalker process and installs native
runtime hooks. That behavior can trigger generic heuristic scanners because it
necessarily resembles code-patching techniques.

## Security-relevant design choices

The public installer:

- verifies the exact supported `Dawnwalker.exe` SHA-256 before installing;
- fails closed on any unsupported executable;
- refuses to overwrite an unrecognized existing `version.dll`;
- refuses to install while Dawnwalker is running;
- does not copy, modify, or delete Dawnwalker save files.

The DLL has no intended downloader or network functionality.

## Relevant hashes

Public DLL:

```text
c521990e5b8e69bab2178ddc5dbcd077211e908e87557c35a370d2b42c316237
```

Supported `Dawnwalker.exe`:

```text
E565BD97FBA398ECB1CA79CA2AA2CC2E5D43156A0937D7E202E73B3B85ED5086
```

See [`CHECKSUMS.txt`](CHECKSUMS.txt).

## Source and build verification

Build instructions are in [`BUILDING.md`](BUILDING.md).

**Current source-status notice:** the exact native C++ source tree that
produced the 0.3.0 DLL still needs to be copied from the original build
workspace into `src/native/`. The public scripts and configuration are already
included in this repository. This notice exists specifically to avoid
misrepresenting reconstructed code as the original source.

Do not treat this repository as complete compiled-code review material until
that source-status notice is removed after the exact source tree is imported.
