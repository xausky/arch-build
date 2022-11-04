#!/bin/bash

pkgname=$1

pacman -Suy --noconfirm
pacman -S base-devel git --noconfirm
pacman -U --noconfirm /yay.pkg.tar.zst
mkdir ./build
yay -S --noconfirm --builddir=./build $pkgname
