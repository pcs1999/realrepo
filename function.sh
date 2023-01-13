condition_check() {
    if [ $? -eq 0 ]
then
 echo success
else 
 echo failure
fi
}

id roboshop() {
    if [ $? -ne 0 ]
then
 useradd roboshop
fi
}

print_head() {
  echo -e "\e[1m $1 \e[0m"
}