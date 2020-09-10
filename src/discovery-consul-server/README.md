# discovery-consul-server

how to scale sts.yaml:
  - update replicas value
  - add container 's command (-retry-join param, -bootstrap-expect param)

because of kustomize's bug, use kustomize build $dir -o out.yaml, after that remove duplicated port in out.yaml (usually tcp-dns or see log to find)