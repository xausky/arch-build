#!/bin/bash

pkgname=$1

useradd builder -m
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chmod -R a+rw .

pacman -Sy --noconfirm
pacman -S --noconfirm yay

sudo --set-home -u builder yay -S --noconfirm --builddir=./ "$pkgname"
