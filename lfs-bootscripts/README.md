# LFS Bootscripts

This plan is taken from http://www.linuxfromscratch.org/lfs/view/stable/chapter07/bootscripts.html

## Usage

On the ending system execute ```hab pkg exec core/lfs-bootscripts make -C $(hab pkg path core/lfs-bootscripts) install```.

This will install and link all the scripts requred to setup the boot process on a new linux system.
