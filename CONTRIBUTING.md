# Contributing to True Daywalker

True Daywalker is open source under the [MIT License](LICENSE). The original author is **not committing to active development or regular review**. Community forks are encouraged, and contributions may be reviewed or merged when capacity permits.

## Ways to help

- Report a reproducible compatibility issue, including your **mod version**, **game build**, reproduction steps, and relevant diagnostics with personal information removed.
- Improve build and installation documentation.
- Port the historic **0.3.0** first-party native source to newer game builds.
- Submit focused fixes, safeguards, tests, or community-maintained documentation.

## Source and version limitations

The retained first-party 0.3.0 source lives in `source/TrueDaywalker-0.3.0-native-source.zip` and is **preserved as a historical snapshot**. See [BUILDING.md](BUILDING.md).

For a maintained source tree, propose unpacked first-party source files as reviewable text, preferably under `src/native/`, **without overwriting the historic archive**. Document original provenance and changes clearly. Do not treat the 0.4.x binary archives as source, assert unverified source/binary equivalence, or submit decompiled game code or copyrighted game assets.

MinHook is a **separately licensed external dependency**; obtain it from its upstream project as described in [BUILDING.md](BUILDING.md). Do not paste third-party code into pull requests without its notices and sufficient rights.

## Pull requests

1. Explain the problem, your proposed change, and the game/mod versions tested.
2. Keep patches focused and include test commands, logs, and results when available; do not claim tests you did not run.
3. Do not commit game executables, game assets, pirated materials, personal save files, paths containing private details, passwords, tokens, or unsupported binary bundles.
4. Preserve existing copyright notices and include license notices for third-party work.
5. By submitting a contribution intended for this project, you agree to license **your own submitted contribution** under this repository's MIT License. Only submit work you have the rights to license.

## Support and security

There is **no guaranteed response time, release schedule, or compatibility support**. Issues may remain unanswered. Forking and independent community maintenance are permitted under MIT.

Do not publish secrets or exploit details in public issues. See [SECURITY.md](SECURITY.md) before reporting sensitive problems.
