#!/bin/bash

rsync -av custom.d/build.gradle cas-overlay-template/build.gradle
rsync -av custom.d/custom_theme/src/main cas-overlay-template/src/
rsync -av custom.d/etc/cas/ cas-overlay-template/etc/cas

echo "##################### RESTART/Rebuild DU CONTAINER #####################"

docker compose -f "docker-compose.yml" up -d --build