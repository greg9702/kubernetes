#!/bin/bash

set -e

IMAGE_NAME=my-kube-scheduler
IMAGE_TAG=1.0
SCHEDULER_DEPLOYMENT_FILE=my-scheduler-deployment.yaml

echo ================================================ BUILDING BINARY ================================================
make
echo ================================================ BUILDING IMAGE  ================================================
docker build -t $IMAGE_NAME:$IMAGE_TAG .
echo ================================================  LOADING IMAGE  ================================================
kind load docker-image $IMAGE_NAME:$IMAGE_TAG
echo =============================================== RUNNING SCHEDULER ===============================================
kubectl delete -f $SCHEDULER_DEPLOYMENT_FILE || true
kubectl apply -f $SCHEDULER_DEPLOYMENT_FILE
echo =================================================== COMPLETED ===================================================