echo '-------Installing KubeArmor on GKE Cluster (typically in ~2 mins)'
starttime=$(date +%s)

# Add helm chart repo
helm3 repo add kubearmor https://kubearmor.github.io/charts 
helm3 repo update kubearmor

# Install KubeArmor
helm3 upgrade --install kubearmor-operator kubearmor/kubearmor-operator -n yong-kubearmor --create-namespace 
kubectl apply -f ./kubearmor-sample-config.yaml

# Install KubeArmor CLI
curl -sfL http://get.kubearmor.io/ | sh -s -- -b ~/ack-casa

# Deploy a test nginx app
kubectl create namespace yong-nginx
kubectl create deployment nginx4yong1 --image=nginx -n yong-nginx

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to install KubeArmor with karmor CLI is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'