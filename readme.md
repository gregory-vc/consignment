gcloud compute disks create --size=20GB --type=pd-ssd postgres-disk
gcloud compute disks create --size=20GB --type=pd-ssd mongo-disk
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin --user=$(gcloud config get-value core/account)