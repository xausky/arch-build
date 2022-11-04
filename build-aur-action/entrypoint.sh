#!/bin/bash

pkgname=$1

pacman -Sy --noconfirm
pacman -U --noconfirm /yay.pkg.tar.zst
mkdir ./build
yay -S --noconfirm --builddir=./build $pkgname
