APP=init

all: init

clean:
	@rm -f $(APP) $(APP).o

%.o :%.asm
	@nasm -f elf64 -g $< -o $@

$(APP): $(APP).o
	@ld -g $< -o $@
	@strip $@
