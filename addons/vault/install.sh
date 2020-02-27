#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com
helm repo update

# Create namespace vault
kubectl create ns vault
kubectl label ns vault istio-injection-

# Install mysql backend for vault
helm upgrade mysql stable/mysql \
    --install \
    --namespace vault \
    --set mysqlUser=vault \
    --set mysqlDatabase=vault \
    --wait

kubectl -n vault wait --for=condition=ready --timeout=120s po -l app=mysql

# Install the Vault with MySQL backend
helm upgrade vault banzaicloud-stable/vault \
    --install \
    --namespace vault \
    --set vault.config.storage.mysql.address=mysql.vault:3306 \
    --set vault.config.storage.mysql.username=vault \
    --set vault.config.storage.mysql.password="[[.Env.MYSQL_PASSWORD]]" \
    --set "vault.envSecrets[0].secretName=mysql" \
    --set "vault.envSecrets[0].secretKey=mysql-password" \
    --set "vault.envSecrets[0].envName=MYSQL_PASSWORD" \
    -f $DIR/values.yaml \
    --wait
