#!/data/data/com.termux/files/usr/bin/bash

# Colores
AZUL='\033[1;34m'
VERDE='\033[1;32m'
AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
MAGENTA='\033[1;35m'
RESET='\033[0m'

# Función de ejecución inteligente
ejecutar_herramienta() {
    local paquete=$1
    local comando=$2
    
    if ! command -v "$paquete" &> /dev/null; then
        echo -e "${AMARILLO}[!] '$paquete' no está instalado. Instalándolo...${RESET}"
        pkg install "$paquete" -y
    fi
    
    if command -v "$paquete" &> /dev/null; then
        echo -e "${VERDE}[*] Abriendo $paquete...${RESET}"
        sleep 1
        eval "$comando"
    else
        echo -e "${ROJO}[!] No se pudo instalar $paquete.${RESET}"
    fi
}

while true; do
    clear
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
                    1) ejecutar_herramienta "nano" "nano"; read -p "Enter para continuar..." ;;
                    2) ejecutar_herramienta "micro" "micro"; read -p "Enter para continuar..." ;;
                    3) ejecutar_herramienta "vim" "vim"; read -p "Enter para continuar..." ;;
                    4) ejecutar_herramienta "joe" "joe"; read -p "Enter para continuar..." ;;
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
                        ejecutar_herramienta "w3m" "w3m $urlweb"
                        read -p "Enter para continuar..." 
                        ;;
                    2) 
                        read -p "Ingresa URL (ej: google.com): " urlweb2
                        [ -z "$urlweb2" ] && urlweb2="google.com"
                        ejecutar_herramienta "lynx" "lynx $urlweb2"
                        read -p "Enter para continuar..." 
                        ;;
                    0) break ;;
                esac
            done
            ;;
        3)
            echo -e "${VERDE}[+] Instalando herramientas de Red y Desarrollo...${RESET}"
            pkg install curl wget nmap git openssh netcat dnsutils -y
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
                    1) ejecutar_herramienta "htop" "htop"; read -p "Enter para continuar..." ;;
                    2) ejecutar_herramienta "neofetch" "neofetch"; read -p "Enter para continuar..." ;;
                    3) ejecutar_herramienta "tree" "tree"; read -p "Enter para continuar..." ;;
                    4) ejecutar_herramienta "ncdu" "ncdu"; read -p "Enter para continuar..." ;;
                    0) break ;;
                esac
            done
            ;;
        5)
            echo -e "${VERDE}[+] Instalando herramientas de archivos...${RESET}"
            pkg install zip unzip tar rsync p7zip -y
            read -p "Presiona Enter para continuar..."
            ;;
        6)
            echo -e "${VERDE}[+] Instalando utilidades multimedia...${RESET}"
            pkg install ffmpeg sox mpg123 -y
            read -p "Presiona Enter para continuar..."
            ;;
        7)
            echo -e "${VERDE}[+] Actualizando todo Termux...${RESET}"
            pkg update && pkg upgrade -y
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
