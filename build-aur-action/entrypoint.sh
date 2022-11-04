#!/bin/bash

pkgname=$1

echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

useradd builder -m
echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chmod -R a+rw .

pacman -Suy --noconfirm
pacman -S base-devel git --noconfirm
pacman -U --noconfirm /yay.pkg.tar.zst
mkdir ./build
chown builder:builder -R ./build
sudo --set-home -u builder yay -S --noconfirm --builddir=./build $pkgname
rm -r ./build/dist
mkdir ./build/dist
cp ./build/*/*.tar.zst ./build/dist
repo-add "./build/dist/xausky.db.tar.gz" ./build/dist/*.tar.zst