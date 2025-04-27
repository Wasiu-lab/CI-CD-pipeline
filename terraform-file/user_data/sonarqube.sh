#!/bin/bash
sudo apt update -y
sudo apt install -y unzip openjdk-11-jdk
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.1.69595.zip
unzip sonarqube-9.9.1.69595.zip
sudo mv sonarqube-9.9.1.69595 /opt/sonarqube
cd /opt/sonarqube/bin/linux-x86-64
./sonar.sh start
