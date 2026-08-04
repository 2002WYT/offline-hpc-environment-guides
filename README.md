# Offline HPC Environment Guides

面向**无 sudo、服务器无法联网、只能上传安装包**场景的 HPC 软件安装、构建与排错笔记。每篇指南都尽量给出已验证版本、环境变量、完整命令和验收方法。

## Guides

| Guide | Platform / constraints | Tested versions | Covers |
|---|---|---|---|
| [CMake offline installation](cmake/README.md) | Linux x86_64, no sudo, offline | CMake 3.31.0 | 解压到用户目录、`PATH` 配置、版本检查 |
| [GCC user-space build](gcc/README.md) | Linux, no sudo, offline sources | GCC 11.2.0 | GMP/MPFR/MPC/ISL、out-of-source build、CMake 使用 |
| [clangd for remote CUDA development](cuda-clangd/README.md) | VS Code Remote-SSH, no sudo | clangd 22.1.0 example | `compile_commands.json`、CUDA include、过滤 nvcc 参数 |
| [STRUMPACK + SLATE GPU stack](strumpack-slate-gpu/README.md) | Linux + MPI + NVIDIA GPU, offline | V100, CUDA 12.6, GCC 11.2, STRUMPACK 8.0.0 | OpenBLAS、METIS、ScaLAPACK、SLATE、STRUMPACK、Nsight verification |
| [SuperLU_DIST GPU build](superlu-dist-gpu/README.md) | Linux + MPI + NVIDIA GPU, no sudo | V100, CUDA 12.6, GCC 11.2, SuperLU_DIST 9.2.1 | OpenBLAS、GKlib、METIS、ParMETIS、64-bit indices、GPU verification |

## Who these notes are for

- shared clusters where system packages cannot be changed;
- CentOS/RHEL or older Linux environments with an outdated compiler;
- air-gapped compute nodes reached through a login node;
- users who need reproducible CUDA/MPI/CMake dependency prefixes under `$HOME`;
- developers debugging link errors, ABI mismatches, missing headers, or runtime library paths.

## Recommended directory convention

Use one configurable prefix instead of copying author-specific absolute paths:

```bash
export HPC_SOFTWARE_ROOT="${HPC_SOFTWARE_ROOT:-$HOME/soft}"
mkdir -p "$HPC_SOFTWARE_ROOT/src" "$HPC_SOFTWARE_ROOT/install"
```

Each guide names its own `*_ROOT` variables below this prefix. Before running commands copied from a tested machine, replace compiler, CUDA, MPI, source, and installation locations with paths that exist on your server.

## Offline workflow

1. Record the target server architecture and existing compiler/MPI/CUDA versions.
2. Download release archives and recursive Git submodules on a networked machine.
3. Generate checksums before transfer.
4. Upload archives to the server without rebuilding or repackaging them there.
5. Build dependencies into versioned user-space prefixes.
6. verify headers, shared libraries, pkg-config/CMake metadata, and runtime linking;
7. compile and run the included smoke test where a guide provides one.

Useful checks:

```bash
uname -m
gcc --version
cmake --version
mpicxx --show
nvcc --version
nvidia-smi
```

## Using the included test projects

Some directories include small CMake projects captured from the documented software stack. Their dependency locations are cache parameters, so configure them without editing `CMakeLists.txt`:

```bash
cmake -S superlu-dist-gpu -B build/superlu \
  -DSUPERLU_DIST_ROOT=/path/to/superlu_dist

cmake -S strumpack-slate-gpu -B build/strumpack \
  -DSTRUMPACK_ROOT=/path/to/strumpack \
  -DSCALAPACK_ROOT=/path/to/scalapack \
  -DOPENBLAS_ROOT=/path/to/openblas
```

## Scope

These are tested engineering notes, not replacements for upstream documentation. Upstream flags and dependency requirements can change between releases; preserve the guide's tested version when reproducing a build, and consult the linked official documentation before upgrading components.

The repository does not yet declare a software/documentation license. Public visibility alone does not grant reuse rights.
