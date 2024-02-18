#### Follow [@YongkangHe](https://twitter.com/yongkanghe) on Twitter, Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

I just want to build an ACK Cluster (Alibaba Cloud Container Service for Kubernetes) to play with the various Security and Data Management capabilities for Containers e.g. Security Scans, Backup/Restore, Disaster Recovery and Application Mobility.

It is challenging to create an ACK cluster from Alibaba Cloud if you are not familiar to it. After the ACK Cluster is up running, you still need to create a sample DB, create policies etc.. The whole process is not that simple.

This script based automation allows you to build a ready-to-use ACK cluster with PostgreSQL deployed in about 10 minutes with just 1 Command. If you prefer to create an ACK Cluster via Web Console or API, you can watch the Youtube videos and follow the guide to build one on Alibaba Cloud.

# Build an ACK cluster via Web UI
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/JLdc4D9kAss/0.jpg)](https://www.youtube.com/watch?v=JLdc4D9kAss)

#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Build an ACK cluster via OpenAPI
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/eXjTSDmgcUE/0.jpg)](https://www.youtube.com/watch?v=eXjTSDmgcUE)

#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Here're the prerequisities. 

1. Go to Alibaba Cloud Shell or terminal
2. Verify if you can access the cluster via kubectl
````
kubectl get nodes
````
3. Clone the github repo, run below command
````
git clone https://github.com/yongkanghe/ack-casa.git
````
4. Optionally, you can customize the clustername, instance-type, zone, region, bucketname
````
vi setenv.sh
````

# ACK Cluster Automation 

1. To deploy an ACK cluster
````
./ack-deploy.sh
````

2. To destroy the ACK cluster after testing
````
./ack-destroy.sh
````

#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# CloudCasa - No. 1 Kubernetes Backup as a Service
https://cloudcasa.io 

# Contributors

#### Follow [Yongkang He](http://yongkang.cloud) on LinkedIn, Join [Kubernetes Data Management](https://www.linkedin.com/groups/13983251) LinkedIn Group
