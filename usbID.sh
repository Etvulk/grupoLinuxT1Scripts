#!/bin/bash

if [[ "$1" != "-n" ]]; then
	 $0 -n & disown
	exit $?
fi


sleep 2
if ! [[ -e /var/log/log_gl1 ]]
then
	echo "Puerto   |         Fecha/hora           | Evento" >> /var/log/log_gl1
	sleep 1
fi
primeraVez="Si"
conteoTotal=$(sudo dmesg | grep usb | grep - | grep -c found) 

desconectadoTotal=$(sudo dmesg | grep usb | grep - | grep -c disconnect)

if [ $primeraVez == "Si" ]
then
	conteoReal=0
	for (( c=1; c<=$conteoTotal; c++))
	do
		echo "Puerto $(sudo dmesg | grep usb | grep - | grep found | cut -d "-" -f 2 | cut -d ":" -f 1 | head -$c | tail -1) |                              | Conexión" >> /var/log/log_gl1
	done
	primeraVez="No"
	sudo dmesg -C
fi
while true
do

	conteoTotal=$(sudo dmesg | grep usb | grep - | grep -c found)
	desconectadoTotal=$(sudo dmesg | grep usb | grep - | grep -c disconnect)

	if [[ $((conteoTotal - desconectadoTotal)) > $conteoReal ]]
	then
		
			 	 
		echo "Puerto $(sudo dmesg | grep usb | grep - | grep found | cut -d "-" -f 2 | cut -d ":" -f 1 | tail -1) | $(date) | Conexión" >> /var/log/log_gl1
		conteoReal=$((conteoReal + 1))
	fi

	if [[ $((conteoTotal - desconectadoTotal)) < $conteoReal ]]
	then
		echo "Puerto $(sudo dmesg | grep usb | grep - | grep disconnect | cut -d "-" -f 2 | cut -d ":" -f 1 | tail -1) | $(date) | Desconexión" >> /var/log/log_gl1
		conteoReal=$((conteoReal - 1))
	fi
done



