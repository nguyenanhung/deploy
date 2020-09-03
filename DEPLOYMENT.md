# Resource name convention
[Warning] when copy deployment from dev to (other env like prod), should change imagePullPolicy -> Always

* use alias as k8s resource (e.g: deployment -> deploy.yaml, service -> svc.yaml, statefulset -> sts, ...)

* group: controllers cannot have multi env (e.g: At the same time, there cannot be both dev and prod env existed)

