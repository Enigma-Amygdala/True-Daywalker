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

True Daywalker is a native runtime mod rather than a data-only `.pak` or Lua mod.

The Nexus release contains:

- a native x64 `version.dll` proxy;
- small PowerShell scripts for guarded installation, uninstallation, and appearance configuration;
- `.cmd` wrappers for those scripts;
- a plain INI configuration file and README.

The `version.dll` proxy runs inside the Dawnwalker process and installs native runtime hooks. That behavior can trigger generic heuristic scanners because native hooking necessarily resembles code-patching techniques.

## Source is published for review

The retained first-party 0.3.0 source snapshot is public here:

[`source/TrueDaywalker-0.3.0-native-source.zip`](source/TrueDaywalker-0.3.0-native-source.zip)

Source archive SHA-256:

```text
d1c85b30f03accccdf453f7fcfe9639ab67e41bde0e752cef8b8d7a51970ddaf
```

Build and validation instructions are in [`BUILDING.md`](BUILDING.md).

The source snapshot was audited before publication. No local Windows user paths, Codex paths, credentials, API keys, private save data, networking/downloader implementation, or unrelated project material were found.

## Source/public-DLL correspondence

The retained source identifies version 0.3.0 and contains the same ten-hook feature set represented by the public DLL. In particular it contains the quick-slot eligibility, player appearance, instant-healing, regeneration-healing, and feeding hooks introduced for the 0.3.0 candidate.

The public DLL contains source-corresponding diagnostic strings including:

```text
Starting 0.3.0 experimental, native x64, appearance=%s healing=%s; settings require restart.
Build CL-258504 verified. Ten hooks installed; waiting for a player load. No world-clock or save-file edits.
```

The public DLL exposes the 17 Version API exports defined by the source proxy and its PE import table contains only `KERNEL32.dll` and `bcrypt.dll`.

## Security-relevant design choices

The public installer:

- verifies the exact supported `Dawnwalker.exe` SHA-256 before installing;
- fails closed on an unsupported executable;
- refuses to overwrite an unrecognized existing `version.dll`;
- refuses to install while Dawnwalker is running;
- does not copy, modify, or delete Dawnwalker save files.

The native DLL:

- has no intended network or downloader functionality;
- validates the supported executable before installing game hooks;
- checks expected bytes/signatures at every hook/native API location before enabling hooks;
- does not edit the world clock to fake nighttime;
- does not directly edit save files.

## Relevant hashes

Public 0.3.0 Beta DLL:

```text
c521990e5b8e69bab2178ddc5dbcd077211e908e87557c35a370d2b42c316237
```

Clean public Nexus release archive:

```text
941db05da6bb40d0c96c125c8c62978c0297b8d2aaf755a2bdcc6f9ee8585ce1
```

Supported `Dawnwalker.exe`:

```text
E565BD97FBA398ECB1CA79CA2AA2CC2E5D43156A0937D7E202E73B3B85ED5086
```

See [`CHECKSUMS.txt`](CHECKSUMS.txt).

## Third-party dependency provenance

The first-party source CMake links MinHook. The retained source snapshot did not include the original local MinHook checkout, so this repository does not misrepresent an unverified third-party revision as historical fact. `BUILDING.md` pins upstream MinHook v1.3.4 for reviewer rebuilds and states this reproducibility boundary explicitly.
