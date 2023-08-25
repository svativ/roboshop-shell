log=/tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>> Create Catalogue service <<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>${log}

echo -e "\e[36m>>>>>>>>>>> Create MongoDB Repo <<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo -e "\e[36m>>>>>>>>>>> Install NodeJS Repo <<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

echo -e "\e[36m>>>>>>>>>>> Install NodeJS <<<<<<<<<\e[0m"
yum install nodejs -y &>>${log}

echo -e "\e[36m>>>>>>>>>>> Create Application User <<<<<<<<<<<\e[0m"
useradd roboshop &>>${log}

echo -e "\e[36m>>>>>>>>>>> Create Application Direcctory <<<<<<<<<<<\e[0m"
rm -rf /app &>>${log}


echo -e "\e[36m>>>>>>>>>>> Create Application Direcctory <<<<<<<<<<<\e[0m"
mkdir /app &>>${log}

echo -e "\e[36m>>>>>>>>>>> Download application content <<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}

echo -e "\e[36m>>>>>>>>>> Extract Application Content <<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip &>>${log}
cd /app

echo -e "\e[36m>>>>>>>>>>> Download Nodejs Client <<<<<<<<<<<\e[0m"
npm install &>>${log}

echo -e "\e[36m>>>>>>>>>>> Install Mongo Client <<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install mongodb-org-shell -y &>>${log}

echo -e "\e[36m>>>>>>>>>>> Load catalogue Schema <<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mongo --host mongodb.sdevops99.online </app/schema/catalogue.js &>>${log}

echo -e "\e[36m>>>>>>>>>>> Start Catalogue Service  <<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl daemon-reload &>>${log}

systemctl enable catalogue &>>${log}

systemctl restart catalogue &>>${log}

