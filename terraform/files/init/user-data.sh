#!/bin/bash
#This can be used as User Data, during EC2 launch wizard
apt update
apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

apt update
apt-cache policy docker-ce
apt install docker-ce -y

#Next 2 lines are different from official Kubernetes guide, but the way Kubernetes describe step does not work
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add
echo "deb https://packages.cloud.google.com/apt kubernetes-xenial main" > /etc/apt/sources.list.d/kurbenetes.list

#Turn off swap
swapoff -a

apt update
apt install kubelet kubeadm kubectl -y
#we need to get EC2 internal IP address- default ENI is eth0
export ipaddr=`ip address|grep eth0|grep inet|awk -F ' ' '{print $2}' |awk -F '\/' '{print $1}'`

#You can replace 172.16.0.0/16 with your desired pod network
kubeadm init --apiserver-advertise-address=$ipaddr --pod-network-cidr=172.16.0.0/16

#this adds .kube/config for root account, run same for ubuntu user, if you need it
mkdir -p /root/.kube
cp -i /etc/kubernetes/admin.conf /root/.kube/config

aws s3 cp s3://qualentum-dev-s3/kubernetes.yaml /root/kubernetes.yaml
kubectl apply -f /root/kubernetes.yaml

#Uncomment bellow lines if you need to install help
#curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
#echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
#apt update
#apt install helm -y