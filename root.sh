GRN='\033[0;32m'
CYA='\033[0;36m'
YEL='\033[1;33m'
NC='\033[0m'

clear
printf "Terminale $CYA ip addr$NC yazıp bakabilirsiniz çoğunlukla enp ile başlar.\n"
printf "Ethernet kartı arayüzü adı: "
read ethkarti

clear
printf "Modeminizin varsayılan olarak gelen pppoe kullanıcı adını yazın.\n"
printf "Superonline da örneğin fiber@fiber \n"
printf "Arayüzden bulamıyorsanız kendiniz modemi sıfırladığınızda arayüz kurulumundan\n"
printf "İstediğiniz kullanıcı adı şifreyi yazıp kaydedip buraya yazabilirsiniz.\n"
printf "Varsayılan PPPoE kullanıcı adı: "
read pppoekullanici

clear
printf "Modemin varsayılan PPPoE şifresini yazınız.\n"
printf "Superonline da örneğin: fiber\n"
printf "Arayüzden bulamıyorsanız kendiniz modemi sıfırladığınızda arayüz kurulumundan\n"
printf "İstediğiniz şifreyi yazıp kaydedip buraya yazabilirsiniz.\n"
printf "PPPoE şifresi:  "
read pppoesifre
 
apt update && apt install pppoe mitmproxy wireshark --assume-yes

printf "\"$pppoekullanici\"   *       \"$pppoesifre\"         *\n">/etc/ppp/pap-secrets
printf "\"$pppoekullanici\"   *       \"$pppoesifre\"         *\n">/etc/ppp/chap-secrets

printf "ms-dns 8.8.8.8\n">/etc/ppp/pppoe-server-options
printf "ms-dns 8.8.4.4\n">>/etc/ppp/pppoe-server-options
printf "require-chap\n">>/etc/ppp/pppoe-server-options
printf "lcp-echo-interval 10\n">>/etc/ppp/pppoe-server-options
printf "lcp-echo-failure 2\n">>/etc/ppp/pppoe-server-options

printf "asyncmap 0\n">/etc/ppp/options
printf "auth\n">>/etc/ppp/options
printf "crtscts\n">>/etc/ppp/options
printf "lock\n">>/etc/ppp/options
printf "hide-password\n">>/etc/ppp/options
printf "modem\n">>/etc/ppp/options
printf "%s\n" "-pap" >> /etc/ppp/options
printf "+chap\n">>/etc/ppp/options
printf "lcp-echo-interval 30\n">>/etc/ppp/options
printf "lcp-echo-failure 4\n">>/etc/ppp/options
printf "noipx\n">>/etc/ppp/options

sudo pppoe-server -I $ethkarti -L 10.116.13.1 -R 10.116.13.100 -N 100
clear
sudo wireshark

