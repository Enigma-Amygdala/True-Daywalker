# True Daywalker

**True Daywalker** is a native gameplay mod for *The Blood of Dawnwalker* that removes the hard day/night split between Coen's human and vampire gameplay systems.

> **One hybrid ruleset, day or night.**

Official Nexus Mods page: https://www.nexusmods.com/thebloodofdawnwalker/mods/554

Official GitHub release mirror: https://github.com/Enigma-Amygdala/True-Daywalker-Release

## Open source and maintenance status

**The first-party True Daywalker code and documentation in this repository are released under the [MIT License](LICENSE).** You can inspect, fork, modify, redistribute, and publish your own versions, including commercially, provided you preserve the copyright and license notices.

**Original-author development is paused.** No new features, compatibility updates, support responses, or binary releases are promised. Community forks and contributions are welcome on a best-effort basis; the existence of this repository does not imply active support. See [MAINTENANCE.md](MAINTENANCE.md) and [CONTRIBUTING.md](CONTRIBUTING.md).

**Source/binary boundary:** The reproducible *source starting point* currently available is the retained **0.3.0** first-party native source archive. Later **0.4.x** binaries and release ZIPs (including 0.4.5 archives present in this repository) are **not** represented as having matching published source. See [BUILDING.md](BUILDING.md) before claiming a source-backed rebuild. This is a public open-source *code repository*, not a claim that every historic binary is rebuildable from its contents.

This license covers only material whose copyright is owned or controlled by the True Daywalker author. *The Blood of Dawnwalker*, its assets, names, and trademarks, and third-party dependencies belong to their respective owners and are **not relicensed** by this repository. See [THIRD_PARTY.md](THIRD_PARTY.md).

## Documented 0.4.4 Beta release

**0.4.4 Beta**  
Tested game build: **CL-258504**

[Download True Daywalker 0.4.4 Beta](https://github.com/Enigma-Amygdala/True-Daywalker-Release/releases/download/v0.4.4-beta/TrueDaywalker-0.4.4-Beta.zip)

The 0.4.4 release fixes a progression-blocking hybrid-form issue affecting Astral Communion at haunted sites and Compel interactions with eligible corpses.

True Daywalker 0.4.4 currently provides:

- Witchcraft while functioning as a vampire.
- Vampire abilities during the day.
- Daytime feeding through Focus Mode.
- Vampire claws and vampire traversal during the day.
- Normal weapon combat alongside vampire abilities.
- Human and vampire consumable use.
- Human healing/regeneration integrated with segmented Blood.
- Human Health/Restoration percentage bonuses integrated with segmented Blood.
- Day and Night quick-slot banks that can both accept learned Witchcraft and vampire powers.
- Sword → Claws → Fists → Sword weapon cycling.
- Fixed Claws and fixed Fists configuration modes.
- Selectable appearance, unarmed behavior, and traversal configuration.
- Compel and Astral Communion support in the hybrid ruleset.
- Compatibility validation based on native code/data layout and runtime-entry signatures rather than one exact whole-file executable hash, while still failing closed on unknown native-code changes.

## Critical 0.4.4 progression fix

0.4.4 removes only the `Player.IsVampire` activation blocker for **Compel** and **Astral Communion** when Coen is checked. Native quest, target, learned-ability, range, combat, cost, and completion requirements remain intact.

Initial daytime validation confirmed both abilities working after the fix.

## Known limitations

- **Wolf Form** is the stable traversal option.
- **Haste / Mercurial Fervor** remains unresolved in the hybrid traversal path.
- Tap/Hold traversal remains experimental and is not the public default.
- An extra sword flourish can occur when cycling from Fists back to Sword.

## Installation

Use the guarded installer included in the current release archive, or install manually according to the included `README.txt`.

True Daywalker uses `version.dll` as its native proxy loader. It does not require UE4SS or another external mod framework.

## Security / audit notes

The native DLL:

- is an in-process `version.dll` proxy;
- forwards the Windows Version API exports required by the game;
- validates compatibility before applying runtime hooks;
- contains no intended networking or downloader functionality;
- does not edit the world clock to fake nighttime;
- does not directly edit save files.

Native runtime hooks and memory protection changes can trigger heuristic antivirus detections.

## Source and build verification

The exact retained first-party **0.3.0** native source snapshot remains public:

[`source/TrueDaywalker-0.3.0-native-source.zip`](source/TrueDaywalker-0.3.0-native-source.zip)

Source snapshot SHA-256:

```text
d1c85b30f03accccdf453f7fcfe9639ab67e41bde0e752cef8b8d7a51970ddaf
```

**Important:** the retained public source snapshot currently covers 0.3.0. It should not be represented as the exact source snapshot for the 0.4.4 binary. The current 0.4.4 release package contains its release notes, checksums, compatibility profile, and security documentation; a matching retained 0.4.4 source snapshot can be published separately when available.

## Integrity

Public 0.4.4 Beta gameplay DLL:

```text
SHA-256
b0271a3e9d69a8e7feaa6bb148e4545cf9fc0b1abed6eff17921fb323e3b9bf8
```

Clean 0.4.4 Beta release archive:

```text
SHA-256
15e171884234ae9cd9d4f54dbd17bc5da7925c0230fb57b98f93c3cd68bf791e
```

See [`CHECKSUMS.txt`](CHECKSUMS.txt).

## Repository layout

```text
source/            retained 0.3.0 first-party source snapshot
src/native/        source-snapshot pointer and audit note
scripts/           historical/public installer scripts
config/            historical/public configuration
release/           release notes
BUILDING.md        0.3.0 reviewer build and validation instructions
NEXUS_REVIEW.md    historical 0.3.0 manual-review notes
SECURITY.md        security behavior and reporting
CHECKSUMS.txt       release and source integrity values
CHANGELOG.md        public release history
LICENSE             source-available license
```

## License

**MIT** for first-party True Daywalker software and documentation, subject to rights actually held by the copyright owner. Copyright (c) 2026 Enigma-Amygdala. You may fork, adapt, redistribute, and publish community builds (including commercial uses) if you preserve the MIT license and copyright notice.

The MIT license does **not** convey rights in *The Blood of Dawnwalker* or third-party assets and dependencies. The latest packaged binaries are not claimed to be reproducible from the retained 0.3.0 source snapshot.

See [LICENSE](LICENSE), [THIRD_PARTY.md](THIRD_PARTY.md), [CONTRIBUTING.md](CONTRIBUTING.md), and [MAINTENANCE.md](MAINTENANCE.md).
