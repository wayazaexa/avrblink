CC := avr-gcc
LD := avr-ld
OBJCOPY := avr-objcopy
OBJISP := avrdude
PORT := /dev/ttyACM0 # För att kunna flasha måste detta kopplas till den port arduinon är inkopplad till
# På Linux kan man hitta det genom att köra kommandot <sudo dmesg | grep tty>
# På Windows får man nog kolla i device managern/enhetshanteraren, och det ser ut så här för COM3 som ett exempel: PORT := \\\\.\\COM3

MCU := atmega328p

CFLAGS := -Wall -Wextra  -Wundef -pedantic \
		-Os -std=gnu99 -DF_CPU=16000000UL -mmcu=${MCU}
LDFLAGS := -mmcu=$(MCU)

BIN := program.hex
SOURCES := main.c
OBJS := $(SOURCES:.c=.o)

all: $(BIN)

%.o:%.c
	$(COMPILE.c) -MD -o $@ $<

%.elf: $(OBJS)
	$(CC) -Wl,-Map=$(@:.elf=.map) $(LDFLAGS) -o $@ $^

%.hex: %.elf
	$(OBJCOPY) -O ihex -R .fuse -R .lock -R .user_signatures -R .comment $< $@

# Med detta kan man använda avrdude till att flasha vår hex-fil till en inkopplad arduino uno
isp: ${BIN}
	$(OBJISP) -F -V -c arduino -p ${MCU} -P ${PORT} -U flash:w:$<

clean:
	@rm -f $(BIN) $(OBJS) *.map *.P *.d
