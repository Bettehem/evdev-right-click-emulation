CC := gcc
XFLAGS := -Wall -std=c11 -D_POSIX_C_SOURCE=199309L

# Use pkg-config to get the flags for libevdev
LIBS := $(shell pkg-config --libs libevdev)
CFLAGS := $(XFLAGS) $(shell pkg-config --cflags libevdev)

OUTDIR := out
SOURCES := uinput.c input.c rce.c
OBJS := $(SOURCES:%.c=$(OUTDIR)/%.o)
TARGET := $(OUTDIR)/evdev-rce

.PHONY: all clean

$(OUTDIR)/%.o: %.c
	@mkdir -p $(OUTDIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $^ $(LIBS) -o $@

all: $(TARGET)
clean:
	rm -rf $(OUTDIR)
