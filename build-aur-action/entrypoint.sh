#!/bin/bash

pkgname=$1

echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

useradd builder -m

echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

pacman -Suy --noconfirm
pacman -S base-devel git python-pip pyalpm tree --noconfirm

sudo --set-home -u builder pip install pikaur
sudo --set-home -u builder python -m pikaur -Sw --noconfirm $pkgname

tree -a /home/builder
mkdir ./dist
cp ~/.cache/pikaur/pkg/*.tar.zst ./dist
repo-add "./dist/xausky.db.tar.gz" ./dist/*.tar.zst