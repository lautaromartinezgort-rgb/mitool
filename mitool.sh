#!/usr/bin/env bash

# Colores
AZUL='\033[1;34m'
VERDE='\033[1;32m'
AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
MAGENTA='\033[1;35m'
RESET='\033[0m'

# Función de ejecución e instalación inteligente (Corregida)
ejecutar_herramienta() {
    local paquete=$1
    shift
    local comando=("$@")
    
    if ! command -v "$paquete" &> /dev/null; then
        echo -e "${AMARILLO}[!] '$paquete' no está instalado. Iniciando descarga...${RESET}"
        
        if command -v pkg &> /dev/null; then
            pkg install "$paquete" -y
        elif command -v apt &> /dev/null; then
            sudo apt update && sudo apt install "$paquete" -y
        else
            echo -e "${ROJO}[!] No tienes 'pkg' ni 'apt'. No se puede descargar automáticamente.${RESET}"
            return 1
        fi
    fi
    
    if command -v "$paquete" &> /dev/null; then
        echo -e "${VERDE}[*] Abriendo $paquete...${RESET}"
        sleep 1
        "${comando[@]}"
    else
        echo -e "${ROJO}[!] Falló la descarga de '$paquete'. Intenta usar la Opción 7 (Actualizar Termux) primero.${RESET}"
    fi
}

# Bucle principal del menú
while true; do
    clear
    # ==========================================
    # ARTE ASCII - EL PERRITO DE MITOOL
    # ==========================================
    echo -e "${AMARILLO}    |\\---/| ${RESET}"
    echo -e "${AMARILLO}    | o_o |  ¡Guau! Bienvenido a${RESET}"
    echo -e "${AMARILLO}     \\_^_/   MITOOL.${RESET}"
    
    echo -e "${AZUL}=========================================${RESET}"
    echo -e "${VERDE}      MITOOL - MEGA PANEL DE COMANDOS    ${RESET}"
    echo -e "${AZUL}=========================================${RESET}"
    echo -e " ${MAGENTA}[ 1 ] Editores de Texto (Nano, Micro, Vim, Joe)${RESET}"
    echo -e " ${MAGENTA}[ 2 ] Navegadores Web (W3M, Lynx)${RESET}"
    echo -e " ${MAGENTA}[ 3 ] Redes y Servidores (Curl, Wget, Nmap, Git, SSH)${RESET}"
    echo -e " ${MAGENTA}[ 4 ] Sistema y Monitoreo (Htop, Neofetch, Tree, Ncdu)${RESET}"
    echo -e " ${MAGENTA}[ 5 ] Archivos y Compresión (Zip, Unzip, Tar, Rsync)${RESET}"
    echo -e " ${MAGENTA}[ 6 ] Multimedia y Audio (FFmpeg, Sox, Mpg123)${RESET}"
    echo -e " ${MAGENTA}[ 7 ] Actualizar todo Termux (Pkg upgrade)${RESET}"
    echo -e " ${ROJO}[ 0 ] Salir${RESET}"
    echo -e "${AZUL}=========================================${RESET}"
    read -p "Elige una categoría o opción: " cat_opcion

    case $cat_opcion in
        1)
            while true; do
                clear
                echo -e "${AZUL}=== EDITORES DE TEXTO ===${RESET}"
                echo -e " [1] Abrir / Instalar Nano"
                echo -e " [2] Abrir / Instalar Micro"
                echo -e " [3] Abrir / Instalar Vim"
                echo -e " [4] Abrir / Instalar Joe"
                echo -e " [0] Volver al menú principal"
                read -p "Elige editor: " ed
                case $ed in
                    1) ejecutar_herramienta "nano" nano; read -p "Presiona Enter para continuar..." ;;
                    2) ejecutar_herramienta "micro" micro; read -p "Presiona Enter para continuar..." ;;
                    3) ejecutar_herramienta "vim" vim; read -p "Presiona Enter para continuar..." ;;
                    4) ejecutar_herramienta "joe" joe; read -p "Presiona Enter para continuar..." ;;
                    0) break ;;
                esac
            done
            ;;
        2)
            while true; do
                clear
                echo -e "${AZUL}=== NAVEGADORES WEB ===${RESET}"
                echo -e " [1] W3M (Navegador visual en consola)"
                echo -e " [2] Lynx (Navegador clásico de texto)"
                echo -e " [0] Volver al menú principal"
                read -p "Elige navegador: " nav
                case $nav in
                    1) 
                        read -p "Ingresa URL (ej: google.com): " urlweb
                        [ -z "$urlweb" ] && urlweb="google.com"
                        [[ ! "$urlweb" =~ ^https?:// ]] && urlweb="https://$urlweb"
                        ejecutar_herramienta "w3m" w3m "$urlweb"
                        read -p "Presiona Enter para continuar..." 
                        ;;
                    2) 
                        read -p "Ingresa URL (ej: google.com): " urlweb2
                        [ -z "$urlweb2" ] && urlweb2="google.com"
                        [[ ! "$urlweb2" =~ ^https?:// ]] && urlweb2="https://$urlweb2"
                        ejecutar_herramienta "lynx" lynx "$urlweb2"
                        read -p "Presiona Enter para continuar..." 
                        ;;
                    0) break ;;
                esac
            done
            ;;
        3)
            echo -e "${VERDE}[+] Instalando herramientas de Red y Desarrollo...${RESET}"
            if command -v pkg &> /dev/null; then 
                echo -e "${AMARILLO}[*] Actualizando repositorios de Termux primero...${RESET}"
                pkg update -y
                
                # Instala los paquetes de a uno para evitar que uno roto cancele a los demás
                paquetes_red="curl wget nmap git openssh netcat-openbsd dnsutils"
                for paquete in $paquetes_red; do
                    echo -e "${AZUL}[*] Instalando $paquete...${RESET}"
                    pkg install "$paquete" -y
                done
                
                echo -e "${VERDE}[+] Instalación de herramientas de red finalizada.${RESET}"
            elif command -v apt &> /dev/null; then
                sudo apt update
                sudo apt install curl wget nmap git openssh-client netcat-openbsd dnsutils -y
            else
                echo -e "${ROJO}[!] No se detectó pkg ni apt. No se puede instalar automáticamente.${RESET}"
            fi
            read -p "Presiona Enter para continuar..."
            ;;
        4)
            while true; do
                clear
                echo -e "${AZUL}=== SISTEMA Y MONITOREO ===${RESET}"
                echo -e " [1] Htop (Administrador de procesos)"
                echo -e " [2] Neofetch (Info del sistema)"
                echo -e " [3] Tree (Estructura de carpetas)"
                echo -e " [4] Ncdu (Analizador de espacio en disco)"
                echo -e " [0] Volver al menú principal"
                read -p "Elige utilidad: " sys
                case $sys in
                    1) ejecutar_herramienta "htop" htop; read -p "Presiona Enter para continuar..." ;;
                    2) ejecutar_herramienta "neofetch" neofetch; read -p "Presiona Enter para continuar..." ;;
                    3) ejecutar_herramienta "tree" tree; read -p "Presiona Enter para continuar..." ;;
                    4) ejecutar_herramienta "ncdu" ncdu; read -p "Presiona Enter para continuar..." ;;
                    0) break ;;
                esac
            done
            ;;
        5)
            echo -e "${VERDE}[+] Instalando herramientas de archivos...${RESET}"
            if command -v pkg &> /dev/null; then 
                pkg install zip unzip tar rsync p7zip -y
            elif command -v apt &> /dev/null; then
                sudo apt install zip unzip tar rsync p7zip-full -y
            fi
            read -p "Presiona Enter para continuar..."
            ;;
        6)
            echo -e "${VERDE}[+] Instalando utilidades multimedia...${RESET}"
            if command -v pkg &> /dev/null; then 
                pkg install ffmpeg sox mpg123 -y
            elif command -v apt &> /dev/null; then
                sudo apt install ffmpeg sox mpg123 -y
            fi
            read -p "Presiona Enter para continuar..."
            ;;
        7)
            echo -e "${VERDE}[+] Actualizando todo...${RESET}"
            if command -v pkg &> /dev/null; then 
                pkg update -y && pkg upgrade -y
            elif command -v apt &> /dev/null; then
                sudo apt update && sudo apt upgrade -y
            fi
            read -p "Presiona Enter para continuar..."
            ;;
        0)
            echo -e "${ROJO}Saliendo de Mitool... ¡Hasta luego!${RESET}"
            exit 0
            ;;
        *)
            echo -e "${ROJO}[!] Opción no válida.${RESET}"
            sleep 1
            ;;
    esac
done
