# stage3
http://mirrors.163.com/gentoo/releases/amd64/autobuilds/current-stage3-amd64/
mkfs.ext4 /dev/sda1

mkdir -p /mnt/gentoo
mount /dev/sda1 /mnt/gentoo

cd /mnt/gentoo
tar xjpvf stage3-*.tar.bz2

mount /dev/sda2 /mnt/gentoo/home

# chroot

cd /mnt/gentoo
mount -t proc none proc
mount --rbind /sys sys
mount --rbind /dev dev
cp /etc/resolv.conf etc
chroot . /bin/bash
source /etc/profile

passwd

useradd -g users -G wheel,portage,audio,video,usb,cdrom -m e788b1
passwd e788b1

# mount --make-rslave sys
# mount --make-rslave dev
#with not gentoo host
# rm /dev/shm && mkdir /dev/shm
# mount -t tmpfs -o nosuid,nodev,noexec shm /dev/shm
# chmod 1777 /dev/shm

# =========================copy
# config
# =========================copy

cat > /etc/portage/make.conf << "EOF"
# gentoo-make-conf
ACCEPT_KEYWORDS="~amd64"
CPU_FLAGS_X86="avx mmx mmxext sse sse2 sse3 ssse3 sse4 sse4_1 sse4_2"
CHOST="x86_64-pc-linux-gnu"
CFLAGS="-march=native -O2 -fomit-frame-pointer -pipe"
CXXFLAGS="${CFLAGS}"
MAKEOPTS="-j5"
GRUB_PLATFORMS="pc"
RUBY_TARGETS="ruby21"
PYTHON_TARGETS="python2_7 python3_4"
NGINX_MODULES_HTTP="access auth_basic autoindex browser charset empty_gif
    fastcgi geo gzip limit_conn limit_req map memcached proxy referer
    rewrite scgi split_clients ssi upstream_ip_hash userid uwsgi fancyindex"
VIDEO_CARDS="radeon"
ALSA_CARDS="hda-intel"
INPUT_DEVICES="evdev synaptics"
LINGUAS="en_US"
GRUB_PLATFORMS="emu pc"
PORT_LOGDIR="/var/log/portage"
PORTAGE_ELOG_CLASSES="info log warn error qa"
PORTAGE_ELOG_SYSTEM="save echo"
FEATURES="clean-logs"
EMERGE_DEFAULT_OPTS="--keep-going=y"
GENTOO_MIRRORS="http://mirrors.163.com/gentoo/"
PORTDIR="/usr/portage"
DISTDIR="/home/distfiles"
PKGDIR="/home/packages"
PORTAGE_TMPDIR="/tmp"
PORTAGE_NICENESS=15

#FEATURES="$FEATURES ccache"
#CCACHE_SIZE="8G"
#CCACHE_DIR="/home/ccache"
EOF

cat > /etc/portage/package.use/always.use << "EOF"
*/* -wxwidgets -qt4 -cups
*/* systemd
*/* aac alsa bluetooth cairo caps cdda cdr clang consolekit
*/* dbus encode exif ffmpeg flac fontconfig gif glamor gpm 
*/* gtk icu jpeg lcms ldap lzma
*/* mad mng mp3 ogg opengl pango pdf perl png policykit postscript
*/* pulseaudio python qt3support sdl svg threads tiff truetype udev
*/* udisks unicode usb v4l vdpau vim-syntax vorbis wavpack
*/* X xattr x264 x265 xcb xcomposite xft xinerama xml xv xvid xvmc
x11-libs/libxcb xkb 
dev-libs/libpcre pcre16
media-gfx/comix rar 
net-misc/iputils -caps -filecaps
app-i18n/fcitx gtk2 gtk3 -qt4
x11-themes/adwaita-icon-theme branding
x11-terms/rxvt-unicode 256-color alt-font-width fading-colors unicode3 wcwidth xft -vanilla
x11-misc/dunst dunstify
app-arch/unzip natspec
app-text/poppler -qt4 -qt5
app-arch/p7zip -wxwidgets
app-crypt/pinentry -qt4
media-libs/libpng apng
dev-lang/python sqlite
media-libs/mesa gles2
EOF

cat > /etc/fstab << "EOF"
#<fs>       <mountpoint> <type> <opts>                     <dump/pass>
#/dev/BOOT  /boot        ext2   noauto,noatime             1 2
/dev/sda1   /            ext4   noatime                    0 1
/dev/sda2   /home        ext4   noatime                    0 2
/home/overlay/squashfs/gentoo-current.xz.sqfs /usr/portage squashfs loop,nodev,noexec 0 0
#tmpfs       /tmp         tmpfs  noatime,nodiratime,size=4G 0 0
#/home/swapfile none      swap   sw                         0 0
#/dev/cdrom /mnt/cdrom   auto   noauto,ro                  0 0
#/dev/fd0   /mnt/floppy  auto   noauto                     0 0
# tmpfs     /home/e788b1/.cache tmpfs noatime,nodev,nosuid,size=1G 0 0
# //pandorabox/lost+found /mnt/pandorabox cifs  credentials=/home/e788b1/.smb/credentials,uid=1000,gid=100     0 0
EOF

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo 'hostname="e788b1"' > /etc/conf.d/hostname

cat > /etc/env.d/02locale << "EOF"
LANG="en_US.UTF-8"
LC_COLLATE="C"
EOF

cat > /etc/conf.d/net << "EOF"
modules_wlp8s0b1="wpa_supplicant"
#wpa_supplicant_wlp8s0b1="-Dnl80211"
#wpa_supplicant_wlp8s0b1="-Dnl80211 -d -f /var/log/wpa_supplicant.log"
config_wlp8s0b1="dhcp"
EOF

mkdir /etc/wpa_supplicant
cat > /etc/wpa_supplicant/wpa_supplicant.conf << "EOF"
# Allow users in the 'wheel' group to control wpa_supplicant
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel

# Make this file writable for wpa_gui
update_config=1
EOF
chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf

cat > /var/lib/portage/world << "EOF"
app-admin/logrotate
app-admin/sudo
app-arch/atool
app-arch/p7zip
app-editors/hexedit
app-editors/vim
app-i18n/fcitx
app-i18n/fcitx-configtool
app-misc/colordiff
app-misc/fdupes
app-misc/ranger
app-portage/eix
app-portage/gentoolkit
app-portage/pfl
app-shells/bash-completion
app-shells/zsh
dev-python/pip
dev-python/pyopenssl
dev-util/ccache
dev-vcs/git
media-fonts/corefonts
media-fonts/droid
media-fonts/terminus-font
media-fonts/wqy-bitmapfont
media-gfx/feh
media-gfx/imagemagick
media-sound/moc
media-sound/mpg123
media-video/mpv
net-misc/dhcpcd
sys-apps/rescan-scsi-bus
sys-apps/the_silver_searcher
sys-boot/grub
sys-boot/os-prober
sys-fs/ntfs3g
sys-fs/squashfs-tools
sys-kernel/gentoo-sources
sys-kernel/linux-firmware
sys-power/pm-utils
sys-process/htop
www-client/google-chrome
x11-apps/xrandr
x11-base/xorg-server
x11-misc/dmenu
x11-misc/dunst
x11-misc/hsetroot
x11-misc/i3status
x11-misc/unclutter
x11-misc/urxvt-font-size
x11-misc/urxvt-perls
x11-misc/xsel
x11-terms/rxvt-unicode
x11-themes/gtk-engines-ubuntulooks
x11-wm/i3
EOF

cat > /etc/hosts << "EOF"
127.0.0.1 e788b1.lan e788b1  localhost
::1       localhost
EOF

# ================================ paste
# ================================ paste

#portage
mount -rt squashfs -o loop,nodev,noexec ${SQFS_CURRENT} ${PORTDIR}

eselect profile list
eselect profile set systemd

env-update && source /etc/profile

#cat > /etc/local.d/portmount.start << "EOF"
##!/bin/bash

#source /etc/portage/make.conf
#SQFS_CURRENT=/home/overlay/squashfs/gentoo-current.lzo.sqfs
#mount -rt squashfs -o loop,nodev,noexec ${SQFS_CURRENT} ${PORTDIR}
#EOF
#chmod +x /etc/local.d/portmount.start

cat > /etc/X11/xorg.conf.d/40mouse.conf << "EOF"
Section "InputClass"
    Identifier "Reverse Scrolling"
    MatchIsPointer "on"
    Option "VertScrollDelta" "-1"
    Option "HorizScrollDelta" "-1"
    Option "DialDelta" "-1"
EndSection

Section "InputClass"
    Identifier "Natural Scrolling"
    MatchIsTouchpad "on"
    Option "VertScrollDelta" "-300"
    Option "HorizScrollDelta" "-1"
EndSection
EOF

#kernel
emerge -va gentoo-sources linux-firmware
#.config
cd /usr/src/linux
make -j9 && make modules_install && make install

emerge -eva ccache
emerge -van wpa_supplicant dhcpcd syslog-ng grub xorg-server i3 sudo

systemctl enable dhcpcd.service
systemctl enable syslog-ng.service
systemctl enable cronie.service

rc-update add syslog-ng default
rc-update add consolekit default
rc-update add cronie default

#grub
GRUB_CMDLINE_LINUX="init=/usr/lib/systemd/systemd"
grub-install --force /dev/sda1

cat >> /etc/default/grub << EOF
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true

GRUB_EARLY_INITRD_LINUX_CUSTOM="ucode.cpio"
EOF

grub-mkconfig -o /boot/grub/grub.cfg
exit
cd
umount -R /mnt/gentoo
reboot

##############################
wpa_cli
scan
scan_results
add_network
set_network 0 ssid "MYSSID"
set_network 0 psk "passphrase"
enable_network 0
save_config
dhcpcd interface
wpa_passphrase MYSSID passphrase
# wpa_supplicant -B -i interface -c <(wpa_passphrase MYSSID passphrase)
debug# wpa_supplicant -Dnl80211 -iwlan0 -C/var/run/wpa_supplicant/ -c/etc/wpa_supplicant/wpa_supplicant.conf -dd

# pulseaudio & mpd
/etc/pulse/default.pa
load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1

# bluetooth
/etc/bluetooth/main.conf
[Policy]
AutoEnable=true
#EOF

# udiskie
cat > /etc/polkit-1/rules.d/50-udiskie.rules << "EOF"
polkit.addRule(function(action, subject) {
  var YES = polkit.Result.YES;
  // NOTE: there must be a comma at the end of each line except for the last:
  var permission = {
    // required for udisks1:
    "org.freedesktop.udisks.filesystem-mount": YES,
    "org.freedesktop.udisks.luks-unlock": YES,
    "org.freedesktop.udisks.drive-eject": YES,
    "org.freedesktop.udisks.drive-detach": YES,
    // required for udisks2:
    "org.freedesktop.udisks2.filesystem-mount": YES,
    "org.freedesktop.udisks2.encrypted-unlock": YES,
    "org.freedesktop.udisks2.eject-media": YES,
    "org.freedesktop.udisks2.power-off-drive": YES,
    // required for udisks2 if using udiskie from another seat (e.g. systemd):
    "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
    "org.freedesktop.udisks2.filesystem-unmount-others": YES,
    "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
    "org.freedesktop.udisks2.eject-media-other-seat": YES,
    "org.freedesktop.udisks2.power-off-drive-other-seat": YES
  };
  if (subject.isInGroup("usb")) {
    return permission[action.id];
  }
});
EOF

