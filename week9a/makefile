
COMPILER    = as
LINKER      = ld
DEBUG_FLAGS = -g
TARGET      = testing_io

# Find all .s files in the current directory
ASM_SRCS := $(wildcard *.s)
# Generate corresponding .o filenames
ASM_OBJS := $(ASM_SRCS:.s=.o)

all: $(TARGET)

debug: CFLAGS += $(DEBUG_FLAGS)
debug: $(TARGET)

$(TARGET): $(ASM_OBJS)
	$(LINKER) -o $@ $^

%.o: %.s
	$(COMPILER) $(CFLAGS) -o $@ $<

clean:
	rm -f $(TARGET)
	rm -f *.o

.PHONY: all debug clean