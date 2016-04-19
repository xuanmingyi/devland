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

sudo apt-get install -y git pkg-config autoconf libtool
sudo apt-get install -y libffi-dev expat libexpat1-dev  libxml2-dev

# install wayland

git clone ~/packages/wayland.git
cd wayland
./autogen.sh --prefix=/usr --disable-documentation
make
sudo make install
