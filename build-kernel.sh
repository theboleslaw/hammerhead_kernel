#!/bin/bash
# Copyright (C) 2013 MartinRo
# credits to sparksco for the SaberMod kernel buildscript as base
# Build Script. Use bash to run this script
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
#export TARGET_GCC=4.8;
export TARGET_GCC=4.10;

#the following lines one have some effect if you use 4.8 as TARGET_GCC
#if you want to use cfx, uncomment next line
#export TARGET_GCC_SUB=cfx;

#default one : googles toolchain. comment it out if you want to use different one
#export TARGET_GCC_SUB=google; 

#if you want to use the old sabermod toolchain from github, uncomment the next line
#export TARGET_GCC_SUB=sm_old;

#if you want to use the most current sabermod toolchain from sourceforge, uncomment the next line
#export TARGET_GCC_SUB=sm_new;

#if you want to use the most current sabermod toolchain from sourceforge, uncomment the next line
export TARGET_GCC_SUB=UBER;



export ARM_EABI_TOOLCHAIN=../../../prebuilts/gcc/linux-x86/arm/arm-eabi-$TARGET_GCC/$TARGET_GCC_SUB;

#export PATH=$ARM_EABI_TOOLCHAIN/arm-eabi/bin:$ARM_EABI_TOOLCHAIN/bin:$PATH;

 echo 'Kernel buid with ' $ARM_EABI_TOOLCHAIN;

# Build ID
export LOCALVERSION=""
export KBUILD_BUILD_USER=MVK
export KBUILD_BUILD_HOST="MVK"

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