### Node Selector

| stt |  component | label |
|:-:|---|---|
| 1  | Ingest Server  | type=ingest |
| 2 | Transcoder Server | type=transcode |
| 3 | Packager Server | type=packager, |
| 4 | Origin Master | type=origin-master |
| 5 | Kubernetes + Api Server | type=api |
| 6 | Monitoring Server | type=monitor |
| 7 | Central logging system | type=logging |
| 8 | Origin Node | role=origin-node<br />dataDir={local diskpath}<br />originRef={Path reference đến dir} |


### Resource name convention
[Warning] when copy deployment from dev to (other env like prod), should change imagePullPolicy -> Always

* use alias as k8s resource (e.g: deployment -> deploy.yaml, service -> svc.yaml, statefulset -> sts, ...)

* group: controllers cannot have multi env (e.g: At the same time, there cannot be both dev and prod env existed)

