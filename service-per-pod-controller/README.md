# service-per-pod-controller
* dependencies:
  * meta-controller
* explain base files
  * hooks/: define rules
  * decorator-controller.yaml: define resource to call hooks rules
  * deployment.yaml: fetch hooks folder via configmap and use jsonnet controller to parse rule and expose http API
  * service.yaml: expose deployment