#!/bin/sh
. ~/.bashrc
die() {
    echo $1
    exit 1
}

# check release version
version=`lsb_release -rs`
if [ $version != "15.10" ];then
    die "Your system is not supported." 
fi

# update system
sudo apt-get update -y
sudo apt-get upgrade -y

if [ -z $WLD ];then
cat >> ~/.bashrc <<EOF
export WLD=$HOME/install   # change this to another location if you prefer
export LD_LIBRARY_PATH=$WLD/lib
export PKG_CONFIG_PATH=$WLD/lib/pkgconfig/:$WLD/share/pkgconfig/
export PATH=$WLD/bin:$PATH
export ACLOCAL_PATH=$WLD/share/aclocal
export ACLOCAL="aclocal -I $ACLOCAL_PATH"
EOF
export WLD=$HOME/install   # change this to another location if you prefer
export LD_LIBRARY_PATH=$WLD/lib
export PKG_CONFIG_PATH=$WLD/lib/pkgconfig/:$WLD/share/pkgconfig/
export PATH=$WLD/bin:$PATH
export ACLOCAL_PATH=$WLD/share/aclocal
export ACLOCAL="aclocal -I $ACLOCAL_PATH"
mkdir -p $WLD/share/aclocal # needed by autotools
fi

sudo apt-get install git pkg-config autoconf libtool


# install wayland

git clone git://anongit.freedesktop.org/wayland/wayland
cd wayland
./autogen.sh --prefix=$WLD --disable-documentation
make
