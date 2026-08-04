cmake_minimum_required(VERSION 3.24)

project(CUDAClangdExample LANGUAGES CXX CUDA)

find_package(CUDAToolkit REQUIRED)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
    set(CMAKE_CUDA_ARCHITECTURES 70 CACHE STRING "CUDA architectures")
endif()

add_executable(cuda_clangd_example demo03.cu src/maths.cu)
target_include_directories(cuda_clangd_example PRIVATE include)
target_link_libraries(cuda_clangd_example PRIVATE CUDA::cudart)
