#!/usr/bin/env bash

helm repo add datadog https://helm.datadoghq.com
helm repo update

helm install -n datadog --create-namespace datadog-operator datadog/datadog-operator

kubectl apply -f resources/observability/datadog/dd-agent.yml
kubectl apply -f resources/observability/datadog/dd-secret.yml