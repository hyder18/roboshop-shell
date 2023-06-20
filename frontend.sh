code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

print_head() {
  echo -e "\e[36m$1\e[0m"
}

print_head "installing nginx"
yum install nginx -y &>>${log_file}

print_head "removing old content"
rm -rf /usr/share/nginx/html/* &>>${log_file}


print_head "dowloading frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}


print_head "extracting downloaded frontend"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log_file}


print_head "copying nginx config for roboshop"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}


print_head "enabling nginx"
systemctl enable nginx &>>${log_file}


print_head "starting nginx"
systemctl restart nginx &>>${log_file}
