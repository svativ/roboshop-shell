mysql_root-password=$1
if [ -z "${mysql_root-password}" ]; then
  echo INput password Missing
  exit 1
fi
cp mysql.repo /etc/yum.repos.d/mysql.repo
yum module disable mysql -y
yum install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld
mysql_secure_installation --set-root-pass ${mysql_root-password}
