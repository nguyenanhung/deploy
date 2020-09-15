#/bin/bash

env=$1

# check env
if [ "${env}" != "dev" ] && [ "${env}" != "staging" ] ; then
  echo '[ERROR] env should be dev or staging'
  exit
fi

# install
workloads=( \
  "namespaces"\
  "meta-controller"\
  "messaging-rabbitmq" \
  "metrics-es-exporter" \
  "metrics-mongo-exporter" \
  "metrics-node-exporter"\
  "node-origin" \
  "sipn-controller" \
  "srs-edge" \
  "srs-ocm" \
  "srs-origin" \
  "storage-es" \
  "storage-mongo" \
  "storage-prometheus" \
  "storage-loki-agent" \
  "storage-loki" \
  "traefik-ingress-controller" \
  "visualization-grafana" \
  "visualization-kibana" \
  "visualization-weavescope-agent" \
  "visualization-weavescope-frontend" \
  )
builded_workloads=("discovery-consul-client" "discovery-consul-server") #bug in kustomize => have to build first

for workload in ${workloads[@]};
do
  kustomize build ./src/$workload/overlays/$env | kubectl apply -f -
done

for workload in ${builded_workloads[@]};
do
  kubectl apply -f ./src/$workload/build/${env}.yaml
done