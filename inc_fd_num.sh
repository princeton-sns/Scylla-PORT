sudo echo "* soft nofile 200000" >> /etc/security/limits.conf
sudo echo "* hard nofile 200000" >> /etc/security/limits.conf

sudo echo "session required /lib/security/pam_limits.so" >> /etc/pam.d/login
