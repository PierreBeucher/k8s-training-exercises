#!/usr/bin/env bash

helm -n datadog uninstall datadog-operator

kubectl delete ns datadog