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

## Source and build verification

The exact retained first-party **0.3.0** native source snapshot is now public:

[`source/TrueDaywalker-0.3.0-native-source.zip`](source/TrueDaywalker-0.3.0-native-source.zip)

Source snapshot SHA-256:

```text
d1c85b30f03accccdf453f7fcfe9639ab67e41bde0e752cef8b8d7a51970ddaf
```

It is the retained source tree from the original build workspace, not a decompiled/reconstructed replacement. Before publication it was audited for personal paths, credentials, network/downloader code, and unrelated development material.

The source and public DLL agree on version metadata, the CL-258504 executable gate, the ten-hook feature set, the 17 Version API exports, and characteristic runtime diagnostic strings. See [`BUILDING.md`](BUILDING.md) for the detailed correspondence and reviewer build procedure.

The original first-party snapshot did not include its local third-party MinHook checkout. `BUILDING.md` therefore pins upstream MinHook v1.3.4 for reviewer rebuilds and explicitly avoids claiming byte-for-byte reproducibility across that unpreserved dependency boundary.

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
source/            immutable retained 0.3.0 first-party source snapshot
src/native/        source-snapshot pointer and audit note
scripts/           public installer/configuration scripts
config/            default public configuration
BUILDING.md        reviewer build and validation instructions
NEXUS_REVIEW.md    notes for Nexus/manual security review
SECURITY.md        security behavior and reporting
CHECKSUMS.txt       release and source integrity values
CHANGELOG.md        public release history
LICENSE             source-available license
```

## License

The source is published for inspection, security review, personal compilation, and project contributions. **This is source-available software, not an open-source license.**

Re-uploading, repackaging, publishing derivatives, and commercial redistribution are not granted without prior written permission.

See [`LICENSE`](LICENSE) for the exact terms.
