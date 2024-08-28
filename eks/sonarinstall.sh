#!/bin/bash
# Update and install required packages
apt-get update -y
apt-get install -y openjdk-11-jdk wget gnupg2 unzip postgresql postgresql-contrib

# Install SonarQube
useradd -m -d /opt/sonarqube -s /bin/bash sonarqube
cd /opt/sonarqube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.6.1.59531.zip
unzip sonarqube-9.6.1.59531.zip
mv sonarqube-9.6.1.59531/* /opt/sonarqube
chown -R sonarqube:sonarqube /opt/sonarqube

# Set up PostgreSQL
sudo -i -u postgres psql -c "CREATE DATABASE sonardb;"
sudo -i -u postgres psql -c "CREATE USER sonaruser WITH ENCRYPTED PASSWORD 'sonarpass';"
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE sonardb TO sonaruser;"

# Configure SonarQube to connect to PostgreSQL
cat <<EOT >> /opt/sonarqube/conf/sonar.properties
sonar.jdbc.username=sonaruser
sonar.jdbc.password=sonarpass
sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonardb
sonar.web.javaAdditionalOpts=-server
sonar.web.host=0.0.0.0
sonar.web.port=9000
EOT

# Increase system limits for SonarQube
sysctl -w vm.max_map_count=262144
sysctl -w fs.file-max=65536
ulimit -n 65536
ulimit -u 4096

# Start PostgreSQL and SonarQube services
systemctl enable postgresql
systemctl start postgresql

# Ensure SonarQube starts on boot
cat <<EOT >> /etc/systemd/system/sonarqube.service
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking

ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop

User=sonarqube
Group=sonarqube
Restart=always

LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target
EOT

systemctl enable sonarqube

# Ensure port 9000 is open
ufw allow 9000/tcp

