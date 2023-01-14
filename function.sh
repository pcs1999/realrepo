condition_check() {
    if [ $? -eq 0 ]
then
 echo success
else 
 echo failure
fi
}

print_head() {
  echo -e "\e[1m $1 \e[0m"
}