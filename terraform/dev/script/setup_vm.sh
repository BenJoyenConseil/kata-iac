#! /bin/bash
sudo yum update
echo "SELINUX=permissive" | sudo tee /etc/selinux/config
sudo setenforce 0

# clone repo
sudo yum install -y git
git clone https://github.com/BenJoyenConseil/kata-iac.git
cd kata-iac
sudo git checkout master

# configure backend
sudo yum install -y httpd apr apr-util-sqlite
sudo mv apache/${env}/httpd.conf /etc/httpd/conf/httpd.conf

sudo systemctl start httpd
sudo systemctl enable httpd

