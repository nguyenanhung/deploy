## System Requirement Detail

| stt |  component | Cấu hình | SL  tối thiểu HA | SL phục vụ 2000 luồng | Yêu cầu storage                                              |
|:-:|---|---|---|---|---|
| 1  | Ingest Server  | 16 vCPU 2.5GHz, 32GB RAM, | 2 | 5 | Type: LocalStorage<br /> Đọc ghi tối thiểu 400 * 5Mbps<br />Size: phụ thuộc vào thời gian lưu trữ |
| 2 | Transcoder Server | Theo tài liệu sizing đã có |   |   |  |
| 3 | Packager Server + Origin | 24 vCPU 2.5GHz, 64GB RAM | 2 | 5 | Type: LocalStorage<br /> Đọc ghi tối thiểu 400 * 8Mbps<br />Size: phụ thuộc vào thời gian lưu trữ |
| 4 | Origin Master | 8 vCPU 2.5GHz, 16GB RAM | 2 | 4 | 50GB HDD |
| 5 | Kubernetes + Api Server | 4 vCPU 2.5GHz, 8GB RAM | 4 | 4 | 50GB HDD |
| 6 | Monitoring Server | 4 vCPU 2.5GHz, 8GB RAM | 2 | 2 | Type: LocalStorage<br /> Size: 500GB/node |
| 7 | Central logging system | 4 vCPU 2.5GHz, 8GB RAM | 3 | 3 | Type: LocalStorage<br /> Size: 500GB/node |

* Note: 

  * Ngoại trừ Transcoder server, các node khác đều có thể sử dụng Vps
  * Đảm bảo băng thông cao tối thiểu 10 Gbps giữa các cụm thành phần: **Ingest**  <-> **Transcoder** <-> **Packager**
  * Cấu hình server đảm bảo 70-80% tải hệ thống

* Transcoder:
  * Hệ thống transcoder được tách biệt so với các thành phần khác nếu không sử dụng ramdisk làm storage live chỉ cần yêu cầu băng thông input đủ từ ingest đến transcoder và multicast đến packager

<div style="page-break-after: always;"></div>

## Network Requirement

| stt |  component | Ingest | Transcoder | Packager | Origin                          | Api  Server | Monitor | Logging | Internet out |
|:-:|---|---|---|---|---|---|---|---|---|
| 1  | Ingest Server  | (1) | (1) | (1) | (1) | (1), 6443/tcp | (1) | (1) | (3)         |
| 2 | Transcoder Server | (1)       | (1) | (1) | (1) | (1), 6443/tcp | (1) | (1) | (3)       |
| 3 | Packager Server | (1) | (1) | (1) | (1) | (1), 6443/tcp           | (1) | (1) | (3) |
| 4 | Origin Master | (1) | (1) | (1) | (1)    | (1), 6443/tcp           | (1) | (1) | (3) |
| 5 | K8s + Api Server | (1), 10250/tcp | (1), 10250/tcp | (1), 10250/tcp | (1), 10250/tcp | (2)        | (1), 10250/tcp | (1), 10250/tcp | (4) |
| 6 | Monitoring Server | (1), 9100/tcp | (1), 9100/tcp | (1), 9100/tcp | (1), 9100/tcp | (1), 6443/tcp, 9100/tcp | (1), 9100/tcp | (1), 9100/tcp | (3) |
| 7 | Central logging system | (1) | (1) | (1) | (1) | (1), 6443/tcp | (1) | (1) | (3) |
| 8 | Internet In | 1935/tcp |            |  | 80,443/tcp |  |  |  |  |
| 9 | External System call |  |            |  |  | (5) |  |  |  |

* Detail: 
  * **(1)**: 2376/tcp, 8472/udp, 4789/udp, 9099/tcp\*, 10254/tcp\*, 30000-30100/tcp
  * **(2)**: 2376/tcp, 2379-2380/tcp, 6443/tcp, 8472/udp, 4789/udp, 10250/tcp, 9099/tcp\*, 10254/tcp\*, 30000-30100/tcp
  * **(3)**: 
    * git.vgame.us:5000 (123.30.235.50)
    * hub.docker.com
  * **(4)**: 
    * git.vgame.us:5000 (123.30.235.50)
    * hub.docker.com
    * git.rancher.io (2):
      35.160.43.145:32
      35.167.242.46:32
      52.33.59.17:32
  * **(5)**: 30000-30100/tcp, 80,443/tcp  
  * **(\*\*)**: tất cả các node có mở port **9099/tcp, 10254/tcp** chỉ sử dụng trên node đó