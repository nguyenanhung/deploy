function(request) {
  local pod = request.object,

  // daemonset only
  local nodeName = pod.spec.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchFields[0].values[0],
  local nodeNameHash = std.substr(std.md5(nodeName), 0, 10),
  local svcName = pod.metadata.annotations["consul-svc-name"],
  local port = pod.metadata.annotations["consul-port"],
  local namespace = pod.metadata.annotations["consul-namespace"],
  local dataDir = pod.metadata.annotations["consul-data-dir"],

  // Create a service for each Pod, with a selector on the given label key.
  attachments: [
    {
      apiVersion: "v1",
      kind: "Service",
      metadata: {
        name: svcName + "-" + nodeNameHash,
        namespace: namespace,
        annotations: {
          "consul.hashicorp.com/service-name":  svcName,
          "consul.hashicorp.com/service-sync": "true",
          "consul.hashicorp.com/service-meta-dataRef": "/" + nodeNameHash,
          "consul.hashicorp.com/service-meta-dataDir": dataDir
        }
      },
      spec: {
        selector: {
          attachSipnSvc: svcName,
          nodeNameHash: nodeNameHash,
        },
        ports: [
          {
            port: std.parseInt(port),
            targetPort: std.parseInt(port),
          }
        ]
      }
    }
  ],
  labels: {
    nodeNameHash: nodeNameHash,
    attachSipnSvc: svcName,
  }
}
