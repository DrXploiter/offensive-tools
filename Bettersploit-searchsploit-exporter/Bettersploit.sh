#!/bin/bash

###########NMAP SCAN###################
printf "============================================================================\n"
figlet -c "Bettersploit importer"
printf "Find and import 'better' exploits quickly into metasploit from searchsploit\n"
printf "By DrXploiter\n"
printf "===========================================================================\n"

SearchsploitHandler(){

###########SearchSploit search###############################################################################
searchsploit --nmap $loc |grep "exploits/" |cut -d'|' -f2 |sed '/[i] \/usr\/*/d' > exploits.txt
###############################################################################################################
}
ExploitListHandler(){
#Preparing exploits for importing: 
#remove ANSI code from text file output
sed -r "s/\x1B\[(([0-9]{1,2})?(;)?([0-9]{1,2})?)?[m,K,H,f,J]//g" exploits.txt > exploits_s.txt
#remove spaces
awk '{$1=$1};1' exploits_s.txt > exploits_s1.txt 
###############################################################################################################
#make new exploits DIR
mkdir /root/.msf4/modules/exploits/newExploits
echo 'Importing new exploits into metasploit (warning make sure metasploit is not open)....'
#copy the awked exploit DIR into the metasploit DIR for importing----------------------------------------------
awk '{print "cp /usr/share/exploitdb/" $0" /root/.msf4/modules/exploits/newExploits"}' exploits_s1.txt > exploitsSorted.txt 
bash exploitsSorted.txt
echo 'Imported new exploits successfully!.....Now use a search for newExploits in metasploit'
updatedb
#---------------------------------------------------------------------------------------------------------------
}

###MAIN PROGRAM###################################################################################################
#make folder first for storing the nmap xml output
mkdir nmap_outputs
#user specifies ip address
echo "=============================================================================="
echo '1. Default nmap scan'
echo '2. Custom nmap scan'
echo '3. Use nmap XML output file'
echo '4. Find x type of exploits'
echo "==============================================================================="
read nmapChoice
case $nmapChoice in 
    1) #default nmap scan 
    read -p 'Specify IP: ' ip
    loc="nmap_outputs/$ip.xml"
 	echo 'Using default arguments (-sV -T5 -A)'
	nmap -oX $loc -sV -T5 -A $ip
	SearchsploitHandler
	ExploitListHandler
	echo "==============================================================================="
	echo "FINISHED..."
    ;;
    2) #custom nmap scan
    read -p 'Specify IP: ' ip	    
    loc="nmap_outputs/$ip.xml"
    read -p 'Specify nmap arguments: ' nmapArgs
    nmap -oX $loc $nmapArgs $ip
    SearchsploitHandler
    ExploitListHandler
    echo "==============================================================================="
    echo "FINISHED..."
	;;
	3) #xml file
    read -p 'Specify XML location (eg; /root/Desktop/results.xml): ' loc
    SearchsploitHandler
    ExploitListHandler
    echo "==============================================================================="
    echo "FINISHED..."
	;;
	4) #Search a specific type of exploit
	read -p 'Specify a service/system type (eg; netbios, nfs, drupal) ' Etype
	#use a custom searchsploit handler based on search term
	searchsploit $Etype |grep "exploits/" |cut -d'|' -f2 |sed '/[i] \/usr\/*/d' > exploits.txt
	ExploitListHandler
	echo "==============================================================================="
	echo "FINISHED..."
	;;

esac




	
