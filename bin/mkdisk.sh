#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage:"
	echo "   $0 PART_FILE PART_SIZE_IN_MB"
	exit 1
fi

# Tworzenie pliku obrazu
truncate -s "${2}M" "${1}" 2>&1 >/dev/null

# Partycjonowanie
fdisk "${1}" 2>&1 >/dev/null <<EOF
o
n
p
1
2048

a
w
EOF

# Montowanie obrazu jako urządzenia
LOOP=`sudo losetup -Pf --show ${1}`

# Tworzenie systemu plików
sudo mkfs.ext2 ${LOOP}p1 2>&1 >/dev/null

# Instalacja ExtLinux
mkdir _tmpdir
sudo mount ${LOOP}p1 _tmpdir
sudo extlinux -i _tmpdir
sudo umount _tmpdir
rmdir _tmpdir
sudo dd if=/usr/lib/EXTLINUX/mbr.bin of=${LOOP}

# Odmontowanie
sudo losetup -d ${LOOP}
