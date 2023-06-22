source common.sh

print_head "installing redis repo file"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log_file}
status_check $?

print_head "enable 6.2 redis repo"
yum module enable redis:remi-6.2 -y &>>${log_file}
status_check $?

print_head "install redis"
yum install redis -y &>>${log_file}
status_check $?

print_head "update listen address"
sed -i -e 's/127.0.0.1/0.0.0.0'/ /etc/redis.conf &>>${log_file}
status_check $?

print_head "enable redis service"
systemctl enable redis &>>${log_file}
status_check $?

print_head "start redis service"
systemctl restart redis &>>${log_file}
status_check $?
