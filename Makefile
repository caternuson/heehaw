PROJECT=foo
GCC_DIR=/opt/gcc-arm-none-eabi-10-2020-q4-major
QPC_DIR=qpc
QPC_PORT=$(QPC_DIR)/ports/arm-cm/qxk/gnu
LINKER_SCRIPT=ldscripts/samd10d14am_flash.ld

BIN_DIR      := build
TARGET_BIN   := $(BIN_DIR)/$(PROJECT).bin
TARGET_ELF   := $(BIN_DIR)/$(PROJECT).elf

CC    := $(GCC_DIR)/bin/arm-none-eabi-gcc
LINK  := $(GCC_DIR)/bin/arm-none-eabi-gcc
BIN   := $(GCC_DIR)/bin/arm-none-eabi-objcopy

VPATH = \
	src \
	inc \
	$(QPC_DIR)/src/qf \
	$(QPC_DIR)/src/qs \
	$(QPC_DIR)/src/qxk \
	$(QPC_PORT)

INCLUDES = \
	-I$(QPC_DIR)/include \
	-I$(QPC_DIR)/src \
	-I$(QPC_PORT) \
	-Iinc

QPC_SRCS := \
	qep_hsm.c \
	qep_msm.c \
	qf_act.c \
	qf_actq.c \
	qf_defer.c \
	qf_dyn.c \
	qf_mem.c \
	qf_ps.c \
	qf_qact.c \
	qf_qeq.c \
	qf_qmact.c \
	qf_time.c \
	qxk.c \
	qxk_port.c

C_SRCS := $(QPC_SRCS) \
	src/main.c

C_OBJS := $(patsubst %.c,%.o,  $(notdir $(C_SRCS)))

C_OBJS_EXT   := $(addprefix $(BIN_DIR)/, $(C_OBJS))

COMMON_FLAGS = -mthumb -mcpu=cortex-m0plus -Os -g3
WFLAGS = -Wall
CFLAGS = -c \
	$(COMMON_FLAGS) $(WFLAGS) $(INCLUDES)
LFLAGS = $(COMMON_FLAGS) $(WFLAGS) \
	-T$(LINKER_SCRIPT) -mfpu=vfp -mfloat-abi=softfp \
	-specs=nosys.specs -specs=nano.specs \
	-Wl,-Map,$(BIN_DIR)/$(PROJECT).map,--cref,--gc-sections 

$(shell mkdir -p $(BIN_DIR))

all: $(TARGET_BIN)

$(TARGET_BIN): $(TARGET_ELF)
	$(BIN) -O binary $< $@

$(TARGET_ELF): $(C_OBJS_EXT)
	$(LINK) $(LFLAGS) -o $@ $^

$(BIN_DIR)/%.o : %.c
	$(CC) $(CFLAGS) $< -o $@
