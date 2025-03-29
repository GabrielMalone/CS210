# Configurable variables
PROGRAM  = print_reg
SOURCE   = print_reg.s
OBJECT   = $(SOURCE:.s=.o)
AS       = as
ASFLAGS  = 
LD       = ld
LDFLAGS  = 

# Default target
all: $(PROGRAM)

# Link the object file to create the executable
$(PROGRAM): $(OBJECT)
	$(LD) $(LDFLAGS) -o $@ $^

# Assemble the source file to create the object file
%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

# Debug build rule
debug: ASFLAGS += -g
debug: $(PROGRAM)

# Clean up generated files
clean:
	rm -f $(PROGRAM) $(OBJECT)

.PHONY: all debug clean