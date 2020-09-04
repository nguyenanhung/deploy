function(request) {
  local pod = request.object,
  local nodeName = pod.spec.nodeName,
  local nodeNameHash = std.md5(nodeName),
  local svcName = pod.metadata.annotations["sipn-svc-name"],
  local ports = pod.metadata.annotations["sipn-ports"],
  local namespace = pod.metadata.annotations["sipn-namespace"],

  attachments: [
    {
      apiVersion: "networking.k8s.io/v1beta1",
      kind: "Ingress",
      metadata: {
        name: svcName + "-" + nodeNameHash,
        namespace: namespace,
        annotations: {
          "nginx.ingress.kubernetes.io/rewrite-target": "/$2",
        }
      },
      spec: {
        rules: [{
          http: {
            paths: [{
              backend: {
                serviceName: svcName + "-" + nodeNameHash,

                local parts = std.split(ports, ":"),
                servicePort: std.parseInt(parts[0]),
              },
              path: "/" + nodeNameHash + "(/|$)(.*)"
            }]
          }
        }]
      }
    }
  ]
}
