cmake_minimum_required(VERSION 3.18)

project(SuperLUDistGPUExample LANGUAGES CXX)

find_package(MPI REQUIRED COMPONENTS CXX)
find_package(CUDAToolkit REQUIRED)

set(SUPERLU_DIST_ROOT "" CACHE PATH "SuperLU_DIST installation prefix")

find_path(SUPERLU_DIST_INCLUDE_DIR superlu_ddefs.h
    HINTS ${SUPERLU_DIST_ROOT} PATH_SUFFIXES include)
find_library(SUPERLU_DIST_LIBRARY NAMES superlu_dist
    HINTS ${SUPERLU_DIST_ROOT} PATH_SUFFIXES lib lib64)

if(NOT SUPERLU_DIST_INCLUDE_DIR OR NOT SUPERLU_DIST_LIBRARY)
    message(FATAL_ERROR
        "SuperLU_DIST was not found. Set SUPERLU_DIST_ROOT to its installation prefix.")
endif()

add_executable(superlu_dist_gpu_example test_superlu_dist.cpp)
target_compile_features(superlu_dist_gpu_example PRIVATE cxx_std_17)
target_include_directories(superlu_dist_gpu_example PRIVATE
    ${SUPERLU_DIST_INCLUDE_DIR})
target_link_libraries(superlu_dist_gpu_example PRIVATE
    MPI::MPI_CXX
    ${SUPERLU_DIST_LIBRARY}
    CUDA::cublas
    CUDA::cudart)
