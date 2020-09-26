#/bin/bash

env=$1

# check env
if [ "${env}" != "dev" ] && [ "${env}" != "staging" ] ; then
  echo '[ERROR] env should be dev or staging'
  exit
fi

# install
workloads=( \
  "meta-controller" \
  "node-origin" \
  "sipn-controller" \
  "srs-edge" \
  "srs-ocm" \
  "srs-origin" \
  "traefik-ingress-controller" \
  "consul-controller-sync-k8s" \
  )

builded_workloads=( \
  "consul-controller-client" \
  "consul-controller-server" \
  )

for workload in ${workloads[@]};
do
  kustomize build ./src/core/$workload/overlays/$env | kubectl apply -f -
done

for workload in ${builded_workloads[@]};
do
  kubectl apply -f ./src/core/$workload/build/${env}.yaml
done