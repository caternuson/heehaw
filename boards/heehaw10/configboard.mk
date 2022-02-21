BOARD_NAME = heehaw10
CHIP_FAMILY = samd10
CHIP = __ATSAMD10D14AM__
LINKER_SCRIPT = ldscripts/samd10d14am_flash.ld

ARM_CPU   := -mcpu=cortex-m0plus
ARM_ARCH  := 6   # NOTE: must match the ARM_CPU!
ARM_FPU   :=
FLOAT_ABI :=
