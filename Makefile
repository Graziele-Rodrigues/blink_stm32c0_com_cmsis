# Compilador e linker
CC := arm-none-eabi-gcc

# Flags de compilação
CFLAGS := -mcpu=cortex-m0 -mthumb -Os -g -DSTM32C011xx \
          -Istm/CMSIS/Device/ST/STM32C0xx/Include \
          -Istm/CMSIS/Include -specs=nosys.specs
LDFLAGS := -mcpu=cortex-m0 -mthumb -T STM32C011F6PX_FLASH.ld -specs=nosys.specs

# Diretórios
SRC_DIR := src
BUILD_DIR := build
OBJ_DIR := $(BUILD_DIR)/obj

# Arquivos
SRCS := $(wildcard $(SRC_DIR)/*.c $(SRC_DIR)/*.s)
OBJS := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(patsubst $(SRC_DIR)/%.s,$(OBJ_DIR)/%.o,$(SRCS)))
TARGET := $(BUILD_DIR)/firmware.elf

# Regras
all: $(TARGET)

# Geração do ELF
$(TARGET): $(OBJS)
	@mkdir -p $(BUILD_DIR)
	$(CC) $(OBJS) $(LDFLAGS) -o $@

# Regras para objetos
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Limpeza
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean
