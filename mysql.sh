source function.sh

if [ -z "${mysql_password_}"]; then
  echo "root_mysql_password_is_missing"
  exit 
fi 
print_head "dnf module"
dnf module disable mysql -y &>>${LOG}
condition_check
 
print_head "copying files from mysql.repo"
cp ${set_location}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>>${LOG}
condition_check

print_head "installing my_sql "
yum install mysql-community-server -y &>>${LOG} 
condition_check

print_head "enabling mysql"
systemctl enable mysqld &>>${LOG}
condition_check

print_head "start mysql"
systemctl start mysqld  &>>${LOG}
condition_check

print_head "set password"
mysql_secure_installation --set-root-pass ${mysql_password_} &>>${LOG}
condition_check

