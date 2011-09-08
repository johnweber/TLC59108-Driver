#
# myapps/tlc59108-driver/Makefile
#

.PHONY: build install clean

TARGET_FILE = tlc59108-i2c
TEST_SCRIPT = tlc59108_i2c_test.sh
TARGET_DIR = ${shell pwd}
#KFLAGS=
KERNELDIR=/home/beagle/beagleboard/ti-sdk-beagleboard-05.02.00.00/psp/bbxm-kernel
CCFLAGS=ARCH=arm CROSS_COMPILE=arm-arago-linux-gnueabi-
FSROOT=/home/beagle/beagleboard/ti-sdk-beagleboard-05.02.00.00/targetNFS

obj-m := $(TARGET_FILE).o

build:
	echo "Building the kernel module"
	make -C $(KERNELDIR) ${CCFLAGS} M=$(TARGET_DIR) $(KFLAGS) modules
	touch built

install: build
	echo "Installing the module on $(FSROOT)"
	install -D -m 644 $(TARGET_DIR)/$(TARGET_FILE).ko $(FSROOT)/$(TARGET_FILE).ko 
	install -D -m 755 $(TARGET_DIR)/$(TEST_SCRIPT) $(FSROOT)/$(TEST_SCRIPT)
	touch installed

clean: 
	$(V) rm -rf *.symvers *.order *.ko *.debug *.o .*.d *.mod.c \
	.*.cmd .tmp_versions core *~ installed built $(QOUT)


