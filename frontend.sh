set_location=$(pwd)

echo -e "\e[33m installing nginx\e[0m"
yum install nginx -y

echo -e "\e[33m enabling nginx\e[0m"
systemctl enable nginx 

prin -e "\e[33m satrting nginx\e[0m"
systemctl start nginx

echo -e "\e[33m removing existing file in html\e[0m"
rm -rf /usr/share/nginx/html/* 

echo -e "\e[33m downloading the file from internet\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 

echo -e "\e[33m changing directory to html\e[0m"
cd /usr/share/nginx/html 

echo -e "\e[33m unzipping the files\e[0m"
unzip /tmp/frontend.zip

echo -e "\e[33m copying config file to roboshop.conf nginx\e[0m"
cp ${set_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf 

echo -e "\e[33m starting nginx\e[0m"
systemctl restart nginx 