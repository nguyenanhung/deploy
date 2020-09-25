#/bin/bash

env=$1
kustomize build ./src/core/namespaces/overlays/$env | kubectl apply -f -