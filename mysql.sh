source common.sh

mysql_root_password=$1
if [ -z "{mysql_root_password}" ]; then
  echo -e "\e[31mmissing mysql_root_password argument\e[0m"
  exit 1
fi

print_head "disabling mysql 8 version"
yum module disable mysql -y &>>${log_file}
status_check $?

print_head "install mysql server"
yum install mysql-community-server -y &>>${log_file}
status_check $?

print_head "enable mysql servive"
systemctl enable mysqld &>>${log_file}
status_check $?

print_head "start mysql service"
systemctl start mysqld &>>${log_file}
status_check $?

print_head "setup root password"
mysql_secure_installation --set-root-pass ${mysql_root_password} &>>${log_file}

