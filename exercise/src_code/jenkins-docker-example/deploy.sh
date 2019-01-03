#!/bin/bash
docker kill mobycounter redis > /dev/null 2>&1
docker rm mobycounter redis > /dev/null 2>&1
docker-compose up -d