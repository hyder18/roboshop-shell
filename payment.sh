source common.sh

mysql_root_password=$1
 if [ -z "${mysql_root_password}" ]; then
     echo -e "\e[31mmissing Rabbitmq app user password  argument\e[0m"
     exit 1
 fi

component=payment
python