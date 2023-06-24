source common.sh

roboshop_app_password=$1
 if [ -z "${roboshop_app_password}" ]; then
   echo -e "\e[31mmissing rabbitmq app user password is argument\e[0m"
   exit 1
 fi

component=payment
python