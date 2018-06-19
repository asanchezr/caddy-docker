#!/bin/bash

# Bring down any previously running containers
docker-compose down

# Build images
echo 'Building images...'
docker-compose build
echo 'Complete'

# Bring up new containers (silently)
docker-compose up -d

# Watch the logs
docker-compose logs -f
