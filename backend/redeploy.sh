sudo sh /home/ubuntu/server/scripts/login-to-ecr.sh
sudo sh /home/ubuntu/server/scripts/run-pull-secrets.sh
docker-compose pull
docker-compose down --remove-orphans
docker-compose up -d
sudo sh /home/ubuntu/server/scripts/delete-all-docker-files.sh