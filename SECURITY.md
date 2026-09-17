# Security

## Runtime behavior

True Daywalker is a native in-process gameplay mod.

The public 0.3.0 Beta uses a `version.dll` proxy placed beside
`Dawnwalker.exe`. It forwards the Windows Version API exports needed by the
game and then installs runtime hooks after validating the supported executable
build.

This kind of behavior can resemble injection/patching techniques used by
malware and may trigger generic heuristic antivirus detections. In this mod,
the behavior is used to alter game logic inside the Dawnwalker process.

## Intended security properties

The 0.3.0 Beta release is designed to:

- validate the exact supported `Dawnwalker.exe` SHA-256 before installation;
- refuse to overwrite an unrecognized `version.dll`;
- refuse to install while the game is running;
- preserve an existing recognized True Daywalker installation before upgrade;
- avoid direct save-file modification;
- avoid world-clock manipulation as a mechanism for enabling vampire gameplay;
- perform no intended network communication or remote download behavior.

The public installer scripts are available under `scripts/` for inspection.

## Antivirus / quarantine

A generic antivirus or hosting-platform quarantine is not automatically proof
of malicious behavior, but it should not be ignored.

If a scanner flags a True Daywalker release:

1. record the exact file hash;
2. record the engine/detection name;
3. compare the file against `CHECKSUMS.txt`;
4. inspect/build the published source when available;
5. report any mismatch or unexpected behavior.

## Reporting a security concern

Please open a GitHub issue for non-sensitive concerns.

For a vulnerability that should not initially be public, contact the repository
owner through GitHub before publishing exploit details.

Do not attach save files, personal paths, credentials, or unrelated private
data to public reports.
