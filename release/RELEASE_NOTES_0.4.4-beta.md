# True Daywalker 0.4.4 Beta

**Critical progression fix + substantial hybrid-system update.**

**Updating from 0.3.0 Beta is strongly recommended.**

## Critical progression fix

Fixed a hybrid-form bug that could block **Astral Communion** at haunted sites and **Compel** interactions with eligible corpses.

The fix is deliberately narrow: it removes only the `Player.IsVampire` activation blocker for those two abilities when Coen is checked, while preserving native quest, target, learned-ability, range, combat, cost, and completion requirements.

Initial daytime testing confirmed both Astral Communion and Compel working.

## What's new since 0.3.0 Beta

- Day and Night ability quick-slot banks can both accept learned Witchcraft and vampire powers.
- Added Sword → Claws → Fists → Sword weapon cycling.
- Added fixed Claws and fixed Fists configuration modes.
- Human Health/Restoration percentage bonuses now integrate with segmented Blood, alongside the existing human healing/regeneration integration.
- `Configure.cmd` now controls appearance, unarmed behavior, and traversal mode.
- Compatibility validation is less brittle while still failing closed on unknown native-code changes.
- Compel and Astral Communion now work in the hybrid ruleset.
- Existing daytime feeding, consumable union, appearance selection, segmented Blood model, and cross-phase ability behavior are preserved.

## Known limitations

- Wolf Form is the stable traversal option. Haste / Mercurial Fervor remains unresolved in the hybrid traversal path.
- Tap/Hold traversal remains experimental and is not the public default.
- An extra sword flourish can occur when cycling from Fists back to Sword.

## Integrity

Release ZIP SHA-256:
`15e171884234ae9cd9d4f54dbd17bc5da7925c0230fb57b98f93c3cd68bf791e`

`version.dll` SHA-256:
`b0271a3e9d69a8e7feaa6bb148e4545cf9fc0b1abed6eff17921fb323e3b9bf8`

Official release:
https://github.com/Enigma-Amygdala/True-Daywalker-Release/releases/tag/v0.4.4-beta
