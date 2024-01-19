#!/bin/bash
# 'stole' the idea from Célian
echo "Deploying to prod environment..."
sudo docker compose -f docker-compose.prod.yml down
sudo docker compose -f docker-compose.prod.yml up -d
