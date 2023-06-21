source common.sh

print_head "setup mongodb repository"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head "install mongodb"
yum install mongodb-org -y &>>${log_file}

print_head "update mongodb listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log_file}

print_head "enable mongodb"
systemctl enamble mongod &>>${log_file}

print_head "start mongodb service"
systemctl restart mongod &>>${log_file}