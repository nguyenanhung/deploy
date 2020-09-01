function(request) {
  local pod = request.object,
  local labelKey = pod.metadata.annotations["sipp-label-key"],
  local host= pod.metadata.annotations["sipp-host"],
  local rawPorts = pod.metadata.annotations["sipp-ports"],
  local namespace = pod.metadata.annotations["sipp-namespace"],
  local rawEntrypoints = pod.metadata.annotations["sipp-entrypoints"],

  attachments: [
    {
      apiVersion: "traefik.containo.us/v1alpha1",
      kind: "IngressRoute",
      metadata: {
        name: pod.metadata.name,
        labels: {app: "sipp"},
        namespace: namespace
      },
      spec: {
        local entryPoints = std.split(rawEntrypoints, ","),

        entryPoints: entryPoints,
        routes:[{
          local traefikHost = "Host(`" + host + "`)",
          local traefikPrefix = "PathPrefix(`/" + pod.metadata.name + "`)",

          match: traefikHost + " && " + traefikPrefix,
          kind: "Rule",
          services: [
            {
              local ports = std.split(rawPorts, ":"),

              name: pod.metadata.name,
              port: std.parseInt(ports[0])
            }
          ]
        }]
      }
    }
  ]
}
