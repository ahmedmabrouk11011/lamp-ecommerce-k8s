#!/bin/bash

kubectl apply -f mysql-config.yaml

kubectl apply -f mysql-secrets.yaml

kubectl apply -f ecommerce-deployment.yaml

kubectl apply -f ecommerce-service-lb.yaml

