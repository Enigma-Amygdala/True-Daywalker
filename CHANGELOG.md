# Changelog

## 0.4.4 Beta — 2026-09-18

Substantial hybrid-system update and critical progression fix.

### Critical progression fix

- Fixed a hybrid-form bug that could block **Astral Communion** at haunted sites.
- Fixed **Compel** interactions with eligible corpses in the hybrid ruleset.
- The fix removes only the `Player.IsVampire` activation blocker for those two abilities when Coen is checked; native quest, target, learned-ability, range, combat, cost, and completion requirements remain intact.
- Initial daytime validation confirmed both abilities working.

### Hybrid gameplay expansion

- Day and Night ability quick-slot banks can both accept learned Witchcraft and vampire powers.
- Added Sword → Claws → Fists → Sword weapon cycling.
- Added fixed Claws and fixed Fists configuration modes.
- Human Health/Restoration percentage bonuses now integrate with segmented Blood.
- `Configure.cmd` now controls appearance, unarmed behavior, and traversal mode.
- Existing daytime feeding, consumable union, appearance selection, segmented Blood, healing/regeneration integration, and cross-phase ability behavior are preserved.

### Compatibility / release engineering

- Compatibility validation is less brittle: native code/data layout and runtime-entry signatures are validated instead of requiring one exact whole-file executable hash.
- Unknown native-code changes still fail closed.
- Existing user settings are preserved during upgrades.
- Public defaults use Wolf Form for stable traversal.
- Diagnostics are disabled by default.

### Known limitations

- Haste / Mercurial Fervor remains unresolved in the hybrid traversal path.
- Tap/Hold traversal remains experimental and is not the public default.
- An extra sword flourish can occur when cycling from Fists back to Sword.

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
- Human healing/regeneration integrated with the segmented vampire Blood system.
- Selectable **Always Vampire** or **Natural** appearance behavior.
- Native world clock remains under game control.

### Release engineering

- Exact supported-executable hash gate for CL-258504.
- Unknown `version.dll` loaders are never overwritten automatically.
- Diagnostics disabled by default.
- Installer/uninstaller included with manual-install fallback.
- Release package stripped of development backups, saves, logs, and local machine paths.

### Known limitations

- Cross-phase ability assignment was still restricted by the vanilla quickslot UI.
- Human fists could not be selected; unarmed combat used claws.
- The movement-transformation slot defaulted to Wolf Form rather than allowing Haste selection.
- Some human-health/vampire-health-specific item bonuses remained candidates for a more complete unified-health mapping.
