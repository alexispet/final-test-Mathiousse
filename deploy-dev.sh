#!/bin/bash
# 'stole' the idea from Célian
echo "Deploying to dev environment..."
cd /path/to/your/project
sudo docker compose -f docker-compose.dev.yml down
sudo docker-compose -f docker-compose.dev.yml up -d
