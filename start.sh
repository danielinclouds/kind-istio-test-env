#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Create cluster
kind create cluster


# Install Istio
kubectl create ns istio-system
istioctl manifest apply \
    --set profile=default \
    --set values.prometheus.enabled=false

kubectl label namespace default istio-injection=enabled


# Install metallb
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml
kubectl apply -f "$DIR"/metallb/metallb-config.yaml


# Configure static route
sudo route -v add -net 172.17.255.1 -netmask 255.255.255.0 10.0.75.2
# sudo route -n delete 172.17.255/24 10.0.75.2


# Wait for istio to start
kubectl -n istio-system wait --for=condition=ready --timeout=120s po -l app=sidecarInjectorWebhook

