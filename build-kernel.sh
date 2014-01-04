#!/bin/bash
# Copyright (C) 2013 MartinRo
# credits to sparksco for the SaberMod kernel buildscript as base
# Build Script. Use bash to run this script, bash mako-kernel from source directory
export MANUFACTURER=lge;
export DEVICE=hammerhead;

# GCC
export CC=$HOST_CC;
export CXX=$HOST_CXX;
export USE_CCACHE=1

# Source Directory PATH
#export DIRSRC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )";


# Kernel Source PATH
#export KERNELSRC=$DIRSRC;

# Target gcc version
export TARGET_GCC=4.8;
export ARM_EABI_TOOLCHAIN=../../../prebuilts/gcc/linux-x86/arm/arm-eabi-4.8-sm;
export PATH=$PATH:$ARM_EABI_TOOLCHAIN/bin:$ARM_EABI_TOOLCHAIN/arm-eabi/bin;

# Build ID
export LOCALVERSION="-OMP-V4"
export KBUILD_BUILD_USER=OMP
export KBUILD_BUILD_HOST="OMP"

# Cross compile with arm
export ARCH=arm;
export CCOMPILE=$CROSS_COMPILE;
export CROSS_COMPILE=$ARM_EABI_TOOLCHAIN/bin/arm-eabi-;

# Start the build
echo "";
echo "Starting the kernel build";
echo "";
if [ -e ./arch/arm/boot/zImage-dtb ] ;
then
    rm ./arch/arm/boot/zImage-dtb;
fi;

make hammerhead_defconfig;
time make -j8;

if [ -e ./arch/arm/boot/zImage-dtb ] ;
then
 cp ./arch/arm/boot/zImage-dtb -f ../../../device/lge/hammerhead-kernel/zImage-dtb;
 echo "Kernel build finished, Continuing with ROM build";
 echo "";
else
    echo "";
    echo "error detected in kernel build, now exiting";
    exit 1;
fi;
