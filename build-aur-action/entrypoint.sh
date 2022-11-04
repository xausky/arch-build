#!/bin/bash

pkgname=$1

echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

useradd builder -m
echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chmod -R a+rw .

pacman -Suy --noconfirm
pacman -S base-devel git python-pip pyalpm --noconfirm
pip install pikaur
sudo --set-home -u builder python -m pikaur -Sw --noconfirm $pkgname
mkdir ./dist
cp ~/.cache/pikaur/pkg/*.tar.zst ./dist
repo-add "./dist/xausky.db.tar.gz" ./dist/*.tar.zst