cmake_minimum_required(VERSION 3.18)

project(STRUMPACKGPUExample LANGUAGES CXX)

find_package(MPI REQUIRED COMPONENTS CXX)
find_package(CUDAToolkit REQUIRED)

set(STRUMPACK_ROOT "" CACHE PATH "STRUMPACK installation prefix")
set(SCALAPACK_ROOT "" CACHE PATH "ScaLAPACK installation prefix")
set(OPENBLAS_ROOT "" CACHE PATH "OpenBLAS installation prefix")

find_path(STRUMPACK_INCLUDE_DIR StrumpackSparseSolverMPIDist.hpp
    HINTS ${STRUMPACK_ROOT} PATH_SUFFIXES include)
find_library(STRUMPACK_LIBRARY NAMES strumpack
    HINTS ${STRUMPACK_ROOT} PATH_SUFFIXES lib lib64)
find_library(SCALAPACK_LIBRARY NAMES scalapack
    HINTS ${SCALAPACK_ROOT} PATH_SUFFIXES lib lib64)
find_library(OPENBLAS_LIBRARY NAMES openblas
    HINTS ${OPENBLAS_ROOT} PATH_SUFFIXES lib lib64)

if(NOT STRUMPACK_INCLUDE_DIR OR NOT STRUMPACK_LIBRARY)
    message(FATAL_ERROR
        "STRUMPACK was not found. Set STRUMPACK_ROOT to its installation prefix.")
endif()
if(NOT SCALAPACK_LIBRARY OR NOT OPENBLAS_LIBRARY)
    message(FATAL_ERROR
        "ScaLAPACK/OpenBLAS were not found. Set SCALAPACK_ROOT and OPENBLAS_ROOT.")
endif()

add_executable(strumpack_gpu_example test_strumpack.cpp)
target_compile_features(strumpack_gpu_example PRIVATE cxx_std_17)
target_include_directories(strumpack_gpu_example PRIVATE
    ${STRUMPACK_INCLUDE_DIR})
target_link_libraries(strumpack_gpu_example PRIVATE
    MPI::MPI_CXX
    ${STRUMPACK_LIBRARY}
    ${SCALAPACK_LIBRARY}
    ${OPENBLAS_LIBRARY}
    CUDA::cublas
    CUDA::cudart)
