# 0.3.0 native source snapshot

`TrueDaywalker-0.3.0-native-source.zip` is the retained first-party native source snapshot for the public **True Daywalker 0.3.0 Beta** DLL.

Source archive SHA-256:

```text
d1c85b30f03accccdf453f7fcfe9639ab67e41bde0e752cef8b8d7a51970ddaf
```

The archive contains the CMake project, native `version.dll` proxy/export layer, hybrid gameplay implementation, policy tests, loader test, version resource, and the development INI that accompanied the source tree.

Before publication the retained source was scanned for local/private development material. No Windows user paths, Codex paths, credentials, API keys, private save data, networking/downloader code, or unrelated project material were found.

The source identifies itself as 0.3.0 and contains the same ten-hook feature set represented by the public DLL, including quick-slot eligibility, appearance, instant-healing, regeneration-healing, and feeding hooks.

The source CMake expects the third-party **MinHook** library at `../tools/minhook`. The retained first-party snapshot did not include that external dependency. See [`../BUILDING.md`](../BUILDING.md) for the reviewer build procedure and provenance boundary.

## Open-source status

The original-author source in this retained historical snapshot is offered under the repository [MIT License](../LICENSE), to the extent the author holds the applicable copyrights. This does not relicense third-party content or the game. The original ZIP is preserved for provenance; community changes should be submitted as reviewable source files rather than silently replacing the archive.

**This 0.3.0 snapshot is not claimed to rebuild later 0.4.x release binaries.** See [MAINTENANCE.md](../MAINTENANCE.md) and [THIRD_PARTY.md](../THIRD_PARTY.md).
