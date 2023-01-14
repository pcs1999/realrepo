source function.sh

set_location=$(pwd)
LOG=/tmp/roboshop.log

print_head "install maven"
yum install maven -y 
condition_check

print_head "adding user"
#useradd roboshop 
condition_check

print_head "adding app direc"
mkdir -p /app  
condition_check

print_head "curl "
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
condition_check

print_head "change directory"
cd /app  
condition_check

print_head "unzipping"
unzip /tmp/shipping.zip 
condition_check

print_head "change directory"
cd /app 
condition_check

print_head "clean "
mvn clean package 
condition_check

print_head "target shiiping"
mv target/shipping-1.0.jar shipping.jar 
condition_check

print_head "copying"
cp ${set_location}/files/shipping.service /etc/systemd/system/shipping.service 
condition_check

print_head " reload"
systemctl daemon-reload 
condition_check

print_head "enable shipping"
systemctl enable shipping  
condition_check

print_head "start shipping"
systemctl start shipping 
condition_check

print_head "restart"
systemctl restart shipping 
condition_check

mysql -h 3.94.9.100 -uroot -pRoboShop@1 < /app/schema/shipping.sql 