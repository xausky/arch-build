#!/bin/bash

pkgname=$1

useradd builder -m
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chmod -R a+rw .

pacman -Suy --noconfirm
pacman -S base-devel git --noconfirm
pacman -U --noconfirm /yay.pkg.tar.zst
mkdir ./build
chown builder:builder -R .
sudo --set-home -u builder yay -S --noconfirm --builddir=./build $pkgname