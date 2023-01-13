source function.sh 

set_location=$(pwd)
LOG=/tmp/roboshop.log

echo -e "loading files from curl command"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
condition_check

echo -e "installing node"
yum install nodejs -y &>>${LOG}
condition_check

echo -e "adding user"
useradd roboshop
condition_check

echo -e " making directory"
mkdir -p /app  &>>${LOG}
condition_check

echo -e " curl exceuting"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>${LOG}
condition_check

echo -e "changind dire"
cd /app &>>${LOG}
condition_check

echo -e " unzipping files"
unzip /tmp/cart.zip &>>${LOG}
condition_check

echo -e "change dire"
cd /app &>>${LOG}
condition_check

echo -e "installing npm"
npm install &>>${LOG}
condition_check

echo -e "copying cart.service "
cp ${set_location}/files/cart.service /etc/systemd/system/cart.service &>>${LOG}
condition_check

echo -e "reloading"
systemctl daemon-reload &>>${LOG}
condition_check

echo -e "enabling cart"
systemctl enable cart &>>${LOG}
condition_check

echo -e "starting cart"
systemctl start cart&>>${LOG}
condition_check