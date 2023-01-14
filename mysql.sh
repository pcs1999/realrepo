source function.sh

if [ -z "${mysql_password_}"]; then
  echo "root_mysql_password_is_missing"
  exit 
fi 

dnf module disable mysql -y &>>${LOG}
condition_check

cp ${set_location}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>>${LOG}
condition_check

yum install mysql-community-server -y &>>${LOG} 
condition_check

systemctl enable mysqld &>>${LOG}
condition_check

systemctl start mysqld  &>>${LOG}
condition_check

mysql_secure_installation --set-root-pass ${mysql_password_} &>>${LOG}
condition_check

mysql -uroot -pRoboShop@1 &>>${LOG}
condition_check