# Building True Daywalker 0.3.0 Beta

This document describes how to inspect and rebuild the retained first-party native source for the public 0.3.0 Beta line.

## Source snapshot

The retained first-party source is published at:

[`source/TrueDaywalker-0.3.0-native-source.zip`](source/TrueDaywalker-0.3.0-native-source.zip)

SHA-256:

```text
d1c85b30f03accccdf453f7fcfe9639ab67e41bde0e752cef8b8d7a51970ddaf
```

This is the retained 0.3.0 source tree from the original build workspace, not a decompiled or reconstructed substitute.

## Source-to-binary correspondence checked before publication

The source snapshot and public DLL agree on the following independently inspectable markers:

- project/resource version: **0.3.0**;
- DLL product string: `0.3.0 experimental`;
- supported executable: **CL-258504**;
- supported `Dawnwalker.exe` SHA-256 gate:
  `E565BD97FBA398ECB1CA79CA2AA2CC2E5D43156A0937D7E202E73B3B85ED5086`;
- ten native hooks, including `QuickslotEligibility`, `PlayerAppearance`, `InstantHealing`, `RegenerationHealing`, and `FeedingObserver`;
- the log string `Build CL-258504 verified. Ten hooks installed; waiting for a player load. No world-clock or save-file edits.` is present in both source and the public DLL;
- the source export definition contains the same 17 Windows Version API exports exposed by the public `version.dll`;
- the public DLL imports only Windows `KERNEL32.dll` and `bcrypt.dll` at the PE import-table level.

These checks establish strong correspondence. They are **not** presented as a byte-for-byte reproducible-build proof.

## Requirements

- Windows 10/11 x64
- Visual Studio 2022 with **Desktop development with C++**
- MSVC x64 toolchain
- CMake (the Visual Studio-bundled CMake is sufficient)
- MinHook

## Third-party dependency: MinHook

The retained first-party source refers to MinHook through:

```cmake
add_subdirectory(../tools/minhook minhook)
target_include_directories(TrueDaywalker PRIVATE ../tools/minhook/include)
```

The uploaded first-party snapshot did **not** include the original local MinHook checkout, so this repository does not falsely claim an exact retained revision for that third-party dependency.

For reviewer rebuilds, use upstream MinHook **v1.3.4**:

```powershell
git clone --branch v1.3.4 --depth 1 https://github.com/TsudaKageyu/minhook.git .\work\tools\minhook
```

MinHook v1.3.4 is used here as a pinned reviewer dependency. The first-party True Daywalker source itself is the retained historical 0.3.0 tree.

## Prepare the source

From the repository root:

```powershell
New-Item -ItemType Directory -Force .\work | Out-Null
Expand-Archive .\source\TrueDaywalker-0.3.0-native-source.zip .\work -Force
git clone --branch v1.3.4 --depth 1 https://github.com/TsudaKageyu/minhook.git .\work\tools\minhook
```

After extraction the relevant layout is:

```text
work/
├─ src/
│  ├─ CMakeLists.txt
│  ├─ true_daywalker.cpp
│  ├─ extensions.inl
│  ├─ policy.hpp
│  ├─ policy_test.cpp
│  ├─ proxy.cpp
│  ├─ proxy.asm
│  ├─ proxy.def
│  ├─ loader_test.cpp
│  ├─ version.rc
│  └─ TrueDaywalker.ini
└─ tools/
   └─ minhook/
```

## Configure and build

```powershell
cmake -S .\work\src -B .\build -G "Visual Studio 17 2022" -A x64
cmake --build .\build --config Release
```

The main output is expected to be:

```text
build\Release\version.dll
```

The project also defines `policy_test` and `loader_test` executables.

## Validation

Run the policy test:

```powershell
.\build\Release\policy_test.exe
```

The retained 0.3.0 development record reported **301 policy checks passing**, all **17 proxy exports** validated, and all **19 native signature checks** passing before gameplay testing.

The loader test can compare the proxy's Version API behavior against Windows and exercise the unsupported-process guard:

```powershell
.\build\Release\loader_test.exe `
  .\build\Release\version.dll `
  "C:\Path\To\The Blood of Dawnwalker\Dawnwalker\Binaries\Win64\Dawnwalker.exe"
```

## Official public hashes

Public 0.3.0 Beta gameplay DLL:

```text
c521990e5b8e69bab2178ddc5dbcd077211e908e87557c35a370d2b42c316237
```

Clean public release archive:

```text
941db05da6bb40d0c96c125c8c62978c0297b8d2aaf755a2bdcc6f9ee8585ce1
```

Supported `Dawnwalker.exe`:

```text
E565BD97FBA398ECB1CA79CA2AA2CC2E5D43156A0937D7E202E73B3B85ED5086
```

See [`CHECKSUMS.txt`](CHECKSUMS.txt).

## Packaging difference

The retained development source snapshot contains `Diagnostics=1` in its accompanying INI. The clean public Nexus package intentionally ships `Diagnostics=0` as the normal-user default. This changes configuration only; the published gameplay DLL was not rebuilt for that packaging change.

## Reproducibility boundary

The exact first-party 0.3.0 source is now public. Because the original local third-party MinHook checkout was not included in the retained source snapshot, this repository does not claim that a reviewer build using the pinned upstream dependency will be byte-identical to the published DLL. Reviewers can inspect the complete first-party implementation, rebuild it, exercise the included tests, and compare behavior, exports, version metadata, hook table, and release hashes.
