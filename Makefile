include generated_sources.mk

PROG = firmware

MONGOOSE_FLAGS = -DMG_ARCH=MG_ARCH_FREERTOS_LWIP -DPATH_MAX=512 -D MG_ENABLE_DIRECTORY_LISTING=0
MCU_FLAGS = -mcpu=cortex-m7 --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -DSTM32F746xx -DUSE_HAL_DRIVER -ffunction-sections -fstack-usage -ffunction-sections -fdata-sections


PROJECT_ROOT_PATH = $(realpath $(CURDIR)/../..)
DOCKER ?= docker run --rm -v $(PROJECT_ROOT_PATH):$(PROJECT_ROOT_PATH) -w $(CURDIR) mdashnet/armgcc

INCLUDES =	-I./Inc -I./Src 
INCLUDES += -I./Middlewares/Third_Party/Mongoose 
INCLUDES += $(DRIVERS_INCLUDES) $(FREERTOS_INCLUDES) $(LWIP_INCLUDES) 

SOURCES = 	$(wildcard Src/*.c) Middlewares/Third_Party/Mongoose/mongoose.c
SOURCES += 	$(BSP_SOURCES) $(HAL_SOURCES) $(FREERTOS_SOURCES) $(LWIP_SOURCES) $(OTHER_GENERATED_SOURCES)

OBJECTS = $(SOURCES:%.c=obj/%.o) obj/startup_stm32f746xx.o 

CFLAGS = -std=gnu11 -g3 -Os -W -Wall $(MCU_FLAGS) $(MONGOOSE_FLAGS) $(INCLUDES)

# STMCube generated code produces a lot of "unused parameter" warnings
CFLAGS += -Wno-unused-parameter

LINKFLAGS =	-mcpu=cortex-m7 -T"SW4STM32/STM32746G_Nucleo/STM32F746ZGTx_FLASH.ld" --specs=nosys.specs \
						-Wl,--gc-sections -static --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -u _printf_float -Wl,--start-group -lc -lm -Wl,--end-group -Wl,--gc-sections

build: $(PROG).bin

$(PROG).bin: $(PROG).elf
	$(DOCKER) arm-none-eabi-objcopy -O binary $< $@

$(PROG).elf: $(OBJECTS)
	$(DOCKER) arm-none-eabi-gcc $(OBJECTS) $(LINKFLAGS) -o $@
	$(DOCKER) arm-none-eabi-size $@

obj/%.o: %.c
	@mkdir -p $(dir $@)
	$(DOCKER) arm-none-eabi-gcc $(CFLAGS) -c $< -o $@

obj/startup_stm32f746xx.o: SW4STM32/startup_stm32f746xx.s
	@mkdir -p $(dir $@)
	$(DOCKER) arm-none-eabi-gcc $(CFLAGS) -x assembler-with-cpp -c $< -o $@

flash: $(PROG).bin
	st-flash --reset write $< 0x8000000
	
clean:
	@rm -rf $(PROG).* obj
