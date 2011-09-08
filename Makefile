#
# myapps/tlc59108-driver/Makefile
#

#.PHONY: build clean

TARGET_FILE = tlc59108-i2c
#TEST_SCRIPT = s6omap_i2c_fpga_test.sh
#SCRIPT_ROOT = s6omap_test
TARGET_DIR = ${shell pwd}
#KFLAGS=
KERNELDIR=/home/beagle/beagleboard/ti-sdk-beagleboard-05.02.00.00/psp/bbxm-kernel
CCFLAGS=ARCH=arm CROSS_COMPILE=arm-arago-linux-gnueabi-

obj-m := $(TARGET_FILE).o

build:
	echo "Building the kernel module"
	make -C $(KERNELDIR) ${CCFLAGS} M=$(TARGET_DIR) $(KFLAGS) modules
	touch built

#iinstall: build
#	$(V) $(ECHO) "Installing the module on $(FSROOT)"
#	$(V) install -D -m 644 $(TARGET_DIR)/$(TARGET_FILE).ko $(FSROOT)/$(SCRIPT_ROOT)/$(TARGET_FILE).ko $(QOUT)
#	$(V) install -D -m 755 $(TARGET_DIR)/$(TEST_SCRIPT) $(FSROOT)/$(SCRIPT_ROOT)/$(TEST_SCRIPT) $(QOUT)
#	$(V) touch installed

clean: 
	$(V) rm -rf *.symvers *.order *.ko *.debug *.o .*.d *.mod.c \
	.*.cmd .tmp_versions core *~ installed built $(QOUT)


