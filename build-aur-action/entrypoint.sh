#!/bin/bash

pkgname=$1

useradd builder -m
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chmod -R a+rw .

pacman -Sy --noconfirm
pacman -U --noconfirm /yay.pkg.tar.zst
sudo --set-home -u builder mkdir ./build
sudo --set-home -u builder yay -S --noconfirm --builddir=./build $pkgname
