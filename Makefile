TARGET  = firmware
CROSS   = arm-none-eabi
CFLAGS  ?= -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DMG_ARCH=MG_ARCH_FREERTOS_LWIP -DUSE_HAL_DRIVER -DSTM32F746xx -I./Core/Inc -I./Drivers/STM32F7xx_HAL_Driver/Inc -I./Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I./Drivers/CMSIS/Device/ST/STM32F7xx/Include -I./Drivers/CMSIS/Include -I./LWIP/App -I./LWIP/Target -I./Middlewares/Third_Party/LwIP/src/include -I./Middlewares/Third_Party/LwIP/system -I./Middlewares/Third_Party/FreeRTOS/Source/include -I./Middlewares/Third_Party/Mongoose -I./Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2 -I./Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I./Middlewares/Third_Party/LwIP/src/include/netif/ppp -I./Middlewares/Third_Party/LwIP/src/include/lwip -I./Middlewares/Third_Party/LwIP/src/include/lwip/apps -I./Middlewares/Third_Party/LwIP/src/include/lwip/priv -I./Middlewares/Third_Party/LwIP/src/include/lwip/prot -I./Middlewares/Third_Party/LwIP/src/include/netif -I./Middlewares/Third_Party/LwIP/src/include/compat/posix -I./Middlewares/Third_Party/LwIP/src/include/compat/posix/arpa -I./Middlewares/Third_Party/LwIP/src/include/compat/posix/net -I./Middlewares/Third_Party/LwIP/src/include/compat/posix/sys -I./Middlewares/Third_Party/LwIP/src/include/compat/stdc -I./Middlewares/Third_Party/LwIP/system/arch -I./Middlewares/Third_Party/LwIP/src/apps/http -O0 -ffunction-sections -fdata-sections -Wall -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb
LDFLAGS ?= -mcpu=cortex-m7  -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -T STM32F746ZGTX_FLASH.ld  --specs=nosys.specs -Wl,--gc-sections -static --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -Wl,--start-group -lc -lm -Wl,--end-group
SOURCES = \
	./Middlewares/Third_Party/Mongoose/mongoose.c \
	./Middlewares/Third_Party/LwIP/system/OS/sys_arch.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/auth.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/ccp.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/chap-md5.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/chap-new.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/chap_ms.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/demand.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/eap.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/ecp.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/eui64.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/fsm.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/ipcp.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/ipv6cp.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/lcp.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/magic.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/mppe.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/multilink.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/ppp.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/pppapi.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/pppcrypt.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/pppoe.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/pppol2tp.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/pppos.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/upap.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/utils.c \
	./Middlewares/Third_Party/LwIP/src/netif/ppp/vj.c \
	./Middlewares/Third_Party/LwIP/src/netif/bridgeif.c \
	./Middlewares/Third_Party/LwIP/src/netif/bridgeif_fdb.c \
	./Middlewares/Third_Party/LwIP/src/netif/ethernet.c \
	./Middlewares/Third_Party/LwIP/src/netif/lowpan6.c \
	./Middlewares/Third_Party/LwIP/src/netif/lowpan6_ble.c \
	./Middlewares/Third_Party/LwIP/src/netif/lowpan6_common.c \
	./Middlewares/Third_Party/LwIP/src/netif/slipif.c \
	./Middlewares/Third_Party/LwIP/src/netif/zepif.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv6/dhcp6.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv6/ethip6.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv6/icmp6.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv6/inet6.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv6/ip6.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv6/ip6_addr.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv6/ip6_frag.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv6/mld6.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv6/nd6.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv4/autoip.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv4/dhcp.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv4/etharp.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv4/icmp.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv4/igmp.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv4/ip4.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv4/ip4_addr.c \
	./Middlewares/Third_Party/LwIP/src/core/ipv4/ip4_frag.c \
	./Middlewares/Third_Party/LwIP/src/core/altcp.c \
	./Middlewares/Third_Party/LwIP/src/core/altcp_alloc.c \
	./Middlewares/Third_Party/LwIP/src/core/altcp_tcp.c \
	./Middlewares/Third_Party/LwIP/src/core/def.c \
	./Middlewares/Third_Party/LwIP/src/core/dns.c \
	./Middlewares/Third_Party/LwIP/src/core/inet_chksum.c \
	./Middlewares/Third_Party/LwIP/src/core/init.c \
	./Middlewares/Third_Party/LwIP/src/core/ip.c \
	./Middlewares/Third_Party/LwIP/src/core/mem.c \
	./Middlewares/Third_Party/LwIP/src/core/memp.c \
	./Middlewares/Third_Party/LwIP/src/core/netif.c \
	./Middlewares/Third_Party/LwIP/src/core/pbuf.c \
	./Middlewares/Third_Party/LwIP/src/core/raw.c \
	./Middlewares/Third_Party/LwIP/src/core/stats.c \
	./Middlewares/Third_Party/LwIP/src/core/sys.c \
	./Middlewares/Third_Party/LwIP/src/core/tcp.c \
	./Middlewares/Third_Party/LwIP/src/core/tcp_in.c \
	./Middlewares/Third_Party/LwIP/src/core/tcp_out.c \
	./Middlewares/Third_Party/LwIP/src/core/timeouts.c \
	./Middlewares/Third_Party/LwIP/src/core/udp.c \
	./Middlewares/Third_Party/LwIP/src/apps/mqtt/mqtt.c \
	./Middlewares/Third_Party/LwIP/src/apps/http/fs.c \
	./Middlewares/Third_Party/LwIP/src/apps/http/httpd.c \
	./Middlewares/Third_Party/LwIP/src/api/api_lib.c \
	./Middlewares/Third_Party/LwIP/src/api/api_msg.c \
	./Middlewares/Third_Party/LwIP/src/api/err.c \
	./Middlewares/Third_Party/LwIP/src/api/if_api.c \
	./Middlewares/Third_Party/LwIP/src/api/netbuf.c \
	./Middlewares/Third_Party/LwIP/src/api/netdb.c \
	./Middlewares/Third_Party/LwIP/src/api/netifapi.c \
	./Middlewares/Third_Party/LwIP/src/api/sockets.c \
	./Middlewares/Third_Party/LwIP/src/api/tcpip.c \
	./Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.c \
	./Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1/port.c \
	./Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2/cmsis_os2.c \
	./Middlewares/Third_Party/FreeRTOS/Source/croutine.c \
	./Middlewares/Third_Party/FreeRTOS/Source/event_groups.c \
	./Middlewares/Third_Party/FreeRTOS/Source/list.c \
	./Middlewares/Third_Party/FreeRTOS/Source/queue.c \
	./Middlewares/Third_Party/FreeRTOS/Source/stream_buffer.c \
	./Middlewares/Third_Party/FreeRTOS/Source/tasks.c \
	./Middlewares/Third_Party/FreeRTOS/Source/timers.c \
	./LWIP/Target/ethernetif.c \
	./LWIP/App/lwip.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_cortex.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_dma.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_dma_ex.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_eth.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_exti.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_flash.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_flash_ex.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_gpio.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_i2c.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_i2c_ex.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pcd.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pcd_ex.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pwr.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pwr_ex.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_rcc.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_rcc_ex.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_tim.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_tim_ex.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_uart.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_uart_ex.c \
	./Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_ll_usb.c \
	./Core/Src/freertos.c \
	./Core/Src/main.c \
	./Core/Src/stm32f7xx_hal_msp.c \
	./Core/Src/stm32f7xx_it.c \
	./Core/Src/syscalls.c \
	./Core/Src/sysmem.c \
	./Core/Src/system_stm32f7xx.c \
	./Core/Startup/startup_stm32f746zgtx.s

OBJECTS = $(patsubst %.s, %.o, $(patsubst %.c, %.o, $(SOURCES)))

all build: $(TARGET).bin

$(TARGET).bin: $(TARGET).elf
	$(CROSS)-objcopy -O binary $< $@

.c.o .s.o:
	$(CROSS)-gcc $? $(CFLAGS) -c -o $@

$(TARGET).elf: $(OBJECTS)
	$(CROSS)-gcc $(OBJECTS) $(LDFLAGS) -o $@

# Note: on "unknown chip id" flash error, wire BOOT0 to VDD and st-flash erase
flash: $(TARGET).bin
	st-flash --reset write $(TARGET).bin 0x8000000

clean:
	@rm -rf $(TARGET).* $(OBJECTS) *.su
