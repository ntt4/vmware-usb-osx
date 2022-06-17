devices:
	diskutil list

esxi.img.dmg:
	hdiutil convert exsi.iso -format UDRW -o esxi.img

vmware: esxi.img.dmg
	# Format USB device as a bootable MS-DOS volume
	diskutil unmountDisk /dev/disk$(DISK)
	diskutil eraseDisk MS-DOS ESXI MBR /dev/disk$(DISK)
	# Mount USB device to add syslinux.cfg
	mkdir -p source
	mkdir -p target
	hdiutil attach ./exsi.iso -mountroot ./source
	cp -r source/ /Volumes/ESXI/
	cp syslinux.cfg /Volumes/ESXI/
	hdiutil detach ./source/*
	diskutil unmountDisk /dev/disk$(DISK)
	diskutil eject /dev/disk$(DISK)
	rm -rf ./source
	rm -rf ./target
	rm ./exsi.img.dmg
