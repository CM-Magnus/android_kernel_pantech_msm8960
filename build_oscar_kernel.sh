#!/bin/bash
###############################################################################
#
#                           Kernel Build Script 
#
###############################################################################
# 2013-01-14    P12104  :   created
###############################################################################
##############################################################################
# set toolchain
##############################################################################
export ARCH=arm
export CROSS_COMPILE=$PWD/../../../prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-
export LINUX_BIN_PATH=$PWD/obj
rm -rf $LINUX_BIN_PATH
CMD_V_LOG_FILE=$PWD/KERNEL_build.log
rm -rf $CMD_V_LOG_FILE

##############################################################################
# make zImage
##############################################################################
mkdir -p ./obj/KERNEL_OBJ/
make O=./obj/KERNEL_OBJ msm8960-perf_defconfig
make -j4 O=./obj/KERNEL_OBJ 2>&1 | tee $CMD_V_LOG_FILE

##############################################################################
# Copy Kernel Image
##############################################################################
if [ -f ./obj/KERNEL_OBJ/arch/arm/boot/zImage ]
then
    cp -f ./obj/KERNEL_OBJ/arch/arm/boot/zImage ./mkbootimg/oscar
fi

if [ -f ./arch/arm/boot/zImage ]
then
    cp -f ./arch/arm/boot/zImage ./mkbootimg/oscar
fi

##############################################################################
# Make BootImage
##############################################################################
pushd ./mkbootimg/oscar > /dev/null
./makebootimg.sh
popd > /dev/null

