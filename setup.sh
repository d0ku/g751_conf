#!/bin/bash

# Set audio output options
export QEMU_AUDIO_DRV=pa
export QEMU_PA_SERVER="pulseaudio.socket"
export QEMU_AUDIO_TIMER_PERIOD=500

# Use command below to generate a MAC address
# printf '52:54:BE:EF:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256))

#  -mem-path /dev/hugepages \
#  -mem-prealloc \

#  -vcpu vcpunum=0,affinity=1 -vcpu vcpunum=1,affinity=5 \
#  -vcpu vcpunum=2,affinity=2 -vcpu vcpunum=3,affinity=6 \
#  -vcpu vcpunum=4,affinity=3 -vcpu vcpunum=5,affinity=7 \

#romfile=MyGPU.rom \

#-device qxl,bus=pcie.0,addr=1c.4,id=video.2 \


# Refer https://github.com/saveriomiroddi/qemu-pinning for how to set your cpu affinity properly
qemu-system-x86_64 \
  -name "Windows10-QEMU" \
  -machine type=q35,accel=kvm \
  -global ICH9-LPC.disable_s3=1 \
  -global ICH9-LPC.disable_s4=1 \
  -enable-kvm \
  -cpu host,kvm=off,hv_vapic,hv_relaxed,hv_spinlocks=0x1fff,hv_time,hv_vendor_id=12alphanum \
  -smp 6,sockets=1,cores=3,threads=2 \
  -m 8G \
  -rtc clock=host,base=localtime \
  -device ich9-intel-hda -device hda-output \
  -vga qxl \
  -nographic \
  -balloon none \
  -serial none \
  -parallel none \
  -k en-us \
  -spice port=5901,addr=127.0.0.1,disable-ticketing \
  -usb \
  -device ioh3420,bus=pcie.0,addr=1c.0,multifunction=on,port=1,chassis=1,id=root.1 \
  -device vfio-pci,host=01:00.0,bus=root.1,addr=00.0,x-pci-sub-device-id=0x171d,x-pci-sub-vendor-id=0x1043,multifunction=on \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/ovmf/x64/OVMF_CODE.fd \
  -drive if=pflash,format=raw,file=WIN_VARS.fd \
  -boot menu=on \
  -boot order=c \
  -drive id=disk0,if=virtio,cache=none,format=raw,file=WindowsVM.img \
  -drive file=win10.iso,index=1,media=cdrom \
  -drive file=virtio_win_drivers_new.iso,index=2,media=cdrom \
  -netdev type=tap,id=net0,ifname=tap0,script=tap_ifup,downscript=tap_ifdown,vhost=on \
  -device virtio-net-pci,netdev=net0,addr=19.0,mac="52:54:BE:EF:4F:54" \
  -device pci-bridge,addr=12.0,chassis_nr=2,id=head.2 \
  -device usb-tablet
  
# The -device usb-tablet will not be accurate regarding the pointer in some cases, another option is to use 
# -device virtio-keyboard-pci,bus=head.2,addr=03.0,display=video.2 \
# -device virtio-mouse-pci,bus=head.2,addr=04.0,display=video.2 \
