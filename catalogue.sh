echo ">>>>>>>>>>> Create Catalogue service <<<<<<<<<<<"
cp catalogue.service /etc/systemd/system/catalogue.service

echo ">>>>>>>>>>>  Create MongoDB Repo  <<<<<<<<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo ">>>>>>>>>>> Install NodeJS Repo <<<<<<<<<<<"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo ">>>>>>>>>>> Install NodeJS <<<<<<<<<<<"
yum install nodejs -y

echo ">>>>>>>>>>> Create Application User <<<<<<<<<<<"
useradd roboshop

echo ">>>>>>>>>>> Create Application Direcctory <<<<<<<<<<<"
mkdir /app

echo ">>>>>>>>>>> Download application content <<<<<<<<<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo ">>>>>>>>>>> Extract Application Content <<<<<<<<<<<"
cd /app
unzip /tmp/catalogue.zip
cd /app

echo ">>>>>>>>>>> Download Nodejs Client <<<<<<<<<<<"
npm install

echo ">>>>>>>>>>> Install Mongo Client <<<<<<<<<<<"
yum install mongodb-org-shell -y

echo ">>>>>>>>>>> Load catalogue Schema <<<<<<<<<<<"
mongo --host mongodb.sdevops99.online </app/schema/catalogue.js

echo ">>>>>>>>>>> Start Catalogue Service  <<<<<<<<<<<"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
