#!/bin/bash

# Install CRDs
kubectl apply --selector knative.dev/crd-install=true \
    --filename https://github.com/knative/serving/releases/download/v0.12.0/serving.yaml \
    --filename https://github.com/knative/eventing/releases/download/v0.12.0/eventing.yaml 
    # --filename https://github.com/knative/serving/releases/download/v0.12.0/monitoring.yaml

# Install Knative
kubectl apply \
    --filename https://github.com/knative/serving/releases/download/v0.12.0/serving.yaml \
    --filename https://github.com/knative/eventing/releases/download/v0.12.0/eventing.yaml 
    # --filename https://github.com/knative/serving/releases/download/v0.12.0/monitoring.yaml