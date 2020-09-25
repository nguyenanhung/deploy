function(request) {
  local pod = request.object,
  local nodeName = pod.spec.nodeName,
  local attachSipnSvc = pod.metadata.annotations["sipn-svc-name"],

  // Inject the Pod name as a label with the key requested in the annotation.
  labels: {
    nodeNameHash: std.substr(std.md5(nodeName), 0, 10),
    attachSipnSvc: attachSipnSvc,
  }
}