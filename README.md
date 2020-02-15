How to install squid on kubernetes
```
# workaround an error with gpg after the command `add-apt-repository -y ppa:git-core/ppa` in the idt-installer script
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24
curl -sL https://ibm.biz/idt-installer | bash
ibmcloud login -a cloud.ibm.com -r <us-south> -g Default
# login for container registry
ibmcloud cr region-set <us-south>
ibmcloud cr login
# check ibm cloud zones and locations - https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones
ibmcloud regions
ibmcloud ks supported-locations
ibmcloud ks zone ls
# select region
ibmcloud target -r <eu-de>
# or unselect
ibmcloud target --unset-region
# create cluster with name
ibmcloud cs cluster-create --name <scndcluster> --zone <mil01> --location <mil01> --machine-type free
# when it finished
ibmcloud cs clusters
# check worker is working and get external ip
ibmcloud cs workers <scndcluster>
# replace with cluster name
ibmcloud ks cluster config --cluster <scndcluster>
# export according to last command output
export KUBECONFIG=/home/chantzish/.bluemix/plugins/container-service/clusters/<scndcluster/kube-config-mil01-scndcluster>.yml
# check worker is working and get external ip
ibmcloud cs workers <scndcluster>
kubectl run guestbook --image=chantzish/kube-squid
# check the pod is running
kubectl get pod
kubectl expose deployment guestbook --type="NodePort" --port=3128
# get the node port
kubectl get service guestbook
```
