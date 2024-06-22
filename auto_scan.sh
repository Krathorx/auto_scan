#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


echo -e "\n${turquoiseColour}Escaneo automático de puertos${endColour} - ${grayColour}Made by Miguel Nebot (aka Krathor)${endColour}"

# Comprobar si es el usuario actual es root
if [ $(id -u) -ne 0 ]; then
    echo -e "\n${redColour}Debes ser root para ejecutar esta herramienta${endColour}\n"
exit
fi

# Comprobar si 'nmap' está instalado

if [ ! -f /usr/bin/nmap ]; then
    echo -e "${yellowColour}La herramienta${endColour}${redColour}'nmap'${endColour}${yellowColour}no está instalada${endColour}"
else
    echo ""
fi

## Dar la ip de la máquina víctima
read -p "Dame la IP del equipo a escanear: " ip

## Opciones a elegir

while true; do
    echo -e "\n${greenColour}1) Escaneo básico${endColour}"
    echo -e "\n${greenColour}2) Escaneo sigiloso${endColour}"
    echo -e "\n${greenColour}3) Escaneo de puerto individual${endColour}"
    echo -e "\n${greenColour}4) Escaneo completo${endColour}"
    echo -e "\n${redColour}5) Salir${endColour}\n"
    read -p "Selecciona el escaneo deseado: " escaneo

case $escaneo in 

1) clear && echo -e "${yellowColour}Escaneando la IP --> ${endColour}${turquoiseColour}$ip${endColour}" && nmap -p- --open $ip > escaneo_básico.txt && echo -e "\n${blueColour}Reporte guardado en el archivo${endColour} ${yellowColour}escaneo_básico.txt${endColour}"
exit
;;
2) clear && echo -e "${yellowColour}Escaneando la IP --> ${endColour}${turquoiseColour}$ip${endColour}" && nmap -p- --open -sS -Pn $ip > escaneo_sigiloso.txt && echo -e "\n${blueColour}Reporte guardado en el archivo${endColour} ${yellowColour}escaneo_sigiloso.txt${endColour}"
exit
;;
3) clear && read -p "Dime el puerto específico a escanear: " port && echo -e "\n${yellowColour}Escaneando el puerto -->${endColour} $port" && nmap -p$port $ip > escaneo_individual.txt && echo -e "\n${blueColour}Reporte guardado en el archivo${endColour} ${yellowColour}escaneo_individual.txt${endColour}"
exit
;;
4) clear && echo -e "${yellowColour}Escaneando la IP --> ${endColour}${turquoiseColour}$ip${endColour}" && nmap -p- --open -sCV -n -sS -Pn --min-rate 5000 $ip > escaneo_completo.txt && echo -e "\n${blueColour}Reporte guardado en el archivo${endColour} ${yellowColour}escaneo_completo.txt${endColour}"
exit
;;
5) exit && clear
;; 

esac 
done
