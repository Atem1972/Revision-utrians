#!/bin/bash
sudo su #Switch to the root user bc the is no sudo befor yum install
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<html><h1><p> Welcome to Utrains.<br> You are redirected to ${HOSTNAME} to see how the load balancer is sharing the traffic.</p></h1></html>" > /var/www/html/index.html
# explanation of line 7 . it will display all the above message and will retrieve the name of our instance/ip address and also display it and redirect all of them to /var/www/html/index.html 
 # so that when will go to the browser we can see how the lb share data within instance using their name