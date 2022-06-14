#!/bin/bash
set -e

init_path=$PWD
mkdir upload_packages
cp $local_path/*/*.tar.zst ./upload_packages/

if [ ! -f ~/.config/rclone/rclone.conf ]; then
    mkdir --parents ~/.config/rclone
    echo "[onedrive]" >> ~/.config/rclone/rclone.conf
    echo "type = onedrive" >> ~/.config/rclone/rclone.conf

    echo "client_id=$RCLONE_ONEDRIVE_CLIENT_ID" >> ~/.config/rclone/rclone.conf
    echo "client_secret=$RCLONE_ONEDRIVE_CLIENT_SECRET" >> ~/.config/rclone/rclone.conf
    echo "region=$RCLONE_ONEDRIVE_REGION" >> ~/.config/rclone/rclone.conf
    echo "drive_type=$RCLONE_ONEDRIVE_DRIVE_TYPE" >> ~/.config/rclone/rclone.conf
    echo "token=$RCLONE_ONEDRIVE_TOKEN" >> ~/.config/rclone/rclone.conf
    echo "drive_id=$RCLONE_ONEDRIVE_DRIVE_ID" >> ~/.config/rclone/rclone.conf
fi

cd upload_packages || exit 1

repo-add "./${repo_name:?}.db.tar.gz" ./*.tar.zst
rclone delete --rmdirs "onedrive:${dest_path:?}"
rclone copy ./ "onedrive:${dest_path:?}" --copy-links
