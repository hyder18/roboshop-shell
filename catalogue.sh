source common.sh

print_head "configure nodejs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head "installing nodejs"
yum install nodejs -y &>>${log_file}

print_head "create robshop user"
useradd roboshop &>>${log_file}

print_head "create application directory"
mkdir /app &>>${log_file}

print_head "removing old content"
rm -rf /app* &>>${log_file}

print_head "downloading app content"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}



print_head "extracting app content"
unzip /tmp/catalogue.zip &>>${log_file}

print_head "installing nodejs dependencies"
npm install &>>${log_file}

print_head "copying systemd service file"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}

print_head "reload systemd"
systemctl daemon-reload &>>${log_file}

print_head "enabling catalogue"
systemctl enable catalogue &>>${log_file}

print_head "start catalogue"
systemctl restart catalogue &>>${log_file}

print_head "copying mongodb repo file"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head "install mongo client"
yum install mongodb-org-shell -y &>>${log_file}

print_head "load schema"
mongo --host mongodb-dev.hyder71.online </app/schema/catalogue.js &>>${log_file}