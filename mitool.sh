#!/bin/bash

# Colores para que se vea profesional
rojo="\033[1;31m"
verde="\033[1;32m"
azul="\033[1;34m"
amarillo="\033[1;33m"
fin="\033[0m"

while :
do
    clear
    echo -e "$azul==================================$fin"
    echo -e "$verde      MI HERRAMIENTA DE TEST      $fin"
    echo -e "$azul==================================$fin"
    echo -e "$amarillo [1] $fin Ver informacion del sistema"
    echo -e "$amarillo [2] $fin Comprobar conexion a internet"
    echo -e "$amarillo [3] $fin Actualizar paquetes de Termux"
    echo -e "$amarillo [0] $fin Salir"
    echo -e "$azul==================================$fin"
    
    read -p "Selecciona una opcion: " opcion

    case $opcion in
        1)
            echo -e "\n$verde[+] Obteniendo informacion...$fin"
            uname -a
            ;;
        2)
            echo -e "\n$verde[+] Probando conexion...$fin"
            ping -c 3 google.com
            ;;
        3)
            echo -e "\n$verde[+] Actualizando...$fin"
            pkg update -y
            ;;
        0)
            echo -e "\n$rojo[*] Saliendo de la herramienta...$fin"
            exit 0
            ;;
        *)
            echo -e "\n$rojo[!] Opcion no valida.$fin"
            ;;
    esac

    echo -e "\n"
    read -p "Presiona Enter para continuar..."
done

