BOARD=foo
include boards/$(BOARD)/board.mk

BUILD_DIR    = build/$(BOARD)
TARGET_BIN   = $(BUILD_DIR)/$(BOARD).bin
TARGET_ELF   = $(BUILD_DIR)/$(BOARD).elf

CC    = arm-none-eabi-gcc
LINK  = arm-none-eabi-gcc
BIN   = arm-none-eabi-objcopy

VPATH = \
	qpc/src/qf \
	qpc/src/qs \
	qpc/src/qxk \
	qpc/ports/arm-cm/qxk/gnu \
	src \
	inc \

INCLUDES = \
	-Iqpc/include \
	-Iqpc/src \
	-Iqpc/ports/arm-cm/qxk/gnu \
	-Iinc

QPC_SRCS = \
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

C_SRCS = $(QPC_SRCS) \
	src/main.c

C_OBJS = $(patsubst %.c,%.o,  $(notdir $(C_SRCS)))

C_OBJS_EXT = $(addprefix $(BUILD_DIR)/, $(C_OBJS))

COMMON_FLAGS = -mthumb -mcpu=cortex-m0plus -Os -g3
WFLAGS = -Wall
CFLAGS = -c \
	$(COMMON_FLAGS) $(WFLAGS) $(INCLUDES)
LFLAGS = $(COMMON_FLAGS) $(WFLAGS) \
	-T$(LINKER_SCRIPT) -mfpu=vfp -mfloat-abi=softfp \
	-specs=nosys.specs -specs=nano.specs \
	-Wl,-Map,$(BUILD_DIR)/$(BOARD_NAME).map,--cref,--gc-sections 

$(shell mkdir -p $(BUILD_DIR))

all: $(TARGET_BIN)

$(TARGET_BIN): $(TARGET_ELF)
	$(BIN) -O binary $< $@

$(TARGET_ELF): $(C_OBJS_EXT)
	$(LINK) $(LFLAGS) -o $@ $^

$(BUILD_DIR)/%.o : %.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -rf $(BUILD_DIR)
