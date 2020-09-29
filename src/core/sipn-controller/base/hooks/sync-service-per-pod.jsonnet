function(request) {
  local pod = request.object,
  local nodeName = pod.spec.nodeName,
  local nodeNameHash = std.substr(std.md5(nodeName), 0, 10),
  local svcName = pod.metadata.annotations["sipn-svc-name"],
  local ports = pod.metadata.annotations["sipn-ports"],
  local namespace = pod.metadata.annotations["sipn-namespace"],

  // Create a service for each Pod, with a selector on the given label key.
  attachments: [
    {
      apiVersion: "v1",
      kind: "Service",
      metadata: {
        name: svcName + "-" + nodeNameHash,
        namespace: namespace
      },
      spec: {
        selector: {
          attachSipnSvc: svcName,
          nodeNameHash: nodeNameHash,
        },
        ports: [
          {
            local parts = std.split(ports, ":"),
            port: std.parseInt(parts[0]),
            targetPort: std.parseInt(parts[1]),
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
