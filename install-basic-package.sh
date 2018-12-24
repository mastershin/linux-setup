#!/bin/bash
# A script to prepare my development system
#
# history:
# v0.2: adds Ubuntu 18 support
#
# @version: 0.2
# @version: 0.1
# @maintainted-by: jae
set -x
set -e

# if missing, returns 1 (false).  if installed, returns 0 (true)
# missing() { dpkg-query -W -f='${Status}' $1 2>/dev/null && return 1; return 0; }
missing() {
  dpkg -s $1
  if [ $? == 1 ]; then
    # if pkg not installed, dpkg returns 1, meaning it's missing.
    return 0
  fi
  return 1
}

apt_install() { 
  for pkg in "$@"; do
    if missing $pkg; then
      echo "Installing $pkg"
      apt install -y $pkg
    fi
  done
}
die() { echo "$*" 1>&2; exit 1; }

[ $USER == 'root' ] || die 'root only'

os_name=$(lsb_release -d | awk -F"\t" '{print $2}')
if [[ $os_name == 'Ubuntu 18.'* ]]; then
  os_name='Ubuntu'
  os_ver=18
  os='Ubuntu:18'
elif [[ $os_name == 'Ubuntu 16.'* ]]; then
  os_name='Ubuntu'
  os_ver=16
  os='Ubuntu:16'
elif [[ $os_name == 'Ubuntu 14.'* ]]; then
  os_name='Ubuntu'
  os_ver=14
  os='Ubuntu:14'
else
  die 'Not supported yet.'
fi

if ! grep -q "/snap/bin" /etc/environment; then
   echo 'add /snap/bin to etc/environment'
   exit 1
fi

echo "
/var/log/wtmp {
    monthly
    minsize 1M
    create 0664 root utmp
    rotate 12
}
" >/etc/logrotate.d/wtmp

# lf: alias for ls -f
if [ ! -f /usr/bin/lf ]; then
    echo "#!/bin/bash
    ls -f $@
" > /usr/bin/lf
    chmod +x /usr/bin/lf
fi

# llf: alias for ls -f1
if [ ! -f /usr/bin/llf ]; then
    echo "#!/bin/bash
ls -f1 $@ | sort | tail -n+3
" > /usr/bin/llf
    chmod +x /usr/bin/llf
fi

# ntp
timedatectl set-ntp no
apt_install ntp

# useful git alias
apt_install git
git config --system alias.lg 'log --all --decorate --graph --oneline'
git config --global core.preloadindex true
git config --global core.fscache true
git config --global gc.auto 256
# 28800 is 8 hours, 3880000 is ~1 month
git config --system credential.helper 'cache --timeout 2880000'

apt_install gcc
/snap/bin/go get github.com/github/hub
cp ~/go/bin/hub /usr/local/bin

# general. For remote-server, install watchdog
apt_install inotify-tools trash-cli

# replace rm with 'del' (trash)
if ! grep -q 'alias rm' /etc/bash.bashrc; then
    echo "alias rm='echo rm is not available. use \"del\" command to delete'" >>/etc/bash.bashrc
    echo "alias del='trash'" >>/etc/bash.bashrc
fi

apt_install apt-transport-https curl pwgen cpulimit nfs-common gcc
apt_install vim emacs tmux screen sshfs htop moreutils colordiff
apt_install linuxbrew-wrapper p7zip-full rar unrar pbzip2
apt_install mosh autojump hdfview dcmtk ncdu
apt_install automake libtool cmake jq uuid libgtk2.0-dev pkg-config 
apt_install libzip-dev monit pv iperf iftop
apt_install parallel meld
apt_install fail2ban

# nodejs v8 (Ubuntu 16 ships with nodejs v4)
if [ os == 'Ubuntu:14' || os == 'Ubuntu:16' ]; then
  curl --fail -ssL -o /tmp/setup-nodejs https://deb.nodesource.com/setup_8.x
  # curl -sL https://deb.nodesource.com/setup_8.x | -E bash -
  bash /tmp/setup-nodejs
  apt_install nodejs
else
  # Ubuntu 18+ ships node v8
  apt_install nodejs
fi

apt_install npm

# javascript code formatter
npm install --global prettier

# python beautifier - should be installed per user
# pip install yapf

# csvkit
if [ os == 'Ubuntu:14' || os == 'Ubuntu:16' ]; then
  apt_install python3-csvkit
else
  apt_install csvkit
fi

apt_install -y pv lzop mbuffer libconfig-inifiles-perl
# for centos/rhel
# yum install perl-Config-IniFiles

apt_install build-essential cmake