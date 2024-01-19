#!/bin/bash
# 'stole' the idea from Célian
echo "Deploying to dev environment..."
sudo docker compose -f docker-compose.dev.yml down
sudo docker compose -f docker-compose.dev.yml up -d
