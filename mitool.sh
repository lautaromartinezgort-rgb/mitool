#!/bin/bash

# Colores
verde="\033[1;32m"
azul="\033[1;34m"
rojo="\033[1;31m"
fin="\033[0m"

while true; do
    clear
    echo -e "${azul}==================================${fin}"
    echo -e "${verde}       MI HERRAMIENTA - TERMUX    ${fin}"
    echo -e "${azul}==================================${fin}"
    echo "1. Saludar al usuario"
    echo "2. Ver información del sistema"
    echo "3. Buscar en DuckDuckGo"
    echo "0. Salir"
    echo -e "${azul}==================================${fin}"
    read -p "Selecciona una opción: " opcion

    case $opcion in
        1)
            echo -e "\n${verde}¡Hola! Bienvenido a tu herramienta personalizada.${fin}"
            read -p "Presiona Enter para continuar..."
            ;;
        2)
            echo -e "\n${azul}--- INFORMACIÓN DEL SISTEMA ---${fin}"
            uname -a
            pkg info termux-tools 2>/dev/null | grep "Version" || echo "Termux actualizado"
            read -p "\nPresiona Enter para continuar..."
            ;;
        3)
            clear
            echo -e "${azul}--- BUSCADOR DUCKDUCKGO ---${fin}"
            read -p "Escribe lo que quieres buscar: " query
            query_url=$(echo "$query" | tr ' ' '+')
            echo -e "\n${verde}Buscando en DuckDuckGo...${fin}"
            curl -s "https://html.duckduckgo.com/html/?q=$query_url" -A "Mozilla/5.0" | grep -o '<a class="result__snippet[^>]*>.*</a>' | sed -e 's/<[^>]*>//g' | head -n 5
            read -p "\nPresiona Enter para volver al menú..."
            ;;
        0)
            echo -e "\n${rojo}¡Saliendo de la herramienta!${fin}"
            exit 0
            ;;
        *)
            echo -e "\n${rojo}Opción no válida.${fin}"
            sleep 1
            ;;
    esac
done

