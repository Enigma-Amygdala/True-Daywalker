# True Daywalker

**True Daywalker** is a native gameplay mod for *The Blood of Dawnwalker* that removes the hard day/night split between Coen's human and vampire gameplay systems.

> **One hybrid ruleset, day or night.**

Official Nexus Mods page: https://www.nexusmods.com/thebloodofdawnwalker/mods/554

## Current public release

**0.3.0 Beta**  
Supported/tested game build: **CL-258504**

True Daywalker currently provides:

- Witchcraft while functioning as a vampire.
- Vampire abilities during the day.
- Daytime feeding through Focus Mode.
- Vampire claws and vampire traversal during the day.
- Normal weapon combat alongside vampire abilities.
- Human and vampire consumable use.
- Human healing/regeneration routed into the active segmented Blood system.
- Optional always-vampire or natural day/night appearance behavior.
- Fail-closed executable validation so unsupported game builds are not patched.

## Known limitations

The 0.3.0 Beta still inherits several vanilla systems that assume Coen is exclusively human or vampire:

- Ability quickslot assignment still follows vanilla day/night restrictions. Cross-phase abilities remain usable through the radial menu.
- Human fists cannot currently be selected while the hybrid state is active; unarmed combat uses claws.
- The movement-transformation slot currently resolves to **Wolf Form** rather than allowing **Haste** selection.
- Some item properties that distinguish specifically between human-health and vampire-health bonuses may not yet map cleanly into the unified segmented Blood model.

These are integration limits around the hybrid ruleset, not failures of the core day/night ability union.

## Installation

The official Nexus release includes a guarded installer and manual-install layout.

Manual layout:

```text
<game folder>\
└─ Dawnwalker\
   └─ Binaries\
      └─ Win64\
         ├─ version.dll
         └─ TrueDaywalker\
            ├─ TrueDaywalker.ini
            ├─ SelectAppearance.cmd
            └─ SelectAppearance.ps1
```

True Daywalker uses `version.dll` as its native proxy loader. The installer refuses to overwrite an unrecognized `version.dll`.

## Security / audit notes

The native DLL:

- is an in-process `version.dll` proxy;
- forwards the Windows Version API exports required by the game;
- installs runtime hooks only after validating the supported `Dawnwalker.exe`;
- contains no intended networking or downloader functionality;
- does not edit the world clock to fake nighttime;
- does not directly edit save files.

Native runtime hooks and memory protection changes can trigger heuristic antivirus detections. This repository exists in part to make the implementation and build process inspectable.

See [`SECURITY.md`](SECURITY.md) and [`NEXUS_REVIEW.md`](NEXUS_REVIEW.md).

## Build verification

The original 0.3.0 build record used:

- Windows x64
- Visual Studio 2022 / MSVC
- CMake
- generator: `Visual Studio 17 2022`
- architecture: `x64`

Reproducible build commands and verification steps are documented in [`BUILDING.md`](BUILDING.md).

### Source publication status

**Important:** the exact native C++ source tree that produced the public 0.3.0 DLL has not yet been copied into this GitHub repository. The release scripts/configuration are published here, but the native source must be imported from the original build workspace before this repository can be used as a complete source-to-binary verification record.

No reconstructed or decompiled substitute will be presented as the original source.

Expected destination:

```text
src/native/
```

## Integrity

Public 0.3.0 Beta gameplay DLL:

```text
SHA-256
c521990e5b8e69bab2178ddc5dbcd077211e908e87557c35a370d2b42c316237
```

Clean 0.3.0 Beta release archive:

```text
SHA-256
941db05da6bb40d0c96c125c8c62978c0297b8d2aaf755a2bdcc6f9ee8585ce1
```

See [`CHECKSUMS.txt`](CHECKSUMS.txt).

## Repository layout

```text
src/native/        exact native source for the DLL (pending import)
scripts/           public installer/configuration scripts
config/            default public configuration
BUILDING.md        reproducible build instructions
NEXUS_REVIEW.md    notes for Nexus/manual security review
SECURITY.md        security behavior and reporting
CHECKSUMS.txt       release integrity values
CHANGELOG.md        public release history
LICENSE             source-available license
```

## License

The source is published for inspection, security review, personal compilation, and project contributions. **This is source-available software, not an open-source license.**

Re-uploading, repackaging, publishing derivatives, and commercial redistribution are not granted without prior written permission.

See [`LICENSE`](LICENSE) for the exact terms.
