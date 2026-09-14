#!/bin/bash

# Colores
VERDE="\033[0;32m"
CYAN="\033[0;36m"
AMARILLO="\033[1;33m"
ROJO="\033[0;31m"
MAGENTA="\033[0;35m"
RESET="\033[0m"

pausa() {
    echo ""
    read -p "Presiona Enter para continuar..."
}

# ==========================================
# SUBMENÚ 1: MULTIMEDIA, AUDIO Y VIDEO
# ==========================================
submenu_multimedia() {
    while true; do
        clear
        echo -e "${CYAN}=====================================${RESET}"
        echo -e "${VERDE}     MULTIMEDIA, AUDIO Y VIDEO      ${RESET}"
        echo -e "${CYAN}=====================================${RESET}"
        echo -e " 1) Reproducir música local (mpv / cmus)"
        echo -e " 2) Ver información de archivo multimedia (mediainfo)"
        echo -e " 3) Convertir MP4 a MP3 (ffmpeg)"
        echo -e " 4) Extraer audio sin reencodear (ffmpeg)"
        echo -e " 5) Recortar un video o audio (ffmpeg)"
        echo -e " 6) Cambiar resolución de video (ffmpeg)"
        echo -e " 7) Unir varios videos MP4 (ffmpeg)"
        echo -e " 8) Convertir GIF a MP4 (ffmpeg)"
        echo -e " 9) Grabar audio con micrófono (termux-audio-record)"
        echo -e "10) Convertir formato de imagen (PNG <-> JPG)"
        echo -e "11) Reproducir radio online por terminal"
        echo -e "12) Instalar paquetes multimedia principales"
        echo -e "13) ${ROJO}<- Volver al menú principal${RESET}"
        echo -e "${CYAN}=====================================${RESET}"
        read -p "Selecciona una opción [1-13]: " opc
        case $opc in
            1)
                read -p "Ruta del archivo o carpeta de música: " ruta
                mpv "$ruta" || cmus
                pausa ;;
            2)
                read -p "Ruta del archivo multimedia: " ruta
                mediainfo "$ruta" || ffprobe "$ruta"
                pausa ;;
            3)
                read -p "Video de entrada (ej: video.mp4): " in
                read -p "Audio de salida (ej: audio.mp3): " out
                ffmpeg -i "$in" -vn -ar 44100 -ac 2 -b:a 192k "$out"
                pausa ;;
            4)
                read -p "Video de entrada: " in
                read -p "Nombre salida (ej: audio.aac): " out
                ffmpeg -i "$in" -vn -c:a copy "$out"
                pausa ;;
            5)
                read -p "Archivo entrada: " in
                read -p "Tiempo inicio (HH:MM:SS): " ss
                read -p "Duración (HH:MM:SS): " t
                read -p "Archivo salida: " out
                ffmpeg -ss "$ss" -i "$in" -to "$t" -c copy "$out"
                pausa ;;
            6)
                read -p "Video entrada: " in
                read -p "Resolución (ej: 1280x720): " res
                read -p "Video salida: " out
                ffmpeg -i "$in" -vf scale="$res" "$out"
                pausa ;;
            7)
                echo "Crea un archivo lista.txt con: file 'video1.mp4'..."
                ffmpeg -f concat -safe 0 -i lista.txt -c copy salida.mp4
                pausa ;;
            8)
                read -p "GIF entrada: " in
                read -p "MP4 salida: " out
                ffmpeg -i "$in" -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "$out"
                pausa ;;
            9)
                read -p "Nombre del audio grabado (.mp3): " rec
                termux-audio-record -f "$rec"
                echo "Grabando... ejecuta 'termux-audio-record -d' para detener."
                pausa ;;
            10)
                read -p "Imagen entrada: " in
                read -p "Imagen salida: " out
                ffmpeg -i "$in" "$out"
                pausa ;;
            11)
                read -p "URL de la radio/stream: " url
                mpv "$url"
                pausa ;;
            12)
                pkg install ffmpeg mpv cmus mediainfo -y
                pausa ;;
            13) break ;;
            *) echo -e "${ROJO}Opción inválida${RESET}"; sleep 1 ;;
        esac
    done
}

# ==========================================
# SUBMENÚ 2: DESCARGAS Y RED
# ==========================================
submenu_descargas() {
    while true; do
        clear
        echo -e "${CYAN}=====================================${RESET}"
        echo -e "${AMARILLO}         DESCARGAS Y RED            ${RESET}"
        echo -e "${CYAN}=====================================${RESET}"
        echo -e " 1) Descargar video de YouTube / Redes (yt-dlp)"
        echo -e " 2) Descargar SOLO audio en MP3 (yt-dlp)"
        echo -e " 3) Descargar lista de reproducción completa (yt-dlp)"
        echo -e " 4) Descargar archivo directo (wget)"
        echo -e " 5) Descargar con cliente multihilo (aria2c)"
        echo -e " 6) Descargar torrent por terminal (aria2c / transmission)"
        echo -e " 7) Probar velocidad de internet (speedtest-cli)"
        echo -e " 8) Ver mi IP pública y localización (curl)"
        echo -e " 9) Ver mi IP local e interfaces (ifconfig / ip a)"
        echo -e "10) Hacer Ping a un servidor"
        echo -e "11) Escanear puertos abiertos locales (nmap)"
        echo -e "12) Instalar herramientas de descargas"
        echo -e "13) ${ROJO}<- Volver al menú principal${RESET}"
        echo -e "${CYAN}=====================================${RESET}"
        read -p "Selecciona una opción [1-13]: " opc
        case $opc in
            1)
                read -p "URL del video: " url
                yt-dlp "$url"
                pausa ;;
            2)
                read -p "URL del audio/video: " url
                yt-dlp -x --audio-format mp3 "$url"
                pausa ;;
            3)
                read -p "URL de la Playlist: " url
                yt-dlp -i -f mp4 "$url"
                pausa ;;
            4)
                read -p "URL del archivo: " url
                wget -c "$url"
                pausa ;;
            5)
                read -p "URL del archivo: " url
                aria2c -x 16 -s 16 "$url"
                pausa ;;
            6)
                read -p "Ruta archivo .torrent o Magnet URL: " tor
                aria2c "$tor"
                pausa ;;
            7)
                speedtest-cli || speedtest
                pausa ;;
            8)
                curl ifconfig.me; echo ""
                curl ipinfo.io
                pausa ;;
            9)
                ip a
                pausa ;;
            10)
                read -p "Dominio o IP: " host
                ping -c 4 "$host"
                pausa ;;
            11)
                read -p "IP a escanear (ej: 192.168.1.1): " ip
                nmap "$ip"
                pausa ;;
            12)
                pkg install yt-dlp wget aria2 speedtest-cli nmap -y
                pausa ;;
            13) break ;;
            *) echo -e "${ROJO}Opción inválida${RESET}"; sleep 1 ;;
        esac
    done
}

# ==========================================
# SUBMENÚ 3: EDITORES Y ARCHIVOS
# ==========================================
submenu_editores() {
    while true; do
        clear
        echo -e "${CYAN}=====================================${RESET}"
        echo -e "${MAGENTA}        EDITORES Y ARCHIVOS          ${RESET}"
        echo -e "${CYAN}=====================================${RESET}"
        echo -e " 1) Editar con Nano"
        echo -e " 2) Editar con Vim / Neovim"
        echo -e " 3) Editar con Micro (editor fácil e intuitivo)"
        echo -e " 4) Explorador de archivos visual (ranger / mc)"
        echo -e " 5) Buscar texto dentro de archivos (grep / ripgrep)"
        echo -e " 6) Buscar archivos por nombre (find)"
        echo -e " 7) Comprimir carpeta en ZIP"
        echo -e " 8) Descomprimir ZIP"
        echo -e " 9) Comprimir en TAR.GZ"
        echo -e "10) Descomprimir TAR.GZ / RAR / 7z"
        echo -e "11) Ver uso de espacio detallado (ncdu)"
        echo -e "12) Instalar editores y compresores"
        echo -e "13) ${ROJO}<- Volver al menú principal${RESET}"
        echo -e "${CYAN}=====================================${RESET}"
        read -p "Selecciona una opción [1-13]: " opc
        case $opc in
            1)
                read -p "Archivo a editar: " f
                nano "$f" ;;
            2)
                read -p "Archivo a editar: " f
                vim "$f" || nvim "$f" ;;
            3)
                read -p "Archivo a editar: " f
                micro "$f" ;;
            4)
                ranger || mc
                pausa ;;
            5)
                read -p "Texto a buscar: " txt
                grep -rnw '.' -e "$txt"
                pausa ;;
            6)
                read -p "Nombre o patrón (ej: *.mp3): " pat
                find . -name "$pat"
                pausa ;;
            7)
                read -p "Nombre del archivo salida (.zip): " z
                read -p "Carpeta o archivo a comprimir: " f
                zip -r "$z" "$f"
                pausa ;;
            8)
                read -p "Archivo ZIP: " z
                unzip "$z"
                pausa ;;
            9)
                read -p "Nombre salida (.tar.gz): " t
                read -p "Carpeta a comprimir: " f
                tar -czvf "$t" "$f"
                pausa ;;
            10)
                read -p "Archivo comprimido: " f
                if [[ $f == *.tar.gz ]]; then tar -xzvf "$f"; fi
                if [[ $f == *.zip ]]; then unzip "$f"; fi
                if [[ $f == *.7z ]]; then 7z x "$f"; fi
                if [[ $f == *.rar ]]; then unrar x "$f"; fi
                pausa ;;
            11)
                ncdu
                pausa ;;
            12)
                pkg install nano vim micro ranger mc zip unzip p7zip unrar ncdu -y
                pausa ;;
            13) break ;;
            *) echo -e "${ROJO}Opción inválida${RESET}"; sleep 1 ;;
        esac
    done
}

# ==========================================
# SUBMENÚ 4: MANTENIMIENTO Y SISTEMA
# ==========================================
submenu_sistema() {
    while true; do
        clear
        echo -e "${CYAN}=====================================${RESET}"
        echo -e "${VERDE}     MANTENIMIENTO Y SISTEMA        ${RESET}"
        echo -e "${CYAN}=====================================${RESET}"
        echo -e " 1) Actualizar todos los paquetes (pkg update)"
        echo -e " 2) Limpiar caché y paquetes innecesarios"
        echo -e " 3) Ver uso de RAM y CPU en tiempo real (htop / btop)"
        echo -e " 4) Información completa del sistema (neofetch)"
        echo -e " 5) Configurar/Otorgar permisos de almacenamiento"
        echo -e " 6) Ver procesos activos (ps aux)"
        echo -e " 7) Matar un proceso (kill)"
        echo -e " 8) Crear respaldo de la Home de Termux"
        echo -e " 9) Restaurar respaldo de Termux"
        echo -e "10) Cambiar contraseña de usuario Termux"
        echo -e "11) Instalar monitores de sistema"
        echo -e "12) ${ROJO}<- Volver al menú principal${RESET}"
        echo -e "${CYAN}=====================================${RESET}"
        read -p "Selecciona una opción [1-12]: " opc
        case $opc in
            1)
                pkg update && pkg upgrade -y
                pausa ;;
            2)
                pkg clean && apt autoremove -y
                echo "Caché limpiada con éxito."
                pausa ;;
            3)
                htop || btop || top
                pausa ;;
            4)
                neofetch || fastfetch
                pausa ;;
            5)
                termux-setup-storage
                pausa ;;
            6)
                ps aux
                pausa ;;
            7)
                read -p "PID del proceso a cerrar: " pid
                kill -9 "$pid"
                pausa ;;
            8)
                echo "Creando copia en la memoria interna..."
                tar -cvzf /sdcard/termux_backup.tar.gz -C /data/data/com.termux/files ./home ./usr
                echo "Guardado en /sdcard/termux_backup.tar.gz"
                pausa ;;
            9)
                echo "Restaurando copia..."
                tar -xvzf /sdcard/termux_backup.tar.gz -C /data/data/com.termux/files
                pausa ;;
            10)
                passwd
                pausa ;;
            11)
                pkg install htop btop neofetch -y
                pausa ;;
            12) break ;;
            *) echo -e "${ROJO}Opción inválida${RESET}"; sleep 1 ;;
        esac
    done
}

# ==========================================
# MENÚ PRINCIPAL
# ==========================================
while true; do
    clear
    echo -e "${CYAN}=====================================${RESET}"
    echo -e "${VERDE}    SUPER MENÚ MULTIFUNCIÓN TERMUX  ${RESET}"
    echo -e "${CYAN}=====================================${RESET}"
    echo -e " 1) 🎵 Multimedia, Audio y Video"
    echo -e " 2) 📥 Descargas y Comandos de Red"
    echo -e " 3) 📝 Editores, Comprimidos y Archivos"
    echo -e " 4) ⚙️  Mantenimiento y Sistema"
    echo -e " 5) 🚀 INSTALAR TODO DE UNA VEZ (Herramientas completas)"
    echo -e " 6) ${ROJO}Salir${RESET}"
    echo -e "${CYAN}=====================================${RESET}"
    read -p "Selecciona una carpeta/categoría [1-6]: " opc_principal

    case $opc_principal in
        1) submenu_multimedia ;;
        2) submenu_descargas ;;
        3) submenu_editores ;;
        4) submenu_sistema ;;
        5)
            echo -e "\n${AMARILLO}Instalando todos los programas necesarios...${RESET}"
            pkg update && pkg upgrade -y
            pkg install ffmpeg mpv cmus mediainfo yt-dlp wget aria2 speedtest-cli nmap nano vim micro ranger mc zip unzip p7zip unrar ncdu htop btop neofetch -y
            echo -e "${VERDE}¡Instalación completa!${RESET}"
            pausa ;;
        6)
            echo -e "\n${ROJO}¡Hasta luego!${RESET}"
            exit 0 ;;
        *)
            echo -e "\n${ROJO}Opción no válida.${RESET}"
            sleep 1 ;;
    esac
done
