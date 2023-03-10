code_dir=$(pwd)

echo -e "\e[33minstalling nginx\e[0m"
yum install nginx -y

echo -e "\e[33mremoving old content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[33mdownloading frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[33mextracting downloaded content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[33mcopying nginx config for roboshop\e[0m"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[33menable nginx\e[0m"
systemctl enable nginx

echo -e "\e[33mstarting nginx\e[0m"
systemctl start nginx


