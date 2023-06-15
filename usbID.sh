#!/bin/bash

if ! [[ -e /var/log/log_gl1 ]] #Creación del log
then
	sudo bash -c "echo \"Puerto   |         Fecha/hora           | Evento\" >> /var/log/log_gl1"
	sudo bash -c "echo \"------------------------------------------------------\" >> /var/log/log_gl1"
	
fi

if [ $1 = "-a" ] #Añadir reglas a udev
then
	sudo echo "KERNEL==\"*-?\", ACTION==\"add\", SUBSYSTEM==\"usb\", DRIVERS==\"usb\", RUN+=\"/home/ian/usb.sh '\$env{ACTION}' '\$kernel'\"" >> /etc/udev/rules.d/60-scriptusbID.rules
        sudo echo "KERNEL==\"*-?\", ACTION==\"remove\", SUBSYSTEM==\"usb\", DRIVERS==\"usb\", RUN+=\"/home/ian/usb.sh '\$env{ACTION}' '\$kernel'\"" >> /etc/udev/rules.d/60-scriptusbID.rules

	sudo echo "#!/bin/bash" >> /usr/lib/systemd/system-shutdown/usbIDVariable.sh
	sudo echo "mount -o remount,rw /" >> /usr/lib/systemd/system-shutdown/usbIDVariable.sh
	sudo echo "echo \"0\" > /etc/.scriptVar" >> /usr/lib/systemd/system-shutdown/usbIDVariable.sh
	sudo echo "mount -o remount,ro /" >> /usr/lib/systemd/system-shutdown/usbIDVariable.sh

	sudo chmod +x /usr/lib/systemd/system-shutdown/usbIDVariable.sh
	exit 0
fi

if [ $1 = "-w" ] 
then
	sudo tail -f /var/log/log_gl1
fi

if [[ $(cat /etc/.scriptVar) == 1 ]] #Registros del log
then
	if [ $1 = "add" ]
	then
		puerto="$(echo "si $2" | cut -d"-" -f2)"
		echo "Puerto:$puerto | $(date) | Conexión" >> /var/log/log_gl1
	
	elif [ $1 = "remove" ]
	then
		puerto="$(echo "no $2" | cut -d"-" -f2)"  
		echo "Puerto:$puerto | $(date) | Desconexión" >> /var/log/log_gl1
	fi
else
	echo "1" > /etc/.scriptVar
fi



