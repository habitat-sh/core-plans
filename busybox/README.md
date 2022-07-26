[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.busybox?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=200&branchName=master)

# busybox

BusyBox combines tiny versions of many common UNIX utilities into a single small executable. It provides replacements for most of the utilities you usually find in GNU fileutils, shellutils, etc. It provides a fairly complete environment for any small or embedded system.  See [documentation](https://www.busybox.net)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/busybox as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/busybox)

##### Runtime dependency

> pkg_deps=(core/busybox)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/busybox --binlink``

will add the following binaries to the PATH:

* /bin/[
* /bin/[[
* /bin/acpid
* /bin/add-shell
* /bin/addgroup
* /bin/adduser
* /bin/adjtimex
* /bin/arch
* /bin/arp
* /bin/arping
* /bin/ash
* /bin/awk
* /bin/base64
* /bin/basename
* /bin/bc
* /bin/beep
* /bin/blkdiscard
* /bin/blkid
* /bin/blockdev
* /bin/bootchartd
* /bin/brctl
* /bin/bunzip2
* /bin/busybox
* /bin/bzcat
* /bin/bzip2
* /bin/cal
* /bin/cat
* /bin/chat
* /bin/chattr
* /bin/chgrp
* /bin/chmod
* /bin/chown
* /bin/chpasswd
* /bin/chpst
* /bin/chroot
* /bin/chrt
* /bin/chvt
* /bin/cksum
* /bin/clear
* /bin/cmp
* /bin/comm
* /bin/conspy
* /bin/cp
* /bin/cpio
* /bin/crond
* /bin/crontab
* /bin/cryptpw
* /bin/cttyhack
* /bin/cut
* /bin/date
* /bin/dc
* /bin/dd
* /bin/deallocvt
* /bin/delgroup
* /bin/deluser
* /bin/depmod
* /bin/devmem
* /bin/df
* /bin/dhcprelay
* /bin/diff
* /bin/dirname
* /bin/dmesg
* /bin/dnsd
* /bin/dnsdomainname
* /bin/dos2unix
* /bin/dpkg
* /bin/dpkg-deb
* /bin/du
* /bin/dumpkmap
* /bin/dumpleases
* /bin/echo
* /bin/ed
* /bin/egrep
* /bin/eject
* /bin/env
* /bin/envdir
* /bin/envuidgid
* /bin/ether-wake
* /bin/expand
* /bin/expr
* /bin/factor
* /bin/fakeidentd
* /bin/fallocate
* /bin/false
* /bin/fatattr
* /bin/fbset
* /bin/fbsplash
* /bin/fdflush
* /bin/fdformat
* /bin/fdisk
* /bin/fgconsole
* /bin/fgrep
* /bin/find
* /bin/findfs
* /bin/flock
* /bin/fold
* /bin/free
* /bin/freeramdisk
* /bin/fsck
* /bin/fsck.minix
* /bin/fsfreeze
* /bin/fstrim
* /bin/fsync
* /bin/ftpd
* /bin/ftpget
* /bin/ftpput
* /bin/fuser
* /bin/getopt
* /bin/getty
* /bin/grep
* /bin/groups
* /bin/gunzip
* /bin/gzip
* /bin/halt
* /bin/hd
* /bin/hdparm
* /bin/head
* /bin/hexdump
* /bin/hexedit
* /bin/hostid
* /bin/hostname
* /bin/httpd
* /bin/hush
* /bin/hwclock
* /bin/i2cdetect
* /bin/i2cdump
* /bin/i2cget
* /bin/i2cset
* /bin/i2ctransfer
* /bin/id
* /bin/ifconfig
* /bin/ifdown
* /bin/ifenslave
* /bin/ifplugd
* /bin/ifup
* /bin/inetd
* /bin/init
* /bin/insmod
* /bin/install
* /bin/ionice
* /bin/iostat
* /bin/ip
* /bin/ipaddr
* /bin/ipcalc
* /bin/ipcrm
* /bin/ipcs
* /bin/iplink
* /bin/ipneigh
* /bin/iproute
* /bin/iprule
* /bin/iptunnel
* /bin/kbd_mode
* /bin/kill
* /bin/killall
* /bin/killall5
* /bin/klogd
* /bin/last
* /bin/less
* /bin/link
* /bin/linux32
* /bin/linux64
* /bin/linuxrc
* /bin/ln
* /bin/loadfont
* /bin/loadkmap
* /bin/logger
* /bin/login
* /bin/logname
* /bin/logread
* /bin/losetup
* /bin/lpd
* /bin/lpq
* /bin/lpr
* /bin/ls
* /bin/lsattr
* /bin/lsmod
* /bin/lsof
* /bin/lspci
* /bin/lsscsi
* /bin/lsusb
* /bin/lzcat
* /bin/lzma
* /bin/lzop
* /bin/makedevs
* /bin/makemime
* /bin/man
* /bin/md5sum
* /bin/mdev
* /bin/mesg
* /bin/microcom
* /bin/mkdir
* /bin/mkdosfs
* /bin/mke2fs
* /bin/mkfifo
* /bin/mkfs.ext2
* /bin/mkfs.minix
* /bin/mkfs.vfat
* /bin/mknod
* /bin/mkpasswd
* /bin/mkswap
* /bin/mktemp
* /bin/modinfo
* /bin/modprobe
* /bin/more
* /bin/mount
* /bin/mountpoint
* /bin/mpstat
* /bin/mt
* /bin/mv
* /bin/nameif
* /bin/nanddump
* /bin/nandwrite
* /bin/nbd-client
* /bin/nc
* /bin/netstat
* /bin/nice
* /bin/nl
* /bin/nmeter
* /bin/nohup
* /bin/nologin
* /bin/nproc
* /bin/nsenter
* /bin/nslookup
* /bin/ntpd
* /bin/nuke
* /bin/od
* /bin/openvt
* /bin/partprobe
* /bin/passwd
* /bin/paste
* /bin/patch
* /bin/pgrep
* /bin/pidof
* /bin/ping
* /bin/ping6
* /bin/pipe_progress
* /bin/pivot_root
* /bin/pkill
* /bin/pmap
* /bin/popmaildir
* /bin/poweroff
* /bin/powertop
* /bin/printenv
* /bin/printf
* /bin/ps
* /bin/pscan
* /bin/pstree
* /bin/pwd
* /bin/pwdx
* /bin/raidautorun
* /bin/rdate
* /bin/rdev
* /bin/readahead
* /bin/readlink
* /bin/readprofile
* /bin/realpath
* /bin/reboot
* /bin/reformime
* /bin/remove-shell
* /bin/renice
* /bin/reset
* /bin/resize
* /bin/resume
* /bin/rev
* /bin/rm
* /bin/rmdir
* /bin/rmmod
* /bin/route
* /bin/rpm
* /bin/rpm2cpio
* /bin/rtcwake
* /bin/run-init
* /bin/run-parts
* /bin/runlevel
* /bin/runsv
* /bin/runsvdir
* /bin/rx
* /bin/script
* /bin/scriptreplay
* /bin/sed
* /bin/sendmail
* /bin/seq
* /bin/setarch
* /bin/setconsole
* /bin/setfattr
* /bin/setfont
* /bin/setkeycodes
* /bin/setlogcons
* /bin/setpriv
* /bin/setserial
* /bin/setsid
* /bin/setuidgid
* /bin/sha1sum
* /bin/sha256sum
* /bin/sha3sum
* /bin/sha512sum
* /bin/showkey
* /bin/shred
* /bin/shuf
* /bin/slattach
* /bin/sleep
* /bin/smemcap
* /bin/softlimit
* /bin/sort
* /bin/split
* /bin/ssl_client
* /bin/start-stop-daemon
* /bin/stat
* /bin/strings
* /bin/stty
* /bin/su
* /bin/sulogin
* /bin/sum
* /bin/sv
* /bin/svc
* /bin/svlogd
* /bin/svok
* /bin/swapoff
* /bin/swapon
* /bin/switch_root
* /bin/sync
* /bin/sysctl
* /bin/syslogd
* /bin/tac
* /bin/tail
* /bin/tar
* /bin/taskset
* /bin/tc
* /bin/tcpsvd
* /bin/tee
* /bin/telnet
* /bin/telnetd
* /bin/test
* /bin/tftp
* /bin/tftpd
* /bin/time
* /bin/timeout
* /bin/top
* /bin/touch
* /bin/tr
* /bin/traceroute
* /bin/traceroute6
* /bin/true
* /bin/truncate
* /bin/ts
* /bin/tty
* /bin/ttysize
* /bin/tunctl
* /bin/ubiattach
* /bin/ubidetach
* /bin/ubimkvol
* /bin/ubirename
* /bin/ubirmvol
* /bin/ubirsvol
* /bin/ubiupdatevol
* /bin/udhcpc
* /bin/udhcpd
* /bin/udpsvd
* /bin/uevent
* /bin/umount
* /bin/uname
* /bin/unexpand
* /bin/uniq
* /bin/unix2dos
* /bin/unlink
* /bin/unlzma
* /bin/unshare
* /bin/unxz
* /bin/unzip
* /bin/uptime
* /bin/users
* /bin/usleep
* /bin/uudecode
* /bin/uuencode
* /bin/vconfig
* /bin/vi
* /bin/vlock
* /bin/volname
* /bin/w
* /bin/wall
* /bin/watch
* /bin/watchdog
* /bin/wc
* /bin/wget
* /bin/which
* /bin/who
* /bin/whoami
* /bin/whois
* /bin/xargs
* /bin/xxd
* /bin/xz
* /bin/xzcat
* /bin/yes
* /bin/zcat
* /bin/zcip


For example:

```bash
$ hab pkg install core/busybox --binlink
» Installing core/busybox
☁ Determining latest version of core/busybox in the 'stable' channel
→ Found newer installed version (core/busybox/1.31.0/20200817115148) than remote version (core/busybox/1.31.0/20200404023946)
→ Using core/busybox/1.31.0/20200817115148
★ Install of core/busybox/1.31.0/20200817115148 complete with 0 new packages installed.
» Binlinking true from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked true from core/busybox/1.31.0/20200817115148 to /bin/true
» Binlinking udpsvd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked udpsvd from core/busybox/1.31.0/20200817115148 to /bin/udpsvd
» Binlinking cut from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked cut from core/busybox/1.31.0/20200817115148 to /bin/cut
» Binlinking hd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked hd from core/busybox/1.31.0/20200817115148 to /bin/hd
» Binlinking timeout from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked timeout from core/busybox/1.31.0/20200817115148 to /bin/timeout
» Binlinking reboot from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked reboot from core/busybox/1.31.0/20200817115148 to /bin/reboot
» Binlinking printenv from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked printenv from core/busybox/1.31.0/20200817115148 to /bin/printenv
» Binlinking rmmod from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked rmmod from core/busybox/1.31.0/20200817115148 to /bin/rmmod
» Binlinking getty from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked getty from core/busybox/1.31.0/20200817115148 to /bin/getty
» Binlinking makedevs from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked makedevs from core/busybox/1.31.0/20200817115148 to /bin/makedevs
» Binlinking swapoff from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked swapoff from core/busybox/1.31.0/20200817115148 to /bin/swapoff
» Binlinking pwdx from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked pwdx from core/busybox/1.31.0/20200817115148 to /bin/pwdx
» Binlinking zcat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked zcat from core/busybox/1.31.0/20200817115148 to /bin/zcat
» Binlinking klogd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked klogd from core/busybox/1.31.0/20200817115148 to /bin/klogd
» Binlinking blkid from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked blkid from core/busybox/1.31.0/20200817115148 to /bin/blkid
» Binlinking cmp from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked cmp from core/busybox/1.31.0/20200817115148 to /bin/cmp
» Binlinking mpstat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mpstat from core/busybox/1.31.0/20200817115148 to /bin/mpstat
» Binlinking ipcrm from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ipcrm from core/busybox/1.31.0/20200817115148 to /bin/ipcrm
» Binlinking ntpd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ntpd from core/busybox/1.31.0/20200817115148 to /bin/ntpd
» Binlinking mountpoint from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mountpoint from core/busybox/1.31.0/20200817115148 to /bin/mountpoint
» Binlinking setsid from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked setsid from core/busybox/1.31.0/20200817115148 to /bin/setsid
» Binlinking fgrep from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fgrep from core/busybox/1.31.0/20200817115148 to /bin/fgrep
» Binlinking runsv from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked runsv from core/busybox/1.31.0/20200817115148 to /bin/runsv
» Binlinking fdformat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fdformat from core/busybox/1.31.0/20200817115148 to /bin/fdformat
» Binlinking split from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked split from core/busybox/1.31.0/20200817115148 to /bin/split
» Binlinking chroot from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked chroot from core/busybox/1.31.0/20200817115148 to /bin/chroot
» Binlinking swapon from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked swapon from core/busybox/1.31.0/20200817115148 to /bin/swapon
» Binlinking nslookup from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nslookup from core/busybox/1.31.0/20200817115148 to /bin/nslookup
» Binlinking unzip from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked unzip from core/busybox/1.31.0/20200817115148 to /bin/unzip
» Binlinking softlimit from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked softlimit from core/busybox/1.31.0/20200817115148 to /bin/softlimit
» Binlinking mdev from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mdev from core/busybox/1.31.0/20200817115148 to /bin/mdev
» Binlinking findfs from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked findfs from core/busybox/1.31.0/20200817115148 to /bin/findfs
» Binlinking fbset from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fbset from core/busybox/1.31.0/20200817115148 to /bin/fbset
» Binlinking fakeidentd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fakeidentd from core/busybox/1.31.0/20200817115148 to /bin/fakeidentd
» Binlinking last from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked last from core/busybox/1.31.0/20200817115148 to /bin/last
» Binlinking awk from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked awk from core/busybox/1.31.0/20200817115148 to /bin/awk
» Binlinking stat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked stat from core/busybox/1.31.0/20200817115148 to /bin/stat
» Binlinking sh from core/busybox/1.31.0/20200817115148 into /bin
Ø Skipping binlink because sh already exists at /bin/sh. Use --force to overwrite
» Binlinking reformime from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked reformime from core/busybox/1.31.0/20200817115148 to /bin/reformime
» Binlinking gunzip from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked gunzip from core/busybox/1.31.0/20200817115148 to /bin/gunzip
» Binlinking sendmail from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sendmail from core/busybox/1.31.0/20200817115148 to /bin/sendmail
» Binlinking ipcalc from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ipcalc from core/busybox/1.31.0/20200817115148 to /bin/ipcalc
» Binlinking watch from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked watch from core/busybox/1.31.0/20200817115148 to /bin/watch
» Binlinking arch from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked arch from core/busybox/1.31.0/20200817115148 to /bin/arch
» Binlinking bzip2 from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked bzip2 from core/busybox/1.31.0/20200817115148 to /bin/bzip2
» Binlinking paste from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked paste from core/busybox/1.31.0/20200817115148 to /bin/paste
» Binlinking fold from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fold from core/busybox/1.31.0/20200817115148 to /bin/fold
» Binlinking seq from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked seq from core/busybox/1.31.0/20200817115148 to /bin/seq
» Binlinking users from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked users from core/busybox/1.31.0/20200817115148 to /bin/users
» Binlinking patch from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked patch from core/busybox/1.31.0/20200817115148 to /bin/patch
» Binlinking chat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked chat from core/busybox/1.31.0/20200817115148 to /bin/chat
» Binlinking uudecode from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked uudecode from core/busybox/1.31.0/20200817115148 to /bin/uudecode
» Binlinking tac from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked tac from core/busybox/1.31.0/20200817115148 to /bin/tac
» Binlinking crond from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked crond from core/busybox/1.31.0/20200817115148 to /bin/crond
» Binlinking nandwrite from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nandwrite from core/busybox/1.31.0/20200817115148 to /bin/nandwrite
» Binlinking dhcprelay from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dhcprelay from core/busybox/1.31.0/20200817115148 to /bin/dhcprelay
» Binlinking setlogcons from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked setlogcons from core/busybox/1.31.0/20200817115148 to /bin/setlogcons
» Binlinking free from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked free from core/busybox/1.31.0/20200817115148 to /bin/free
» Binlinking xz from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked xz from core/busybox/1.31.0/20200817115148 to /bin/xz
» Binlinking renice from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked renice from core/busybox/1.31.0/20200817115148 to /bin/renice
» Binlinking crontab from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked crontab from core/busybox/1.31.0/20200817115148 to /bin/crontab
» Binlinking bunzip2 from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked bunzip2 from core/busybox/1.31.0/20200817115148 to /bin/bunzip2
» Binlinking ubirename from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ubirename from core/busybox/1.31.0/20200817115148 to /bin/ubirename
» Binlinking ts from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ts from core/busybox/1.31.0/20200817115148 to /bin/ts
» Binlinking rdev from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked rdev from core/busybox/1.31.0/20200817115148 to /bin/rdev
» Binlinking ip from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ip from core/busybox/1.31.0/20200817115148 to /bin/ip
» Binlinking setarch from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked setarch from core/busybox/1.31.0/20200817115148 to /bin/setarch
» Binlinking microcom from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked microcom from core/busybox/1.31.0/20200817115148 to /bin/microcom
» Binlinking arp from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked arp from core/busybox/1.31.0/20200817115148 to /bin/arp
» Binlinking od from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked od from core/busybox/1.31.0/20200817115148 to /bin/od
» Binlinking diff from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked diff from core/busybox/1.31.0/20200817115148 to /bin/diff
» Binlinking modinfo from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked modinfo from core/busybox/1.31.0/20200817115148 to /bin/modinfo
» Binlinking nologin from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nologin from core/busybox/1.31.0/20200817115148 to /bin/nologin
» Binlinking cttyhack from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked cttyhack from core/busybox/1.31.0/20200817115148 to /bin/cttyhack
» Binlinking taskset from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked taskset from core/busybox/1.31.0/20200817115148 to /bin/taskset
» Binlinking loadkmap from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked loadkmap from core/busybox/1.31.0/20200817115148 to /bin/loadkmap
» Binlinking echo from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked echo from core/busybox/1.31.0/20200817115148 to /bin/echo
» Binlinking ssl_client from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ssl_client from core/busybox/1.31.0/20200817115148 to /bin/ssl_client
» Binlinking kill from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked kill from core/busybox/1.31.0/20200817115148 to /bin/kill
» Binlinking fsync from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fsync from core/busybox/1.31.0/20200817115148 to /bin/fsync
» Binlinking pstree from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked pstree from core/busybox/1.31.0/20200817115148 to /bin/pstree
» Binlinking cp from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked cp from core/busybox/1.31.0/20200817115148 to /bin/cp
» Binlinking dnsd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dnsd from core/busybox/1.31.0/20200817115148 to /bin/dnsd
» Binlinking showkey from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked showkey from core/busybox/1.31.0/20200817115148 to /bin/showkey
» Binlinking fsfreeze from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fsfreeze from core/busybox/1.31.0/20200817115148 to /bin/fsfreeze
» Binlinking init from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked init from core/busybox/1.31.0/20200817115148 to /bin/init
» Binlinking linux32 from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked linux32 from core/busybox/1.31.0/20200817115148 to /bin/linux32
» Binlinking resize from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked resize from core/busybox/1.31.0/20200817115148 to /bin/resize
» Binlinking mkdir from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mkdir from core/busybox/1.31.0/20200817115148 to /bin/mkdir
» Binlinking conspy from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked conspy from core/busybox/1.31.0/20200817115148 to /bin/conspy
» Binlinking setpriv from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked setpriv from core/busybox/1.31.0/20200817115148 to /bin/setpriv
» Binlinking ipcs from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ipcs from core/busybox/1.31.0/20200817115148 to /bin/ipcs
» Binlinking inetd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked inetd from core/busybox/1.31.0/20200817115148 to /bin/inetd
» Binlinking hush from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked hush from core/busybox/1.31.0/20200817115148 to /bin/hush
» Binlinking linux64 from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked linux64 from core/busybox/1.31.0/20200817115148 to /bin/linux64
» Binlinking nmeter from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nmeter from core/busybox/1.31.0/20200817115148 to /bin/nmeter
» Binlinking setconsole from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked setconsole from core/busybox/1.31.0/20200817115148 to /bin/setconsole
» Binlinking truncate from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked truncate from core/busybox/1.31.0/20200817115148 to /bin/truncate
» Binlinking mkswap from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mkswap from core/busybox/1.31.0/20200817115148 to /bin/mkswap
» Binlinking ln from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ln from core/busybox/1.31.0/20200817115148 to /bin/ln
» Binlinking svlogd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked svlogd from core/busybox/1.31.0/20200817115148 to /bin/svlogd
» Binlinking lsusb from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lsusb from core/busybox/1.31.0/20200817115148 to /bin/lsusb
» Binlinking df from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked df from core/busybox/1.31.0/20200817115148 to /bin/df
» Binlinking deluser from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked deluser from core/busybox/1.31.0/20200817115148 to /bin/deluser
» Binlinking xzcat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked xzcat from core/busybox/1.31.0/20200817115148 to /bin/xzcat
» Binlinking nice from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nice from core/busybox/1.31.0/20200817115148 to /bin/nice
» Binlinking ether-wake from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ether-wake from core/busybox/1.31.0/20200817115148 to /bin/ether-wake
» Binlinking shuf from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked shuf from core/busybox/1.31.0/20200817115148 to /bin/shuf
» Binlinking ping from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ping from core/busybox/1.31.0/20200817115148 to /bin/ping
» Binlinking dnsdomainname from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dnsdomainname from core/busybox/1.31.0/20200817115148 to /bin/dnsdomainname
» Binlinking ifplugd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ifplugd from core/busybox/1.31.0/20200817115148 to /bin/ifplugd
» Binlinking deallocvt from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked deallocvt from core/busybox/1.31.0/20200817115148 to /bin/deallocvt
» Binlinking printf from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked printf from core/busybox/1.31.0/20200817115148 to /bin/printf
» Binlinking linuxrc from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked linuxrc from core/busybox/1.31.0/20200817115148 to /bin/linuxrc
» Binlinking beep from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked beep from core/busybox/1.31.0/20200817115148 to /bin/beep
» Binlinking uptime from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked uptime from core/busybox/1.31.0/20200817115148 to /bin/uptime
» Binlinking lpr from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lpr from core/busybox/1.31.0/20200817115148 to /bin/lpr
» Binlinking rpm2cpio from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked rpm2cpio from core/busybox/1.31.0/20200817115148 to /bin/rpm2cpio
» Binlinking ubiattach from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ubiattach from core/busybox/1.31.0/20200817115148 to /bin/ubiattach
» Binlinking blkdiscard from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked blkdiscard from core/busybox/1.31.0/20200817115148 to /bin/blkdiscard
» Binlinking iprule from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked iprule from core/busybox/1.31.0/20200817115148 to /bin/iprule
» Binlinking iplink from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked iplink from core/busybox/1.31.0/20200817115148 to /bin/iplink
» Binlinking add-shell from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked add-shell from core/busybox/1.31.0/20200817115148 to /bin/add-shell
» Binlinking ifconfig from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ifconfig from core/busybox/1.31.0/20200817115148 to /bin/ifconfig
» Binlinking clear from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked clear from core/busybox/1.31.0/20200817115148 to /bin/clear
» Binlinking sleep from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sleep from core/busybox/1.31.0/20200817115148 to /bin/sleep
» Binlinking telnet from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked telnet from core/busybox/1.31.0/20200817115148 to /bin/telnet
» Binlinking nproc from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nproc from core/busybox/1.31.0/20200817115148 to /bin/nproc
» Binlinking script from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked script from core/busybox/1.31.0/20200817115148 to /bin/script
» Binlinking lzcat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lzcat from core/busybox/1.31.0/20200817115148 to /bin/lzcat
» Binlinking fdflush from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fdflush from core/busybox/1.31.0/20200817115148 to /bin/fdflush
» Binlinking fgconsole from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fgconsole from core/busybox/1.31.0/20200817115148 to /bin/fgconsole
» Binlinking brctl from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked brctl from core/busybox/1.31.0/20200817115148 to /bin/brctl
» Binlinking chpasswd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked chpasswd from core/busybox/1.31.0/20200817115148 to /bin/chpasswd
» Binlinking tftpd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked tftpd from core/busybox/1.31.0/20200817115148 to /bin/tftpd
» Binlinking wall from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked wall from core/busybox/1.31.0/20200817115148 to /bin/wall
» Binlinking chmod from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked chmod from core/busybox/1.31.0/20200817115148 to /bin/chmod
» Binlinking busybox from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked busybox from core/busybox/1.31.0/20200817115148 to /bin/busybox
» Binlinking loadfont from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked loadfont from core/busybox/1.31.0/20200817115148 to /bin/loadfont
» Binlinking dc from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dc from core/busybox/1.31.0/20200817115148 to /bin/dc
» Binlinking su from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked su from core/busybox/1.31.0/20200817115148 to /bin/su
» Binlinking adduser from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked adduser from core/busybox/1.31.0/20200817115148 to /bin/adduser
» Binlinking tr from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked tr from core/busybox/1.31.0/20200817115148 to /bin/tr
» Binlinking rev from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked rev from core/busybox/1.31.0/20200817115148 to /bin/rev
» Binlinking unix2dos from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked unix2dos from core/busybox/1.31.0/20200817115148 to /bin/unix2dos
» Binlinking lsscsi from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lsscsi from core/busybox/1.31.0/20200817115148 to /bin/lsscsi
» Binlinking logname from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked logname from core/busybox/1.31.0/20200817115148 to /bin/logname
» Binlinking ed from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ed from core/busybox/1.31.0/20200817115148 to /bin/ed
» Binlinking mesg from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mesg from core/busybox/1.31.0/20200817115148 to /bin/mesg
» Binlinking devmem from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked devmem from core/busybox/1.31.0/20200817115148 to /bin/devmem
» Binlinking switch_root from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked switch_root from core/busybox/1.31.0/20200817115148 to /bin/switch_root
» Binlinking umount from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked umount from core/busybox/1.31.0/20200817115148 to /bin/umount
» Binlinking iostat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked iostat from core/busybox/1.31.0/20200817115148 to /bin/iostat
» Binlinking login from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked login from core/busybox/1.31.0/20200817115148 to /bin/login
» Binlinking dpkg-deb from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dpkg-deb from core/busybox/1.31.0/20200817115148 to /bin/dpkg-deb
» Binlinking mt from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mt from core/busybox/1.31.0/20200817115148 to /bin/mt
» Binlinking rtcwake from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked rtcwake from core/busybox/1.31.0/20200817115148 to /bin/rtcwake
» Binlinking chattr from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked chattr from core/busybox/1.31.0/20200817115148 to /bin/chattr
» Binlinking shred from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked shred from core/busybox/1.31.0/20200817115148 to /bin/shred
» Binlinking expand from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked expand from core/busybox/1.31.0/20200817115148 to /bin/expand
» Binlinking egrep from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked egrep from core/busybox/1.31.0/20200817115148 to /bin/egrep
» Binlinking bc from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked bc from core/busybox/1.31.0/20200817115148 to /bin/bc
» Binlinking uname from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked uname from core/busybox/1.31.0/20200817115148 to /bin/uname
» Binlinking who from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked who from core/busybox/1.31.0/20200817115148 to /bin/who
» Binlinking ifdown from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ifdown from core/busybox/1.31.0/20200817115148 to /bin/ifdown
» Binlinking lsof from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lsof from core/busybox/1.31.0/20200817115148 to /bin/lsof
» Binlinking cal from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked cal from core/busybox/1.31.0/20200817115148 to /bin/cal
» Binlinking openvt from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked openvt from core/busybox/1.31.0/20200817115148 to /bin/openvt
» Binlinking [ from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked [ from core/busybox/1.31.0/20200817115148 to /bin/[
» Binlinking tc from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked tc from core/busybox/1.31.0/20200817115148 to /bin/tc
» Binlinking i2cget from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked i2cget from core/busybox/1.31.0/20200817115148 to /bin/i2cget
» Binlinking fbsplash from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fbsplash from core/busybox/1.31.0/20200817115148 to /bin/fbsplash
» Binlinking pkill from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked pkill from core/busybox/1.31.0/20200817115148 to /bin/pkill
» Binlinking mkdosfs from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mkdosfs from core/busybox/1.31.0/20200817115148 to /bin/mkdosfs
» Binlinking pivot_root from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked pivot_root from core/busybox/1.31.0/20200817115148 to /bin/pivot_root
» Binlinking wget from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked wget from core/busybox/1.31.0/20200817115148 to /bin/wget
» Binlinking fatattr from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fatattr from core/busybox/1.31.0/20200817115148 to /bin/fatattr
» Binlinking uniq from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked uniq from core/busybox/1.31.0/20200817115148 to /bin/uniq
» Binlinking raidautorun from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked raidautorun from core/busybox/1.31.0/20200817115148 to /bin/raidautorun
» Binlinking chrt from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked chrt from core/busybox/1.31.0/20200817115148 to /bin/chrt
» Binlinking fsck.minix from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fsck.minix from core/busybox/1.31.0/20200817115148 to /bin/fsck.minix
» Binlinking bootchartd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked bootchartd from core/busybox/1.31.0/20200817115148 to /bin/bootchartd
» Binlinking find from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked find from core/busybox/1.31.0/20200817115148 to /bin/find
» Binlinking nbd-client from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nbd-client from core/busybox/1.31.0/20200817115148 to /bin/nbd-client
» Binlinking basename from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked basename from core/busybox/1.31.0/20200817115148 to /bin/basename
» Binlinking i2cdump from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked i2cdump from core/busybox/1.31.0/20200817115148 to /bin/i2cdump
» Binlinking arping from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked arping from core/busybox/1.31.0/20200817115148 to /bin/arping
» Binlinking nl from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nl from core/busybox/1.31.0/20200817115148 to /bin/nl
» Binlinking eject from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked eject from core/busybox/1.31.0/20200817115148 to /bin/eject
» Binlinking lzop from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lzop from core/busybox/1.31.0/20200817115148 to /bin/lzop
» Binlinking mkfs.vfat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mkfs.vfat from core/busybox/1.31.0/20200817115148 to /bin/mkfs.vfat
» Binlinking chown from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked chown from core/busybox/1.31.0/20200817115148 to /bin/chown
» Binlinking route from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked route from core/busybox/1.31.0/20200817115148 to /bin/route
» Binlinking ttysize from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ttysize from core/busybox/1.31.0/20200817115148 to /bin/ttysize
» Binlinking tail from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked tail from core/busybox/1.31.0/20200817115148 to /bin/tail
» Binlinking ash from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ash from core/busybox/1.31.0/20200817115148 to /bin/ash
» Binlinking rm from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked rm from core/busybox/1.31.0/20200817115148 to /bin/rm
» Binlinking syslogd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked syslogd from core/busybox/1.31.0/20200817115148 to /bin/syslogd
» Binlinking lpq from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lpq from core/busybox/1.31.0/20200817115148 to /bin/lpq
» Binlinking nc from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nc from core/busybox/1.31.0/20200817115148 to /bin/nc
» Binlinking tar from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked tar from core/busybox/1.31.0/20200817115148 to /bin/tar
» Binlinking rpm from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked rpm from core/busybox/1.31.0/20200817115148 to /bin/rpm
» Binlinking ifup from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ifup from core/busybox/1.31.0/20200817115148 to /bin/ifup
» Binlinking fdisk from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fdisk from core/busybox/1.31.0/20200817115148 to /bin/fdisk
» Binlinking hwclock from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked hwclock from core/busybox/1.31.0/20200817115148 to /bin/hwclock
» Binlinking halt from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked halt from core/busybox/1.31.0/20200817115148 to /bin/halt
» Binlinking sha1sum from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sha1sum from core/busybox/1.31.0/20200817115148 to /bin/sha1sum
» Binlinking cryptpw from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked cryptpw from core/busybox/1.31.0/20200817115148 to /bin/cryptpw
» Binlinking ubiupdatevol from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ubiupdatevol from core/busybox/1.31.0/20200817115148 to /bin/ubiupdatevol
» Binlinking comm from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked comm from core/busybox/1.31.0/20200817115148 to /bin/comm
» Binlinking killall from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked killall from core/busybox/1.31.0/20200817115148 to /bin/killall
» Binlinking readlink from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked readlink from core/busybox/1.31.0/20200817115148 to /bin/readlink
» Binlinking killall5 from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked killall5 from core/busybox/1.31.0/20200817115148 to /bin/killall5
» Binlinking ps from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ps from core/busybox/1.31.0/20200817115148 to /bin/ps
» Binlinking mktemp from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mktemp from core/busybox/1.31.0/20200817115148 to /bin/mktemp
» Binlinking unshare from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked unshare from core/busybox/1.31.0/20200817115148 to /bin/unshare
» Binlinking sha256sum from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sha256sum from core/busybox/1.31.0/20200817115148 to /bin/sha256sum
» Binlinking sed from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sed from core/busybox/1.31.0/20200817115148 to /bin/sed
» Binlinking ipneigh from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ipneigh from core/busybox/1.31.0/20200817115148 to /bin/ipneigh
» Binlinking ubimkvol from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ubimkvol from core/busybox/1.31.0/20200817115148 to /bin/ubimkvol
» Binlinking yes from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked yes from core/busybox/1.31.0/20200817115148 to /bin/yes
» Binlinking du from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked du from core/busybox/1.31.0/20200817115148 to /bin/du
» Binlinking mv from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mv from core/busybox/1.31.0/20200817115148 to /bin/mv
» Binlinking runsvdir from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked runsvdir from core/busybox/1.31.0/20200817115148 to /bin/runsvdir
» Binlinking sort from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sort from core/busybox/1.31.0/20200817115148 to /bin/sort
» Binlinking lsattr from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lsattr from core/busybox/1.31.0/20200817115148 to /bin/lsattr
» Binlinking nohup from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nohup from core/busybox/1.31.0/20200817115148 to /bin/nohup
» Binlinking link from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked link from core/busybox/1.31.0/20200817115148 to /bin/link
» Binlinking top from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked top from core/busybox/1.31.0/20200817115148 to /bin/top
» Binlinking slattach from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked slattach from core/busybox/1.31.0/20200817115148 to /bin/slattach
» Binlinking freeramdisk from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked freeramdisk from core/busybox/1.31.0/20200817115148 to /bin/freeramdisk
» Binlinking dumpkmap from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dumpkmap from core/busybox/1.31.0/20200817115148 to /bin/dumpkmap
» Binlinking factor from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked factor from core/busybox/1.31.0/20200817115148 to /bin/factor
» Binlinking sysctl from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sysctl from core/busybox/1.31.0/20200817115148 to /bin/sysctl
» Binlinking flock from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked flock from core/busybox/1.31.0/20200817115148 to /bin/flock
» Binlinking smemcap from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked smemcap from core/busybox/1.31.0/20200817115148 to /bin/smemcap
» Binlinking mknod from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mknod from core/busybox/1.31.0/20200817115148 to /bin/mknod
» Binlinking powertop from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked powertop from core/busybox/1.31.0/20200817115148 to /bin/powertop
» Binlinking envuidgid from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked envuidgid from core/busybox/1.31.0/20200817115148 to /bin/envuidgid
» Binlinking man from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked man from core/busybox/1.31.0/20200817115148 to /bin/man
» Binlinking mkfs.minix from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mkfs.minix from core/busybox/1.31.0/20200817115148 to /bin/mkfs.minix
» Binlinking sync from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sync from core/busybox/1.31.0/20200817115148 to /bin/sync
» Binlinking lpd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lpd from core/busybox/1.31.0/20200817115148 to /bin/lpd
» Binlinking pgrep from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked pgrep from core/busybox/1.31.0/20200817115148 to /bin/pgrep
» Binlinking ubirsvol from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ubirsvol from core/busybox/1.31.0/20200817115148 to /bin/ubirsvol
» Binlinking getopt from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked getopt from core/busybox/1.31.0/20200817115148 to /bin/getopt
» Binlinking stty from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked stty from core/busybox/1.31.0/20200817115148 to /bin/stty
» Binlinking rx from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked rx from core/busybox/1.31.0/20200817115148 to /bin/rx
» Binlinking ionice from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ionice from core/busybox/1.31.0/20200817115148 to /bin/ionice
» Binlinking kbd_mode from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked kbd_mode from core/busybox/1.31.0/20200817115148 to /bin/kbd_mode
» Binlinking setkeycodes from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked setkeycodes from core/busybox/1.31.0/20200817115148 to /bin/setkeycodes
» Binlinking xargs from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked xargs from core/busybox/1.31.0/20200817115148 to /bin/xargs
» Binlinking setuidgid from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked setuidgid from core/busybox/1.31.0/20200817115148 to /bin/setuidgid
» Binlinking udhcpd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked udhcpd from core/busybox/1.31.0/20200817115148 to /bin/udhcpd
» Binlinking reset from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked reset from core/busybox/1.31.0/20200817115148 to /bin/reset
» Binlinking losetup from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked losetup from core/busybox/1.31.0/20200817115148 to /bin/losetup
» Binlinking hexedit from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked hexedit from core/busybox/1.31.0/20200817115148 to /bin/hexedit
» Binlinking traceroute6 from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked traceroute6 from core/busybox/1.31.0/20200817115148 to /bin/traceroute6
» Binlinking hexdump from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked hexdump from core/busybox/1.31.0/20200817115148 to /bin/hexdump
» Binlinking runlevel from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked runlevel from core/busybox/1.31.0/20200817115148 to /bin/runlevel
» Binlinking chvt from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked chvt from core/busybox/1.31.0/20200817115148 to /bin/chvt
» Binlinking pmap from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked pmap from core/busybox/1.31.0/20200817115148 to /bin/pmap
» Binlinking expr from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked expr from core/busybox/1.31.0/20200817115148 to /bin/expr
» Binlinking wc from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked wc from core/busybox/1.31.0/20200817115148 to /bin/wc
» Binlinking rdate from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked rdate from core/busybox/1.31.0/20200817115148 to /bin/rdate
» Binlinking tee from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked tee from core/busybox/1.31.0/20200817115148 to /bin/tee
» Binlinking adjtimex from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked adjtimex from core/busybox/1.31.0/20200817115148 to /bin/adjtimex
» Binlinking install from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked install from core/busybox/1.31.0/20200817115148 to /bin/install
» Binlinking watchdog from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked watchdog from core/busybox/1.31.0/20200817115148 to /bin/watchdog
» Binlinking fstrim from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fstrim from core/busybox/1.31.0/20200817115148 to /bin/fstrim
» Binlinking pidof from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked pidof from core/busybox/1.31.0/20200817115148 to /bin/pidof
» Binlinking lsmod from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lsmod from core/busybox/1.31.0/20200817115148 to /bin/lsmod
» Binlinking iptunnel from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked iptunnel from core/busybox/1.31.0/20200817115148 to /bin/iptunnel
» Binlinking groups from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked groups from core/busybox/1.31.0/20200817115148 to /bin/groups
» Binlinking dd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dd from core/busybox/1.31.0/20200817115148 to /bin/dd
» Binlinking i2cdetect from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked i2cdetect from core/busybox/1.31.0/20200817115148 to /bin/i2cdetect
» Binlinking poweroff from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked poweroff from core/busybox/1.31.0/20200817115148 to /bin/poweroff
» Binlinking traceroute from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked traceroute from core/busybox/1.31.0/20200817115148 to /bin/traceroute
» Binlinking usleep from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked usleep from core/busybox/1.31.0/20200817115148 to /bin/usleep
» Binlinking w from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked w from core/busybox/1.31.0/20200817115148 to /bin/w
» Binlinking httpd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked httpd from core/busybox/1.31.0/20200817115148 to /bin/httpd
» Binlinking whois from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked whois from core/busybox/1.31.0/20200817115148 to /bin/whois
» Binlinking bzcat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked bzcat from core/busybox/1.31.0/20200817115148 to /bin/bzcat
» Binlinking ftpput from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ftpput from core/busybox/1.31.0/20200817115148 to /bin/ftpput
» Binlinking ftpd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ftpd from core/busybox/1.31.0/20200817115148 to /bin/ftpd
» Binlinking modprobe from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked modprobe from core/busybox/1.31.0/20200817115148 to /bin/modprobe
» Binlinking vlock from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked vlock from core/busybox/1.31.0/20200817115148 to /bin/vlock
» Binlinking blockdev from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked blockdev from core/busybox/1.31.0/20200817115148 to /bin/blockdev
» Binlinking touch from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked touch from core/busybox/1.31.0/20200817115148 to /bin/touch
» Binlinking grep from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked grep from core/busybox/1.31.0/20200817115148 to /bin/grep
» Binlinking pipe_progress from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked pipe_progress from core/busybox/1.31.0/20200817115148 to /bin/pipe_progress
» Binlinking dpkg from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dpkg from core/busybox/1.31.0/20200817115148 to /bin/dpkg
» Binlinking makemime from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked makemime from core/busybox/1.31.0/20200817115148 to /bin/makemime
» Binlinking dmesg from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dmesg from core/busybox/1.31.0/20200817115148 to /bin/dmesg
» Binlinking readahead from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked readahead from core/busybox/1.31.0/20200817115148 to /bin/readahead
» Binlinking netstat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked netstat from core/busybox/1.31.0/20200817115148 to /bin/netstat
» Binlinking bash from core/busybox/1.31.0/20200817115148 into /bin
Ø Skipping binlink because bash already exists at /bin/bash. Use --force to overwrite
» Binlinking zcip from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked zcip from core/busybox/1.31.0/20200817115148 to /bin/zcip
» Binlinking nsenter from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nsenter from core/busybox/1.31.0/20200817115148 to /bin/nsenter
» Binlinking logger from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked logger from core/busybox/1.31.0/20200817115148 to /bin/logger
» Binlinking unlink from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked unlink from core/busybox/1.31.0/20200817115148 to /bin/unlink
» Binlinking sha512sum from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sha512sum from core/busybox/1.31.0/20200817115148 to /bin/sha512sum
» Binlinking sulogin from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sulogin from core/busybox/1.31.0/20200817115148 to /bin/sulogin
» Binlinking svc from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked svc from core/busybox/1.31.0/20200817115148 to /bin/svc
» Binlinking udhcpc from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked udhcpc from core/busybox/1.31.0/20200817115148 to /bin/udhcpc
» Binlinking addgroup from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked addgroup from core/busybox/1.31.0/20200817115148 to /bin/addgroup
» Binlinking dumpleases from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dumpleases from core/busybox/1.31.0/20200817115148 to /bin/dumpleases
» Binlinking nuke from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nuke from core/busybox/1.31.0/20200817115148 to /bin/nuke
» Binlinking hostid from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked hostid from core/busybox/1.31.0/20200817115148 to /bin/hostid
» Binlinking setfattr from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked setfattr from core/busybox/1.31.0/20200817115148 to /bin/setfattr
» Binlinking mkfifo from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mkfifo from core/busybox/1.31.0/20200817115148 to /bin/mkfifo
» Binlinking fallocate from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fallocate from core/busybox/1.31.0/20200817115148 to /bin/fallocate
» Binlinking scriptreplay from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked scriptreplay from core/busybox/1.31.0/20200817115148 to /bin/scriptreplay
» Binlinking mkpasswd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mkpasswd from core/busybox/1.31.0/20200817115148 to /bin/mkpasswd
» Binlinking lzma from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lzma from core/busybox/1.31.0/20200817115148 to /bin/lzma
» Binlinking fuser from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fuser from core/busybox/1.31.0/20200817115148 to /bin/fuser
» Binlinking lspci from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked lspci from core/busybox/1.31.0/20200817115148 to /bin/lspci
» Binlinking mkfs.ext2 from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mkfs.ext2 from core/busybox/1.31.0/20200817115148 to /bin/mkfs.ext2
» Binlinking test from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked test from core/busybox/1.31.0/20200817115148 to /bin/test
» Binlinking sum from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sum from core/busybox/1.31.0/20200817115148 to /bin/sum
» Binlinking tcpsvd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked tcpsvd from core/busybox/1.31.0/20200817115148 to /bin/tcpsvd
» Binlinking which from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked which from core/busybox/1.31.0/20200817115148 to /bin/which
» Binlinking partprobe from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked partprobe from core/busybox/1.31.0/20200817115148 to /bin/partprobe
» Binlinking env from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked env from core/busybox/1.31.0/20200817115148 to /bin/env
» Binlinking hdparm from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked hdparm from core/busybox/1.31.0/20200817115148 to /bin/hdparm
» Binlinking i2ctransfer from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked i2ctransfer from core/busybox/1.31.0/20200817115148 to /bin/i2ctransfer
» Binlinking acpid from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked acpid from core/busybox/1.31.0/20200817115148 to /bin/acpid
» Binlinking fsck from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked fsck from core/busybox/1.31.0/20200817115148 to /bin/fsck
» Binlinking unexpand from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked unexpand from core/busybox/1.31.0/20200817115148 to /bin/unexpand
» Binlinking remove-shell from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked remove-shell from core/busybox/1.31.0/20200817115148 to /bin/remove-shell
» Binlinking head from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked head from core/busybox/1.31.0/20200817115148 to /bin/head
» Binlinking ubidetach from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ubidetach from core/busybox/1.31.0/20200817115148 to /bin/ubidetach
» Binlinking ubirmvol from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ubirmvol from core/busybox/1.31.0/20200817115148 to /bin/ubirmvol
» Binlinking strings from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked strings from core/busybox/1.31.0/20200817115148 to /bin/strings
» Binlinking passwd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked passwd from core/busybox/1.31.0/20200817115148 to /bin/passwd
» Binlinking hostname from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked hostname from core/busybox/1.31.0/20200817115148 to /bin/hostname
» Binlinking date from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked date from core/busybox/1.31.0/20200817115148 to /bin/date
» Binlinking iproute from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked iproute from core/busybox/1.31.0/20200817115148 to /bin/iproute
» Binlinking pscan from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked pscan from core/busybox/1.31.0/20200817115148 to /bin/pscan
» Binlinking vconfig from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked vconfig from core/busybox/1.31.0/20200817115148 to /bin/vconfig
» Binlinking md5sum from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked md5sum from core/busybox/1.31.0/20200817115148 to /bin/md5sum
» Binlinking tty from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked tty from core/busybox/1.31.0/20200817115148 to /bin/tty
» Binlinking telnetd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked telnetd from core/busybox/1.31.0/20200817115148 to /bin/telnetd
» Binlinking sha3sum from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sha3sum from core/busybox/1.31.0/20200817115148 to /bin/sha3sum
» Binlinking [[ from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked [[ from core/busybox/1.31.0/20200817115148 to /bin/[[
» Binlinking popmaildir from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked popmaildir from core/busybox/1.31.0/20200817115148 to /bin/popmaildir
» Binlinking chgrp from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked chgrp from core/busybox/1.31.0/20200817115148 to /bin/chgrp
» Binlinking cat from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked cat from core/busybox/1.31.0/20200817115148 to /bin/cat
» Binlinking depmod from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked depmod from core/busybox/1.31.0/20200817115148 to /bin/depmod
» Binlinking envdir from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked envdir from core/busybox/1.31.0/20200817115148 to /bin/envdir
» Binlinking ping6 from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ping6 from core/busybox/1.31.0/20200817115148 to /bin/ping6
» Binlinking run-init from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked run-init from core/busybox/1.31.0/20200817115148 to /bin/run-init
» Binlinking readprofile from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked readprofile from core/busybox/1.31.0/20200817115148 to /bin/readprofile
» Binlinking dos2unix from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dos2unix from core/busybox/1.31.0/20200817115148 to /bin/dos2unix
» Binlinking pwd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked pwd from core/busybox/1.31.0/20200817115148 to /bin/pwd
» Binlinking less from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked less from core/busybox/1.31.0/20200817115148 to /bin/less
» Binlinking svok from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked svok from core/busybox/1.31.0/20200817115148 to /bin/svok
» Binlinking insmod from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked insmod from core/busybox/1.31.0/20200817115148 to /bin/insmod
» Binlinking uuencode from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked uuencode from core/busybox/1.31.0/20200817115148 to /bin/uuencode
» Binlinking dirname from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked dirname from core/busybox/1.31.0/20200817115148 to /bin/dirname
» Binlinking time from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked time from core/busybox/1.31.0/20200817115148 to /bin/time
» Binlinking id from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked id from core/busybox/1.31.0/20200817115148 to /bin/id
» Binlinking uevent from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked uevent from core/busybox/1.31.0/20200817115148 to /bin/uevent
» Binlinking delgroup from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked delgroup from core/busybox/1.31.0/20200817115148 to /bin/delgroup
» Binlinking sv from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked sv from core/busybox/1.31.0/20200817115148 to /bin/sv
» Binlinking vi from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked vi from core/busybox/1.31.0/20200817115148 to /bin/vi
» Binlinking ls from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ls from core/busybox/1.31.0/20200817115148 to /bin/ls
» Binlinking unxz from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked unxz from core/busybox/1.31.0/20200817115148 to /bin/unxz
» Binlinking run-parts from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked run-parts from core/busybox/1.31.0/20200817115148 to /bin/run-parts
» Binlinking setfont from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked setfont from core/busybox/1.31.0/20200817115148 to /bin/setfont
» Binlinking chpst from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked chpst from core/busybox/1.31.0/20200817115148 to /bin/chpst
» Binlinking unlzma from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked unlzma from core/busybox/1.31.0/20200817115148 to /bin/unlzma
» Binlinking i2cset from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked i2cset from core/busybox/1.31.0/20200817115148 to /bin/i2cset
» Binlinking logread from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked logread from core/busybox/1.31.0/20200817115148 to /bin/logread
» Binlinking more from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked more from core/busybox/1.31.0/20200817115148 to /bin/more
» Binlinking realpath from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked realpath from core/busybox/1.31.0/20200817115148 to /bin/realpath
» Binlinking tunctl from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked tunctl from core/busybox/1.31.0/20200817115148 to /bin/tunctl
» Binlinking xxd from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked xxd from core/busybox/1.31.0/20200817115148 to /bin/xxd
» Binlinking nanddump from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nanddump from core/busybox/1.31.0/20200817115148 to /bin/nanddump
» Binlinking false from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked false from core/busybox/1.31.0/20200817115148 to /bin/false
» Binlinking nameif from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked nameif from core/busybox/1.31.0/20200817115148 to /bin/nameif
» Binlinking cksum from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked cksum from core/busybox/1.31.0/20200817115148 to /bin/cksum
» Binlinking ifenslave from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ifenslave from core/busybox/1.31.0/20200817115148 to /bin/ifenslave
» Binlinking base64 from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked base64 from core/busybox/1.31.0/20200817115148 to /bin/base64
» Binlinking volname from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked volname from core/busybox/1.31.0/20200817115148 to /bin/volname
» Binlinking tftp from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked tftp from core/busybox/1.31.0/20200817115148 to /bin/tftp
» Binlinking cpio from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked cpio from core/busybox/1.31.0/20200817115148 to /bin/cpio
» Binlinking setserial from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked setserial from core/busybox/1.31.0/20200817115148 to /bin/setserial
» Binlinking start-stop-daemon from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked start-stop-daemon from core/busybox/1.31.0/20200817115148 to /bin/start-stop-daemon
» Binlinking whoami from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked whoami from core/busybox/1.31.0/20200817115148 to /bin/whoami
» Binlinking mount from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mount from core/busybox/1.31.0/20200817115148 to /bin/mount
» Binlinking gzip from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked gzip from core/busybox/1.31.0/20200817115148 to /bin/gzip
» Binlinking ipaddr from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ipaddr from core/busybox/1.31.0/20200817115148 to /bin/ipaddr
» Binlinking ftpget from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked ftpget from core/busybox/1.31.0/20200817115148 to /bin/ftpget
» Binlinking mke2fs from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked mke2fs from core/busybox/1.31.0/20200817115148 to /bin/mke2fs
» Binlinking resume from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked resume from core/busybox/1.31.0/20200817115148 to /bin/resume
» Binlinking rmdir from core/busybox/1.31.0/20200817115148 into /bin
★ Binlinked rmdir from core/busybox/1.31.0/20200817115148 to /bin/rmdir
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/head --help`` or ``head --help``

```bash
$ head --help
Usage: head [OPTION]... [FILE]...
Print the first 10 lines of each FILE to standard output.
With more than one FILE, precede each with a header giving the file name.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -c, --bytes=[-]NUM       print the first NUM bytes of each file;
                             with the leading '-', print all but the last
                             NUM bytes of each file
  -n, --lines=[-]NUM       print the first NUM lines instead of the first 10;
...
...
```
