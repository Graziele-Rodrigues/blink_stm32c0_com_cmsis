firmware.elf: src/main.o src/startup_stm32c011xx.o src/system_stm32c0xx.o
	arm-none-eabi-gcc \
		src/main.o \
		src/startup_stm32c011xx.o \
		src/system_stm32c0xx.o \
		-specs=nosys.specs \
		-T STM32C011F6PX_FLASH.ld \
		-mcpu=cortex-m0 \
		-mthumb \
		-o build/firmware.elf \
		-g

src/main.o: src/main.c
	arm-none-eabi-gcc \
		src/main.c \
		-specs=nosys.specs \
		-Istm/CMSIS/Device/ST/STM32C0xx/Include \
		-Istm/CMSIS/Include \
		-DSTM32C011xx \
		-mcpu=cortex-m0 \
		-mthumb \
		-Os \
		-o src/main.o \
		-g -c

src/startup_stm32c011xx.o: src/startup_stm32c011xx.s 
	arm-none-eabi-gcc \
		src/startup_stm32c011xx.s \
		-specs=nosys.specs \
		-Istm/CMSIS/Device/ST/STM32C0xx/Include \
		-Istm/CMSIS/Include \
		-DSTM32C011xx \
		-mcpu=cortex-m0 \
		-mthumb \
		-Os \
		-o src/startup_stm32c011xx.o \
		-g -c

src/system_stm32c0xx.o: src/system_stm32c0xx.c
	arm-none-eabi-gcc \
		src/system_stm32c0xx.c \
		-specs=nosys.specs \
		-Istm/CMSIS/Device/ST/STM32C0xx/Include \
		-Istm/CMSIS/Include \
		-DSTM32C011xx \
		-mcpu=cortex-m0 \
		-mthumb \
		-Os \
		-o src/system_stm32c0xx.o \
		-g -c

clean:
	rm -f firmware.elf firmware.bin src/*.o