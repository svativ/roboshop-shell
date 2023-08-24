echo -e "\e[32>>>>>>>>>>> Create Catalogue service <<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[32>>>>>>>>>>> Create MongoDB Repo <<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32>>>>>>>>>>> Install NodeJS Repo <<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[32>>>>>>>>>>> Install NodeJS <<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[32>>>>>>>>>>> Create Application User <<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[32>>>>>>>>>>> Create Application Direcctory <<<<<<<<<<<\e[0m"
mkdir /app
echo
echo -e "\e[32>>>>>>>>>>> Download application content <<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[32>>>>>>>>>>> Extract Application Content <<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip
cd /app

echo -e "\e[32>>>>>>>>>>> Download Nodejs Client <<<<<<<<<<<\e[0m"
npm install

echo -e "\e[32>>>>>>>>>>> Install Mongo Client <<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[32>>>>>>>>>>> Load catalogue Schema <<<<<<<<<<<\e[0m"
mongo --host mongodb.sdevops99.online </app/schema/catalogue.js

echo -e "\e[32>>>>>>>>>>> Start Catalogue Service  <<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
