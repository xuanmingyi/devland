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
sudo apt-get install -y bison flex python python-pip python-dev

sudo pip install  mako

# install wayland
TOP=`pwd`

cd $TOP
git clone ~/packages/wayland.git
cd wayland
./autogen.sh --prefix=/usr --disable-documentation
make
sudo make install

cd $TOP
git clone ~/packages/wayland-protocols
cd wayland-protocols
./autogen.sh --prefix=/usr
sudo make install
