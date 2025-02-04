#!/usr/bin/env bash

echo Pulling docker image...
sudo docker pull m.daocloud.io/docker.io/library/alpine:edge
sudo docker tag m.daocloud.io/docker.io/library/alpine:edge docker.io/library/alpine:edge
sudo docker rmi m.daocloud.io/docker.io/library/alpine:edge

echo Building docker image
cd docker
sudo docker build -t wine .
cd ..

echo Starting wine container...
sudo docker run -itd --rm --name wine wine

echo Exporting container...
sudo docker export wine > rootfs.tar
mv rootfs.tar image

echo Killing&Removing the container...
sudo docker kill wine

echo Patching rootfs...
cd image
tar xvf rootfs.tar
cat<<EOF> etc/resolv.conf
nameserver 114.114.114.114
nameserver 8.8.8.8
nameserver 223.5.5.5
nameserver 1.1.1.1
EOF
rm rootfs.tar
tar zcvf rootfs.tgz ./
mv rootfs.tgz ..
rm -rf ./*
cd ..
mv rootfs.tgz image/
cd image
split -b $(($(du -b rootfs.tgz | cut -f1) / 50)) rootfs.tgz part_
rm rootfs.tgz
cd ..
