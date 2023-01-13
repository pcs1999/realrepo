source function.sh 

set_location=$(pwd)
LOG=/tmp/roboshop.log

print_head "loading files from curl command"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
condition_check

print_head "installing node"
yum install nodejs -y &>>${LOG}
condition_check

print_head "adding user"
id roboshop &>>${LOG}
condition_check

print_head " making directory"
mkdir -p /app  &>>${LOG}
condition_check

print_head " curl exceuting"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>${LOG}
condition_check

print_head "changind dire"
cd /app &>>${LOG}
condition_check

print_head " unzipping files"
unzip /tmp/cart.zip &>>${LOG}
condition_check

print_head "change dire"
cd /app &>>${LOG}
condition_check

print_head "installing npm"
npm install &>>${LOG}
condition_check

print_head "copying cart.service "
cp ${set_location}/files/cart.service /etc/systemd/system/cart.service &>>${LOG}
condition_check

print_head "reloading"
systemctl daemon-reload &>>${LOG}
condition_check

print_head "enabling cart"
systemctl enable cart &>>${LOG}
condition_check

print_head "starting cart"
systemctl start cart&>>${LOG}
condition_check