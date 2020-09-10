# discovery-consul-client

* dependencies:
  * discovery-consul-server

because of kustomize's bug, use kustomize build $dir -o out.yaml, after that remove duplicated port in out.yaml (usually tcp-dns or see log to find)