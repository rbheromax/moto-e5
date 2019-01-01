#!/bin/bash
bash submodules.sh
export ARCH=arm
main_menu() {
PS3='Please enter your choice: '
options=("Moto E5 Plus XT1924-7" "Moto E5 Plus XT1924-5" "Moto E5 Play XT1924-4" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Moto E5 Plus XT1924-7")
            make hannah_defconfig
	    break
           ;;
        "Moto E5 Plus XT1924-5")
	   make nora_defconfig
	   break
            ;;
        "Moto E5 Play XT1924-4")
            make james_defconfig
            complile
	    break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
}
compile() {
make \
ARCH=arm \
CROSS_COMPILE=~/work/gcc-linaro-7.1.1/bin/arm-linux-gnueabihf-
}
make_zip() {
cp arch/arm/boot/zImage AnyKernel2/
# cp arch/arm/boot/dt.img AnyKernel2/dtb
# scripts/dtbTool -s 2048 -o arch/arm/boot/dt.img -p scripts/dtc/ arch/arm/boot/dts/qcom/
cd AnyKernel2/ && zip ../lsm-anykernel.zip $(ls) -r &>/dev/null
echo "Installer zip created @ 'lsm-anykernel.zip'!"
}
main_menu
compile
make_zip
