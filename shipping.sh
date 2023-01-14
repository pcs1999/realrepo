source function.sh

set_location=$(pwd)
LOG=/tmp/roboshop.log

print_head "install maven"
yum install maven -y &>>${LOG}
condition_check

print_head "adding user"
useradd roboshop &>>${LOG}
condition_check

print_head "adding app direc"
mkdir /app  &>>${LOG}
condition_check

print_head "curl "
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>${LOG}
condition_check

print_head "change directory"
cd /app  &>>${LOG}
condition_check

print_head "unzipping"
unzip /tmp/shipping.zip &>>${LOG}
condition_check

print_head "change directory"
cd /app &>>${LOG}
condition_check

print_head "clean "
mvn clean package &>>${LOG}
condition_check

print_head "target shiiping"
mv target/shipping-1.0.jar shipping.jar &>>${LOG}
condition_check

print_head "copying"
cp ${set_location}/files/shipping.service /etc/systemd/system/shipping.service &>>${LOG}
condition_check

print_head " reload"
systemctl daemon-reload &>>${LOG}
condition_check

print_head "enable shipping"
systemctl enable shipping  &>>${LOG}
condition_check

print_head "start shipping"
systemctl start shipping &>>${LOG}
condition_check

print_head "restart"
systemctl restart shipping &>>${LOG}
condition_check