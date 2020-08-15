# Traefik ingress controller
* If scalability is a problem, use deployment instead of daemonset 
* Pros and cons of daemonset and deployment when deploy traefik-ingress-controller
  * Daemonset:
    * Less scalability
    * Automatically deploys pods to new nodes that joined the cluster
    * Can be run with the NET_BIND_SERVICE capability, which will allow it to bind to port 80/443/etc on each host (=> allow bypassing the kube-proxy, and reduce traffic hops but against K8s best practices https://kubernetes.io/docs/concepts/configuration/overview/#services)
  * Deployment:
    * More scalability (Auto scale)
