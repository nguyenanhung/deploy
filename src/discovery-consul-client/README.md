# discovery-consul-client

* dependencies:
  * discovery-consul-server

because of kustomize's bug (https://github.com/kubernetes-sigs/kustomize/issues/2767), we have to have an addition folder (build) to store the builded manifest. If the bug is fixed, build folder will be deleted in the future