code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

print_head() {
  echo -e "\e[36m$1\e[0m"
}

status_check() {
  if [ $1 -eq 0 ]; then
    echo success
  else
    echo failure
    echo
    exit 1
  fi
}

schema_setup() {
if [ "${schema_type}" == "mongo" ]; then
  print_head "copy mongodb repo file"
    cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
    status_check $?

    print_head "install mongo client"
    yum install mongodb-org-shell -y &>>${log_file}
    status_check $?

    print_head "load schema"
    mongo --host mongodb-dev.hyder71.online </app/schema/${component}.js &>>${log_file}
    status_check $?
fi

}

nodejs() {
  print_head "configure nodejs repo"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
  status_check $?

  print_head "installing nodejs"
  yum install nodejs -y &>>${log_file}
  status_check $?

  print_head "create roboshop user"
  id roboshop &>>${log_file}
   if [ $? -ne 0 ]; then
  useradd roboshop &>>${log_file}
  fi
  status_check $?

  print_head "create application directory"
  if [ ! -d /app ]; then
    mkdir /app &>>${log_file}
  fi
  status_check $?

  print_head "remove old content"
  rm -rf /app/* &>>${log_file}
  status_check $?


  print_head "downloading app content"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
  cd /app
  status_check $?

  print_head "extracting app content"
  unzip /tmp/${component}.zip &>>${log_file}
  status_check $?

  print_head "installing nodejs dependencies"
  npm install &>>${log_file}
  status_check $?

  print_head "copy systemd service file"
  cp ${code_dir}/configs/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
  status_check $?

  print_head "reload systemd"
  systemctl daemon-reload &>>${log_file}
  status_check $?

  print_head "enable ${component} service"
  systemctl enable ${component} &>>${log_file}
  status_check $?

  print_head "start ${component} service"
  systemctl restart ${component} &>>${log_file}
  status_check $?


 schema_setup
}