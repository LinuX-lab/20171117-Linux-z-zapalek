HERE=$(shell pwd)

CONFIGS=$(HERE)/_konfiguracje

KERNEL_SRC=$(HERE)/kernel-src
KERNEL_BIN=$(HERE)/kernel-bin
KERNEL_OUT=$(HERE)/kernel-out

BB_SRC=$(HERE)/busybox-src
BB_BIN=$(HERE)/busybox-bin
BB_OUT=$(HERE)/busybox-out

# Pobranie źródeł z GIT

prepare-sources: $(KERNEL_BIN)/Makefile $(BB_BIN)/Makefile

$(KERNEL_SRC)/Makefile:
	git submodule update --init --checkout kernel-src


$(BB_SRC)/Makefile:
	git submodule update --init --checkout busybox-src

# Przygotowanie katalogów out-of-tree
$(KERNEL_BIN)/Makefile: $(KERNEL_SRC)/Makefile
	@mkdir -p $(KERNEL_BIN)
	@cd $(KERNEL_SRC) ; make O=$(KERNEL_BIN) allnoconfig
	@cp $(CONFIGS)/kernel.config $(KERNEL_BIN)/.config

$(BB_BIN)/Makefile: $(BB_SRC)/Makefile
	@mkdir -p $(BB_BIN)
	@cd $(BB_SRC) ; make O=$(BB_BIN) allnoconfig
	@cp $(CONFIGS)/busybox.config $(BB_BIN)/.config
