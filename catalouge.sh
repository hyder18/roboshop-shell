curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app
rm -rf /app/*
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install
cp configs/catalouge.service /etc/systemd/system/catalouge.service

systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

cp configs/mongodb.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y

mongo --host mongodb.hyder71.online </app/schema/catalogue.js

