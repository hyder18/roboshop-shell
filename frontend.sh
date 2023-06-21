source common.sh

print_head "installing nginx"
yum install nginx -y &>>${log_file}
if [ $? -eq 0 ]; then
  echo success
else
  echo failure
fi

print_head "removing old content"
rm -rf /usr/share/nginx/html/* &>>${log_file}
echo $?


print_head "dowloading frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
echo $?


print_head "extracting downloaded frontend"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log_file}
echo $?


print_head "copying nginx config for roboshop"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
echo $?


print_head "enabling nginx"
systemctl enable nginx &>>${log_file}
echo $?


print_head "starting nginx"
systemctl restart nginx &>>${log_file}
echo $?
