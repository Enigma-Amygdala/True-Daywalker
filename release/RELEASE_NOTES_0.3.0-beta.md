# True Daywalker 0.3.0 Beta

First public beta of True Daywalker for *The Blood of Dawnwalker*.

> One hybrid ruleset, day or night.

## Supported game build

- CL-258504
- `Dawnwalker.exe` SHA-256: `E565BD97FBA398ECB1CA79CA2AA2CC2E5D43156A0937D7E202E73B3B85ED5086`

The mod fails closed on unsupported executable hashes.

## Highlights

- Witchcraft remains usable while the hybrid/vampire state is active.
- Vampire abilities work during the day.
- Daytime feeding through Focus Mode.
- Vampire claws and traversal during the day.
- Normal weapon combat retained.
- Human and vampire consumables supported together.
- Human healing/regeneration routed into the segmented vampire Blood system.
- Optional Always Vampire or Natural day/night appearance behavior.
- The world clock remains under the game's control.

## Known limitations

- The vanilla ability-assignment UI still keeps its day/night quickslot split; the radial menu can use the combined ability set.
- Human fists are not currently selectable; unarmed combat uses claws.
- The movement-transformation slot currently defaults to Wolf Form rather than allowing Haste selection.
- Some item bonuses that specifically target human health versus vampire health still need a complete unified mapping.

## Integrity

Official full release archive SHA-256:

`941db05da6bb40d0c96c125c8c62978c0297b8d2aaf755a2bdcc6f9ee8585ce1`

Manual-install archive SHA-256:

`7bea87f25b534a6ef1223ff528d985f34d32b046c48b2f0dbcef475e4df895b2`

Gameplay DLL SHA-256:

`c521990e5b8e69bab2178ddc5dbcd077211e908e87557c35a370d2b42c316237`

The retained first-party 0.3.0 source snapshot, build instructions, security notes, and Nexus review notes are available in this repository.

## Installation

The full archive contains the guarded installer. A stripped manual-install archive is also provided for users who prefer to copy the files directly.

Manual install target:

`<game folder>\Dawnwalker\Binaries\Win64\`

Place `version.dll` there and the `TrueDaywalker` configuration folder beside it.
