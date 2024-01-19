#!/bin/bash
# 'stole' the idea from Célian
echo "Deploying to prod environment..."
cd /path/to/your/project
sudo docker compose -f docker-compose.prod.yml down
sudo docker-compose -f docker-compose.prod.yml up -d
