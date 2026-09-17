# Building True Daywalker

This document records the build process used for the native 0.3.0 Beta line.

## Source status

The exact native C++ source tree that produced the public 0.3.0 DLL must be
placed in:

```text
src/native/
```

Until that tree is present, this repository is **not yet a complete
source-to-binary reproduction package**. The commands below are preserved from
the original build/validation record and are intentionally not presented as
proof of reproducibility until the exact source has been imported.

## Requirements

- Windows 10/11 x64
- Visual Studio 2022 with the Desktop development with C++ workload
- MSVC x64 toolchain
- CMake (the Visual Studio-bundled CMake was used for the original build)

No separate runtime framework such as UE4SS is required by the native DLL.

## Configure

From the repository root:

```powershell
cmake -S .\src\native -B .\build -G "Visual Studio 17 2022" -A x64
```

The original packaged source was also validated by configuring it into a fresh
build directory rather than reusing the development build tree.

## Build

```powershell
cmake --build .\build --config Release
```

The release target is expected to produce the native `version.dll` proxy and
the validation executables defined by the source tree.

## Validation

The 0.3.0 candidate build record reported:

- 301 policy checks passing;
- all 17 expected Windows Version API proxy exports present;
- 19 native executable-signature checks passing;
- unsupported-executable guard behavior exercised.

Run the policy test produced by the build:

```powershell
.\build\Release\policy_test.exe
```

The original loader test compared the proxy's Version API behavior against the
real Windows system library and exercised the unsupported-process guard:

```powershell
.\build\Release\loader_test.exe `
  .\build\Release\version.dll `
  "C:\Path\To\The Blood of Dawnwalker\Dawnwalker\Binaries\Win64\Dawnwalker.exe"
```

## Supported executable

The 0.3.0 Beta installer accepts only the executable with this SHA-256:

```text
E565BD97FBA398ECB1CA79CA2AA2CC2E5D43156A0937D7E202E73B3B85ED5086
```

This corresponds to the tested **CL-258504** build in the original release
environment.

The installer intentionally fails closed if this hash does not match.

## Expected public DLL hash

The exact native DLL distributed in the 0.3.0 Beta archive has:

```text
c521990e5b8e69bab2178ddc5dbcd077211e908e87557c35a370d2b42c316237
```

After the exact source tree is imported, a clean Release build should be
compared against the published binary. Compiler/linker metadata may need to be
normalized before byte-for-byte reproducibility can be claimed; until that is
demonstrated, compare functional behavior, exports, source revision, and
cryptographic hashes of the official release artifact separately.

## Important integrity rule

Do not replace the missing original source with reconstructed/decompiled code
and describe it as the source used for 0.3.0. Nexus review and user auditing are
better served by an honest provenance boundary.
