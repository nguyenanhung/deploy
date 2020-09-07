### Node Selector

* Label conversion
  * Prefix: ***.sigmaott.com**
  * Name: 
    * **Node-role**: Boolean
    * **data-dir**: String
      * Value: replace "." by "/" for real path name 
  * Example: 
    * Livestream.sigmaott.com/ingest-role: true

| stt |  component | label |
|:-:|---|---|
| 1  | Ingest Server  | node-role.sigmaott.com/ingest |
| 2 | Transcoder Server | node-role.sigmaott.com/transcode |
| 3 | Packager Server | node-role.sigmaott.com/packager |
| 4 | Origin Master | node-role.sigmaott.com/origin-master |
| 5 | Kubernetes + Api Server | node-role.sigmaott.com/api |
| 6 | Monitoring Server | node-role.sigmaott.com/monitor<br /> sigmaott.com/data-dir |
| 7 | Central logging system | node-role.sigmaott.com/logging<br />sigmaott.com/data-dir |
| 8 | Origin Node | node-role.sigmaott.com/origin-node<br />sigmaott.com/data-dir<br /> |


### Resource name convention
[Warning] when copy deployment from dev to (other env like prod), should change imagePullPolicy -> Always

* use alias as k8s resource (e.g: deployment -> deploy.yaml, service -> svc.yaml, statefulset -> sts, ...)

* group: controllers cannot have multi env (e.g: At the same time, there cannot be both dev and prod env existed)


