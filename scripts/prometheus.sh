#!/bin/bash

#Step 1: Create a new user Prometheus with the following command 

useradd --system --no-create-home --shell /usr/sbin/nologin prometheus 


#Step 2: Create a directory and change to the newly created directory using below commands 

mkdir /etc/prometheus 
cd /etc/prometheus 

#This directory is to store log files, data files, configuration files in single directory 

#Step 3: Download the latest version of Prometheus from the official website of Prometheus and install it on Ubuntu. 

wget https://github.com/prometheus/prometheus/releases/download/v2.33.4/prometheus-2.33.4.linux-amd64.tar.gz 

#Step 4: Extract the tar.gz archive with the following command 

tar xzf prometheus-2.32.1.linux-amd64.tar.gz 

#Step 5: move the unziped files to /etc/Prometheus directory using the below commands. 

Cd prometheus-2.33.4.linux-amd64 

mv -v * /etc/prometheus 

 
#Step 6: Change the user and group of all the files and directories of the /etc/prometheus/ directory to root. 

chown -Rfv root:root /etc/prometheus 

 

#Step 7: Fix the file and directory permissions of all the files and directories of the /etc/prometheus/ directory. 

chmod -Rfv 0755 /etc/prometheus 

 #Step 8: Prometheus needs a directory where it can store the metrics that it had collected. Create a new directory data/ in the /etc/prometheus/ directory as follows. 

mkdir -v /etc/prometheus/data 

 

#Step 9: Change the user and group of the /etc/prometheus/data/ directory to prometheus as follows. 

chown -Rfv prometheus:prometheus /etc/prometheus/data 

 

#Step 10: Create a systemd service file prometheus.service, run the following command. 

vi /etc/systemd/system/prometheus.service 

 [Unit] 

Description=Monitoring system and time series database 

 

[Service] 

Restart=always 

User=Prometheus 

 

ExecStart=/etc/prometheus/Prometheus  --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/etc/prometheus/data 

 

ExecReload=/bin/kill -HUP $MAINPID 

TimeoutStopSec=20s 

SendSIGKILL=no 

LimitNOFILE=8192 

 

[Install] 

WantedBy=multi-user.target 

 

#Step 11: For the systemd changes to take effect, run the following command. 

systemctl daemon-reload 

#Step 12: Start the prometheus service with the following command. 

systemctl start prometheus.service 

#Step 13: Add the prometheus service to the system startup, so that it automatically starts on boot with the following command. 

systemctl enable prometheus.service 
