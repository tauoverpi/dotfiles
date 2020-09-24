#!/bin/sh
SPICE_PORT=5924
qemu-system-x86_64 -enable-kvm -daemonize \
    -cpu host \
    -drive file=img/win.img,if=virtio \
    -net nic -net user,hostname=windowsvm \
    -m 8G \
    -soundhw all \
    -vga qxl \
    -spice port=${SPICE_PORT},disable-ticketing \
    -usbdevice tablet \
    -device virtio-serial \
    -chardev spicevmc,id=vdagent,name=vdagent \
    -device virtserialport,chardev=vdagent,name=com.redhat.spice.0 \
    "$@"
exec spicy --title Windows 127.0.0.1 -p ${SPICE_PORT}
