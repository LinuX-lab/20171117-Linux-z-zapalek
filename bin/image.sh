#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage:"
	echo "   $0 FILE_NAME DIR"
	exit 1
fi

FILE=$1
DIR=$2

if [ ! -f "${FILE}" ]; then
	echo "Brak pliku ${FILE}"
	exit 1
fi

if [ ! -d "${DIR}" ]; then
	mkdir -p "${DIR}"
fi

# Montowanie obrazu jako urządzenia
sudo mount ${FILE} ${DIR} -o loop,offset=$[ 512 * 2048 ]

# Odpalenie konsoli 
sudo /bin/bash

# Odmontowanie
sudo umount ${DIR}

