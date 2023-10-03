#!/bin/bash
docker build -t forestghoul/multi-client:latest -t forestghoul/multi-client:$SHA ./client/Dockerfile ./client
docker build -t forestghoul/multi-server:latest -t forestghoul/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t forestghoul/multi-worker:latest -t forestghoul/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push forestghoul/multi-client:latest
docker push forestghoul/multi-server:latest
docker push forestghoul/multi-worker:latest
docker push forestghoul/multi-client:$SHA
docker push forestghoul/multi-server:$SHA
docker push forestghoul/multi-worker:$SHA
kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=forestghoul/multi-client:$SHA
kubectl set image deployments/server-deployment server=forestghoul/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=forestghoul/multi-worker:$SHA
