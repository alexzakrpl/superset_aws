#!/bin/bash
yum update -y
amazon-linux-extras enable docker
yum install -y docker git
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Install Docker Compose Plugin >= 2.0
mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Switch to ec2-user context and deploy Superset
su - ec2-user -c "
  git clone https://github.com/alexzakrpl/superset_bi.git ~/superset_bi
  echo '${superset_env}' > ~/superset_bi/.env
  chmod +x ~/superset_bi/deploy_superset.sh
  cd ~/superset_bi
  ./deploy_superset.sh
"
