#!/bin/bash

pkgname=$1

echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

useradd builder -m

echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

pacman -Suy --noconfirm
pacman -S base-devel git python-pip pyalpm tree --noconfirm

mkdir ./dist
chown builder:builder -R ./dist

sudo --set-home -u builder mkdir -p /home/builder/.cache/pikaur
sudo --set-home -u builder ln -s $PWD/dist /home/builder/.cache/pikaur/pkg
sudo --set-home -u builder pip install pikaur
sudo --set-home -u builder python -m pikaur -Sw --noconfirm $pkgname
sudo --set-home -u builder repo-add /home/builder/.cache/pikaur/pkg/xausky.db.tar.gz /home/builder/.cache/pikaur/pkg/*.tar.zst