# Changelog

## 0.3.0 Beta — 2026-09-16

First public beta.

### Core hybrid gameplay

- Unified human/Witchcraft and vampire ability permissions.
- Vampire abilities usable during the day.
- Witchcraft usable while the hybrid/vampire state is active.
- Daytime feeding through the native Focus Mode interaction.
- Vampire claws and vampire traversal available during the day.
- Normal weapon combat retained.
- Cross-phase consumable support.
- Human healing/regeneration integrated with the segmented vampire Blood
  system.
- Selectable **Always Vampire** or **Natural** appearance behavior.
- Native world clock remains under game control.

### Release engineering

- Exact supported-executable hash gate for CL-258504.
- Unknown `version.dll` loaders are never overwritten automatically.
- Diagnostics disabled by default.
- Installer/uninstaller included with manual-install fallback.
- Release package stripped of development backups, saves, logs, and local
  machine paths.

### Known limitations

- Cross-phase ability assignment is still restricted by the vanilla quickslot
  UI; the radial menu can use the combined ability set.
- Human fists cannot currently be selected; unarmed combat uses claws.
- The movement-transformation slot currently defaults to Wolf Form rather than
  allowing Haste selection.
- Some human-health/vampire-health-specific item bonuses remain candidates for
  a more complete unified-health mapping.
