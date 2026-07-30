# Offline Software Installation Guide

本文档用于记录 HPC / GPU 计算环境中常用依赖的软件离线安装方法。

适用于： - 无网络服务器 - 无 sudo 权限环境 - 用户目录安装 - CUDA / MPI /
HPC 软件编译环境

推荐所有软件统一安装到：

``` bash
~/soft/
```

目录结构示例：

``` text
~/soft/
├── cmake-3.31.0-linux-x86_64
├── gcc-11.2.0
├── openblas-install
├── gklib-install
├── metis-install
└── superlu-dist-install
```

------------------------------------------------------------------------

# 1. CMake 3.31.0 Offline Installation

## 1.1 准备安装包

在有网络环境下载：

``` text
cmake-3.31.0-linux-x86_64.tar.gz
```

上传到服务器：

``` bash
scp cmake-3.31.0-linux-x86_64.tar.gz user@server:~/soft/
```

## 1.2 解压安装

``` bash
cd ~/soft
tar -zxvf cmake-3.31.0-linux-x86_64.tar.gz
```

生成：

``` text
~/soft/cmake-3.31.0-linux-x86_64
```

## 1.3 配置环境变量

编辑：

``` bash
vim ~/.bashrc
```

添加：

``` bash
export CMAKE_HOME=$HOME/soft/cmake-3.31.0-linux-x86_64
export PATH=$CMAKE_HOME/bin:$PATH
```

加载：

``` bash
source ~/.bashrc
```

验证：

``` bash
cmake --version
```

------------------------------------------------------------------------

# 2. GCC 11.2.0 Offline Installation

准备源码：

``` text
gcc-11.2.0.tar.gz
```

解压：

``` bash
tar -zxvf gcc-11.2.0.tar.gz
cd gcc-11.2.0
```

编译：

``` bash
mkdir build
cd build

../configure \
--prefix=$HOME/soft/gcc-11.2.0 \
--enable-languages=c,c++,fortran \
--disable-multilib

make -j$(nproc)
make install
```

配置：

``` bash
export GCC_HOME=$HOME/soft/gcc-11.2.0
export PATH=$GCC_HOME/bin:$PATH
export LD_LIBRARY_PATH=$GCC_HOME/lib64:$LD_LIBRARY_PATH
```

------------------------------------------------------------------------

# 3. OpenBLAS Offline Installation

解压：

``` bash
tar -zxvf OpenBLAS.tar.gz
cd OpenBLAS
```

编译：

``` bash
make -j$(nproc)

make PREFIX=$HOME/soft/openblas-install install
```

环境变量：

``` bash
export OPENBLAS_HOME=$HOME/soft/openblas-install
export LD_LIBRARY_PATH=$OPENBLAS_HOME/lib:$LD_LIBRARY_PATH
```

------------------------------------------------------------------------

# 4. GKlib Offline Installation

``` bash
git clone GKlib

cd GKlib
mkdir build
cd build

cmake .. \
-DCMAKE_INSTALL_PREFIX=$HOME/soft/gklib-install

make -j$(nproc)
make install
```

环境变量：

``` bash
export GKLIB_HOME=$HOME/soft/gklib-install
export LD_LIBRARY_PATH=$GKLIB_HOME/lib:$LD_LIBRARY_PATH
```

------------------------------------------------------------------------

# 5. METIS Offline Installation

``` bash
tar -zxvf metis.tar.gz
cd metis

make config prefix=$HOME/soft/metis-install

make -j$(nproc)
make install
```

环境变量：

``` bash
export METIS_HOME=$HOME/soft/metis-install
export PATH=$METIS_HOME/bin:$PATH
export LD_LIBRARY_PATH=$METIS_HOME/lib:$LD_LIBRARY_PATH
```

------------------------------------------------------------------------

# 6. CUDA Environment

检查：

``` bash
nvidia-smi
nvcc --version
```

设置：

``` bash
export CUDA_HOME=/usr/local/cuda

export PATH=$CUDA_HOME/bin:$PATH

export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
```

------------------------------------------------------------------------

# 7. Environment Check

``` bash
which cmake
which gcc
which g++
which nvcc

cmake --version
gcc --version
nvcc --version
```

------------------------------------------------------------------------

# 8. Notes

不要覆盖系统软件：

``` text
/usr/bin/cmake
/usr/bin/gcc
```

推荐全部安装到：

``` text
~/soft/
```

方便迁移和管理。

迁移：

``` bash
tar -czvf soft.tar.gz ~/soft
```

复制到新服务器后：

``` bash
tar -zxvf soft.tar.gz
source ~/.bashrc
```
