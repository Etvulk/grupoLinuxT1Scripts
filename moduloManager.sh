#!/bin/bash
verde="\e[32m"
rojo="\e[31m"
amarillo="\e[33m"
final="\e[0m"
echo -e "Indique el nombre del módulo que desea ${verde}habilitar${final} o ${rojo}deshabilitar${final}:"
read modulo
if [ -e "$(find /lib/modules/$(uname -r) -type f -name *.ko* | grep ${modulo})" ]
then

	
	if [ -e /etc/modprobe.d/${modulo}.conf ]
	then
		echo -e "El módulo está ${rojo}deshabilitado${final},¿Desea habilitarlo?[y/n]"
		read opcion
		if [[ $opcion == "y" || $opcion == "yes" ]]
		then
			sudo rm /etc/modprobe.d/${modulo}.conf
			echo -e "El módulo fue ${verde}habilitado${final}, por favor ${amarillo}reinicie${final}."
			       	
		else
			echo "El módulo no fue modificado."
				
		fi
	else 
		echo -e "El módulo está ${verde}habilitado${final},¿Desea deshabilitarlo?[y/n]"
		read opcion
		if [[ $opcion == "y" || $opcion == "yes" ]]
		then
			#sudo touch /etc/modprobe.d/${modulo}.conf
			sudo bash -c "echo blacklist $modulo  > /etc/modprobe.d/${modulo}.conf"
			echo -e "El módulo fue ${rojo}deshabilitadado${final}, por favor ${amarillo}reinicie${final}."
		else	
			echo "El módulo no fue modificado."	
		fi
	fi
else
	echo -e "El módulo ${amarillo}no existe${final}, por favor introduzca uno válido("lsmod" lista los módulos cargados en el kernel)."
fi	
