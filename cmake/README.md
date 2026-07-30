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
