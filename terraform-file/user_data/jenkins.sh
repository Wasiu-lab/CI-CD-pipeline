#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y openjdk-11-jdk
wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y jenkins
if which jenkins > /dev/null; then
  echo "Installation of Jenkins successful" > /var/log/install-status.log
else
  echo "Installation of Jenkins failed" > /var/log/install-status.log
fi
