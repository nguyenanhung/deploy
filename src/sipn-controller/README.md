# sipn-controller (aka: service, ingress per node)
* use:
  add annotation to pod(in replica set or deployment, sts, ...) to allow each service and ingress (nginx) per node that point to that pod
* dependencies:
  * meta-controller
* explain base files
  * hooks/: define rules
  * decorator-controller.yaml: define resource to call hooks rules
  * deployment.yaml: fetch hooks folder via configmap and use jsonnet controller to parse rule and expose http API
  * service.yaml: expose deployment