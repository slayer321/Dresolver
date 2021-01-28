#!/bin/bash

#Converter.sh  by @0x_Mantis
#Usage ./converter.sh [domain-list-file] [output-file]
# This is a script inspired by the Bug Hunter's Methodology 3 by @Jhaddix


#The color that I have used
#Red='\e[0;31m'
#Green='\e[0;32m'
#IRed='\e[0;91m'
#end='\e[0m'



printf "\n\n\e[1;35m[+] Converter.sh by @0x_Mantis\n\n\n\e[0m"
if [ -z "$1" ] || [ -z "$2" ]; then 
	echo "[!] Usage:./converter.sh [domain-list-file] [output-file]"
	exit 1
fi
printf "\n\e[1;33m[+] Resolving domains to IP......\e[0m\n\n"
while read d || [[ -n $d ]]; do
	ip=$(dig +short $d |grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"|head -1)
	if [[ -n $ip ]]; then 
		printf "\e[0;32m[+] '$d' ==> $ip\e[0m \n"
		echo $ip >> $2
	else
		printf "\e[0;91m[!] '$d' ==> [RESOLVE ERROR]\e[0m \n"
	fi
done < $1
echo -e "\n [+] Removing duplicate "
sort $2 | uniq > $2.new
mv $2.new $2
echo -e "\n [+] Done, IP saved to '$2'."
