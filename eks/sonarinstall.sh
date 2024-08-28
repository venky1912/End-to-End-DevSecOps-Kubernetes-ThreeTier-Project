#!/bin/bash
# Update and install required packages
apt-get update -y
apt-get install -y openjdk-11-jdk wget gnupg2 postgresql postgresql-contrib

# Install SonarQube
useradd -m -d /opt/sonarqube -s /bin/bash sonarqube
cd /opt/sonarqube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.6.1.59531.zip
apt-get install -y unzip
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
EOT

# Start PostgreSQL and SonarQube
systemctl enable postgresql
systemctl start postgresql

su - sonarqube -c "/opt/sonarqube/bin/linux-x86-64/sonar.sh start"

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

[Install]
WantedBy=multi-user.target
EOT

systemctl enable sonarqube
