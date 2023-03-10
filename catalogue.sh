source function.sh 
LOG=/tmp/roboshop.log


set_location=$(pwd)
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y

id roboshop &>>${LOG}
if [ $? -ne 0 ] ; then
 useradd roboshop &>>${LOG}
fi


mkdir -p /app 
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
rm -rf /app/*
cd /app 
unzip /tmp/catalogue.zip
cd /app 
npm install 
cp ${set_location}/files/catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl enable catalogue 
systemctl start catalogue

cp ${set_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y

mongo --host 172.31.83.92 </app/schema/catalogue.js
systemctl restart catalogue