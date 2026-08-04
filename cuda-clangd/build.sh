#!/usr/bin/env bash
set -euo pipefail

cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j
compute-sanitizer --tool memcheck --leak-check full ./build/cuda_clangd_example
