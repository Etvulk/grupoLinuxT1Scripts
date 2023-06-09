#!/bin/bash
verde="\e[32m"
rojo="\e[31m"
amarillo="\e[33m"
final="\e[0m"

while getopts pa:e:chd flag
do
	case $flag in
		p)
			for arg in $(cat ~/.referencias.txt)
			do
				if [ -e "$(realpath ${arg})" ]
				then
					echo -e "${verde}$(realpath ${arg})${final}"
				else
					echo -e "${rojo}$(realpath ${arg})${final}"
				fi
			done
		;;

		a)
			shift $((OPTIND - 2))
			for arg in "$@" 
			do
				if cat ~/.referencias.txt | grep -q $(realpath ${arg})
				then
					echo -e "El archivo ${amarillo}${arg}${final}, ya se encuentra ${amarillo}referenciado.${final}"
				else
					echo "$(realpath ${arg})" >> ~/.referencias.txt
					#if [ -e "$(realpath ${arg})" ]
					#then
					#	echo -e "${verde}$(realpath ${arg})${final}" >> ~/.referencias.txt
					#else
					#	echo -e "${rojo}$(realpath ${arg})${final}" >> ~/.referencias.txt
					#fi
				fi
			done
		;;

		e)
			if cat ~/.referencias.txt | grep -q $(realpath $2)
			then
				cat ~/.referencias.txt | grep -v $(realpath $2) > ~/.referencias.txt
			else
				echo -e "El archivo no se encuentra ${amarillo}referenciado.${final}"
			fi
		;;

		c)
			for arg in $(cat ~/.referencias.txt)
			do
				if [ -e "$(realpath ${arg})" ]
				then
					chmod $2 $arg
					
				else
					echo -e "El archivo ${amarillo}(${arg})${final},no existe."
				fi
			done
		;;

		d)
			echo "" > ~/.referencias.txt
		;;

		h)
			
			
			echo " 
		       	Sinopsis
			 	script [OPCION]... ARCHIVO
			 	script [OPCION]... MODO... ARCHIVO
			 	script [OPCION]... ARCHIVO... ARCHIVO
			
			 Descripción 
			 	Almacena referencias a archivos.
			
			 	-p,   muestra la dirección de los archivos referenciados
			 	  
			 	-a,   añade referencias de archivos
			 	    
			 	-e,   elimina referencias
			
			 	-c,   cambia los permisos de los archivos referenciados
			
			 	-h,   muestra los modos de empleo del script
			 	    	
			 	-d,   elimina todas las referencias"
				exit 0
		;;

		\?)
			echo "Use el flag '-h' para obtener mas información sobre el script."



	esac
done




#Sinopsis
# 	script [OPCION]... ARCHIVO
#	script [OPCION]... MODO... ARCHIVO
#	script [OPCION]... ARCHIVO... ARCHIVO

#Descripción 
#	Almacena referencias a archivos.

#	-p,   muestra la dirección de los archivos referenciados
  
#	-a,   añade referencias de archivos
  
#	-e,   elimina referencias

#	-c,   cambia los permisos de los archivos referenciados

#	-h,   muestra los modos de empleo del script
	
#	-d,   elimina todas las referencias

