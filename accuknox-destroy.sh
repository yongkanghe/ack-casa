starttime=$(date +%s)
echo '-------Removing AccuKnox from ACK Cluster (typically in few mins)'

# Uninstall KubeArmor
helm uninstall accuknox-agents -n accuknox-agents
kubectl delete ns accuknox-agents

echo "" | awk '{print $1}'
endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"