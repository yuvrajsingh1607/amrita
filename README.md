# amrita
https://www.linuxtechi.com/install-kubernetes-on-ubuntu-22-04/comment-page-4/#google_vignette?utm_content=cmp-true
sudo swapoff -a

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab


sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay

sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf <<EOT
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOT

sudo sysctl --system

sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update

sudo apt install -y containerd.io

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1

sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

sudo systemctl restart containerd

sudo systemctl enable containerd

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update

sudo apt install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl




===============================================================

sudo kubeadm init --control-plane-endpoint=k8smaster.example.net



Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join k8smaster.example.net:6443 --token g9qdci.sk2snd3u2m98mpyp \
        --discovery-token-ca-cert-hash sha256:050e9ea17cb5475758b6fad9ca3600feb0484d1c85deb800cc1abe95cf437268 \
        --control-plane

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join k8smaster.example.net:6443 --token g9qdci.sk2snd3u2m98mpyp \
        --discovery-token-ca-cert-hash sha256:050e9ea17cb5475758b6fad9ca3600feb0484d1c85deb800cc1abe95cf437268


kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/tigera-operator.yaml
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/calico.yaml

kubectl get pods -n kube-system

kubectl get nodes

kubectl create deployment nginx-app --image=nginx --replicas=2

kubectl get deployment nginx-app

kubectl expose deployment nginx-app --type=NodePort --port=80

kubectl get svc nginx-app

kubectl describe svc nginx-app



sudo swapoff -a
sudo kubeadm init --control-plane-endpoint=k8smaster.example.net
nc -zv 192.168.178.18 10250

sudo swapoff -a
sudo systemctl status kubelet
sudo systemctl stop kubelet
sudo systemctl start kubelet
sudo systemctl status kubelet


kubectl get pods -n kube-system -l k8s-app=calico-node

kubectl delete pod calico-node-wjwqg  -n kube-system --grace-period=0 --force

kubectl delete pod -n kube-system -l k8s-app=calico-node



sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


docker build -t yuvrajone/nginx-app .

docker login -u yuvrajone

docker push yuvrajone/nginx-app

docker build -t yuvrajone/nginx-app:v1.0.0 .

docker push yuvrajone/nginx-app:v1.0.0



kubectl apply -f nginx-deployment.yaml

kubectl logs nginx-app-f76945774-tl62b -c nginx
