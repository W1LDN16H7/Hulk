#!/bin/bash
#AUTHOR https://github.com/W1LDN16H7
G="\033[1;34m[*] \033[0m"
S="\033[1;32m[+] \033[0m"
E="\033[1;31m[-] \033[0m"
P="\033[1;77m[>] \033[0m"



if [[ "$(id -u)" -ne 0 ]]; then
    printf "\e[1;77mPlease, run this program as root!\n\e[0m"
    exit 1
fi


VERSION=1.0
By="TH3W1LDN16HT"
github=https://github.com/W1LDN16H7

show_banner(){
 	echo -e "\e[0;32m ___  ___  ___  ___  ___       ___  __        \e[0m"  "$(do_color Created_By 1)" " $(do_color $By 1)"  
	echo -e "\e[0;32m|\  \|\  \|\  \|\  \|\  \     |\  \|\  \      \e[0m"  "$(do_color VERSION 2)" " $(do_color $VERSION 1)"
	echo -e "\e[0;32m\ \  \\\  \ \  \\\  \ \  \    \ \  \/  /|_    \e[0m"  "$(do_color GitHub: 1 )"  "$(do_color $github 3)"
	echo -e "\e[0;32m \ \   __  \ \  \\\  \ \  \    \ \   ___  \   \e[0m"
	echo -e "\e[0;32m  \ \  \ \  \ \  \\\  \ \  \____\ \  \\ \  \  \e[0m"
	echo -e "\e[0;32m   \ \__\ \__\ \_______\ \_______\ \__\\ \__\ \e[0m"
	echo -e "\e[0;32m    \|__|\|__|\|_______|\|_______|\|__| \|__| \e[0m"
	echo -e "\e[0;31m     Change mac and ip to random in seconds  $(do_color Hulk 4) By $By\e[0m"
	
        
}

thread(){
	for (( i = 0; i < "$3"; i++ )); do
		#statements
	
		echo -ne "$(do_color $1 2)"
		sleep "$2"

		
	done
}


# generate a random ip 

echo ""

do_color(){
	

	echo -e "\e[1;3$2m$1\e[0m"
}






random_ip(){

	COUNTER=1
	RANDMAX=3600
	RANDOM=$(( $(date '+%S') * $(date '+%M') ))

	while [ $COUNTER -gt 0 ]; do
	RANDOM=$(( $RANDOM * 137 + 258 % RANDMAX ))
	ip=192.168.2.$(( $RANDOM % 255 ))
	COUNTER=$(( $COUNTER-1 ))
	done;
	printf "%s " "$ip"


}



change_mac(){

	echo -e $G"\e[1;31mGetting All interface detail please wait...\e[0m"
	echo -e $G"\e[1;31mDone\e[0m"



	netstat -i



	echo -e $S"Please Specify the interface(ex eth0) :"
	read adapter


	old_mac=$( ifconfig $adapter | grep ether )
	echo -e $S "\e[1;33mOld Mac :  $old_mac\e[0m"





	echo -e $G"\e[1;31mPlease Wait...\e[0m"
	echo -e $G"\e[1;31mChanging Mac Address with a Random  Address..\e[0m"
	echo ""
	echo -e "\e[1;31m+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"


	# echo "$adapter"
	ifconfig "$adapter" down

	echo -e "\e[1;31m$(macchanger -r "$adapter")\e[0m"
	echo -e "\e[1;31m+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"



	echo -e $S"\e[1;31mDone\e[0m"

	new_mac=$( ifconfig $adapter | grep ether )
	echo -e $S"$(do_color Mac 2) $(do_color Changed 2)"


	echo -e $S "\e[1;31mNew  Mac is  : $new_mac\e[0m"




}

change_ip(){
	echo -e $S"\e[1;31mChanging IP\e[0m"
	echo -e $S"\e[1;31mSetting Gateway\e[0m"


	echo -e $S"\e[1;31mWait...\e[0m"

		
	# all done

		


	echo " $(ifconfig $adapter $(random_ip) netmask 255.255.255.0)"
	echo -e $S"$(do_color IP 2) $(do_color Changed 2)"

	

	echo " $(route add default gw $(random_ip))"
	echo -e $S"\e[0;32mGateway set successfully\e[0m"


	# echo "$adapter"

	echo " "


}

# function for changing mac in a time
change_mac_on_seconds(){
	
	old_mac=$( ifconfig $adapter | grep ether )
	# echo "$adapter"
	ifconfig "$adapter" down
	macchanger -r "$adapter"
	new_mac=$( ifconfig $adapter | grep ether )
	echo -e $S"$(do_color Mac 2) $(do_color Changed 2)"
	echo -e $S "\e[1;31mNew  Mac is  : $new_mac\e[0m"
	clear
	echo -e $S"\e[1;31mStarting Server\e[0m"
	
	echo " "
	echo -e $S"\e[1;31mServer Started Successfully\e[0m"
	sleep 2
	clear


	echo -e $S"\e[1;31mServer is running...\e[0m"
	echo -e $S"\e[1;31mYour Mac will change on every 30 seconds\e[0m"
	echo -e $S"\e[1;31mSuccess Thanks for using HULK\e[0m"
	thread "+" 0.2 60
	wait
	
	


	


}

on_seconds(){
	while [[ "!$(trap ' ' INT)" ]]; do
		change_mac_on_seconds
		sleep 30

		
		
		


		

	done
}

# if you want to chnage mac in a time use this function to do so wisely

second_mode(){
	echo -e $S"Start Hulk Mode, Give the time(ex. y/n): "
	read ans 
	y="y"
	
	
	#statements
	if [[ "$ans" == "$y" ]]; then
		#statements
		clear
		echo -e $S"\e[1;31mStarting Hulk Mode\e[0m"
		thread "-" 0.2 70
		echo " "
		echo -e "$(figlet HULK MODE ON | lolcat )"
		sleep 10
		clear


		on_seconds 
		sleep 15
		echo -e $S"\e[1;31mCTRL C to exit\e[0m"

	elif [[ "$ans"!="$y" ]]; then
		#statements
		echo -e $S"\e[1;31mOk but Try It\e[0m"
		

	else
		exit 0






	fi


	

}





echo -e "\e[0;35m$(show_banner)\e[0m"



change_mac



change_ip

second_mode

echo -e $S"\e[1;32mThanks for using HULK\e[0m"

echo -e $S"\e[1;32mNew Mac and Ip are as below\e[0m"

echo -e "\e[1;31m$(ifconfig $adapter  )\e[0m"



ifconfig "$adapter" up





#Thanks for your contribute 