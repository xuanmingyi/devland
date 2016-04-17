#!/bin/sh

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


