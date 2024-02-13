echo '-------Creating an ACK Cluster now'
starttime=$(date +%s)
. ./setenv.sh

echo $MY_CLUSTER-$(date +%H%M) > ack_clustername

aliyun vpc CreateVpc --RegionId $MY_REGION --CidrBlock=$MY_VPC_CIDR | grep VpcId | awk '{print $2}' | sed -e 's/\"//g' > ack_vpcid
sleep 5
aliyun vpc CreateVSwitch --CidrBlock $MY_VSWITCH_CIDR --VpcId $(cat ack_vpcid) --ZoneId $MY_ZONE --RegionId $MY_REGION | grep VSwitchId | awk '{print $2}' | sed -e 's/\"//g' > ack_vswitchid
# aliyun ecs CreateKeyPair --RegionId $MY_REGION --region $MY_REGION --KeyPairName $MY_KEYPAIR --Tag.n.Key owner --Tag.n.Value yong > ack_keypair

echo "" | awk '{print $1}' > ack_openapi.url
sed -e "s/ap-southeast-1/$MY_REGION/g" openapi.template | sed -e "s/ack4yong1/$(cat ack_clustername)/g" | sed -e "s/vpc-t4n27ssvih3wgqwkocuta/$(cat ack_vpcid)/g" | sed -e "s/vsw-t4nlk73m4vfp9jhj39zo9/$(cat ack_vswitchid)/g" | sed -e "s/key4yong1/$MY_KEYPAIR/g" | sed -e "s/ecs.g5.xlarge/$MY_INSTANCE_TYPE/g" >> ack_openapi.url 
echo "" | awk '{print $1}' >> ack_openapi.url
echo "" | awk '{print $1}'
echo "Please Copy the whole OpenAPI URL and Paste it to your Web Browser and Press [Enter]"
echo "" | awk '{print $1}'
echo "Then Click 'Call Now' button from the Web Browser"
cat ack_openapi.url

read -p "Once you see 'Response 202' in few seconds from Web Browser, back to command line, Press [Enter]"
echo "" | awk '{print $1}'
echo '-------Waiting for completion of creating ACK Cluster'
sleep 240

echo '-------Still waiting for completion of creating ACK Cluster'
sleep 120

echo '-------Waiting for completion of installing addons'
sleep 90

# aliyun cs DescribeClustersV1 | jq '.clusters[].state' | grep running
aliyun cs DescribeClustersV1 | jq '.clusters[].state' | grep running
if [ `echo $?` -eq 1 ]
then
  sleep 30
fi

aliyun cs DescribeClustersV1| jq '.clusters[].state'  | grep running
if [ `echo $?` -eq 1 ]
then
  sleep 20
fi

aliyun cs DescribeClustersV1| jq '.clusters[].state'  | grep running
if [ `echo $?` -eq 1 ]
then
  sleep 10
fi

aliyun cs DescribeClustersV1| jq '.clusters[].state'  | grep running
if [ `echo $?` -eq 1 ]
then
  sleep 10
fi

aliyun cs DescribeClustersV1  --region $MY_REGION --name $(cat ack_clustername)| grep cluster_id | sed -e 's/\"//g' | sed -e 's/\,//g' | awk '{print $2}' > ack_clusterid

aliyun cs DescribeClusterUserKubeconfig --region $MY_REGION --ClusterId $(cat ack_clusterid) > ./ack_kubeconfig.json

# Run below command if yamlify2 does not exist
# cat <<EOF > ~/.jq
# def yamlify2:
#     (objects | to_entries | (map(.key | length) | max + 2) as \$w |
#         .[] | (.value | type) as \$type |
#         if \$type == "array" then
#             "\(.key):", (.value | yamlify2)
#         elif \$type == "object" then
#             "\(.key):", "    \(.value | yamlify2)"
#         else
#             "\(.key):\(" " * (.key | \$w - length))\(.value)"
#         end
#     )
#     // (arrays | select(length > 0)[] | [yamlify2] |
#         "  - \(.[0])", "    \(.[1:][])"
#     )
#     // .
#     ;
# EOF

# Obtain Kubeconfig file
aliyun cs GET /k8s/$(cat ack_clusterid)/user_config | jq -r '.config' >> $HOME/.kube/config

# jq -r yamlify2 ack_kubeconfig.json > ./ack_kubeconfig
# chmod 600 ./ack_kubeconfig

# export KUBECONFIG=./ack_kubeconfig
kubectl annotate sc alicloud-disk-essd storageclass.kubernetes.io/is-default-class=true

kubectl get nodes | grep aliyun
if [ `echo $?` -eq 1 ]
then
  sleep 10
fi

kubectl get nodes | grep aliyun
if [ `echo $?` -eq 1 ]
then
  sleep 5
fi

kubectl get nodes | grep aliyun
if [ `echo $?` -eq 1 ]
then
  sleep 5
fi

./pg-deploy.sh

echo "" | awk '{print $1}'
endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time to create ACK Cluster is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'