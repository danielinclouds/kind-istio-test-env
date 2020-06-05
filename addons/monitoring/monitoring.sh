#!/bin/bash

# Preparing namespace for helm 3
kubectl create namespace monitoring

# Prometheus
helm upgrade prometheus stable/prometheus \
    --install \
    --namespace=monitoring \
    --set nodeExporter.enabled=false \
    --set alertmanager.enabled=false \
    --set pushgateway.enabled=false \
    --set server.global.scrape_interval=10s \
    --set server.global.scrape_timeout=5s \
    --set server.global.evaluation_interval=10s \
    --values ./prometheus-values.yaml


# Grafana
kubectl -n monitoring create secret generic grafana-admin \
    --from-literal="admin-user=admin" \
    --from-literal="admin-password=admin"

helm upgrade grafana stable/grafana \
    --install \
    --namespace=monitoring \
    --values ./grafana-values.yaml