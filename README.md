# ASUS G751JM config for Linux

## GPU Passthrough

I have followed great tutorial by [@misairu_g](https://github.com/Misairu-G). It is available [here](https://gist.github.com/Misairu-G/616f7b2756c488148b7309addc940b28).

##### Files

virtio\_win\_drivers\_new.iso - Virtio drivers for windows. You can get them [here](https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html). You will want to direct download in most cases.

win10.iso - Windows Installation Image. You have to get one yourself, read more in tutorial linked above.

WindowsVM.img - Windows VM hard drive. You have to create one yourself, read more in tutorial linked above.

tap\_ifdown - Tearing down network after VM is closed (authored by [@misairu_g](https://github.com/Misairu-G))

tap\_ifup - Setting up network for VM when it starts  (authored by [@misairu_g](https://github.com/Misairu-G))

### How to use

Project is currently not one of my focus objects.

After you have finally set up everything to suit your PC you just have to run ./complete.sh (with sudo) and it will take care of everything.


## Temperature control

TODO
