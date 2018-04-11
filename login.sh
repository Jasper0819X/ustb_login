#!/usr/bin/env sh
urlencode() {
    echo "$@" | awk -v ORS="" '{ gsub(/./,"&\n") ; print }' | while read l;
    do
        case "$l" in
            [-_.~a-zA-Z0-9] ) echo -n ${l} ;;
            "" ) echo -n %20 ;;
            * )  printf '%%%02X' "'$l"
        esac
    done
    echo ""
}

my_ip=$(wget -qO - http://cippv6.ustb.edu.cn/get_ip.php | sed "s/^gIpV6Addr = '//g" | sed "s/';//g" | sed "s/\r//g" | sed "s/\n//g")

printf "Your IPv6 Address: %s\n" "${my_ip}"
sid=""

if [ $# -ne 1 ]; then
    read -p "      ID: " sid  
else 
    sid=$1
fi
stty -echo
read -p "Passowrd: " pwd
stty echo
printf "\n"
ip_en=$(urlencode ${my_ip})
pwd_en=$(urlencode ${pwd})

post_data="DDDDD=${sid}&upass=${pwd_en}&v6ip=${ip_en}&0MKKey=123456789"
cookie="myusername=${sid}; username=${sid}"

wget --server-response -qO - --header="Cookie: ${cookie}" --post-data="${post_data}" http://202.204.48.66 2>&1 | awk '/^  HTTP/{print $2}'
