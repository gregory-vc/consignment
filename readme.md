gcloud compute disks create --size=20GB --type=pd-ssd postgres-disk
gcloud compute disks create --size=20GB --type=pd-ssd mongo-disk

kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin --user=$(gcloud config get-value core/account)


kubectl create secret docker-registry gcr-json-key \
          --docker-server=https://gcr.io \
          --docker-username=_json_key \
          --docker-password="$(cat /home/ami/source/aemedia/consignment/terraform/google-cred.json)" \
          --docker-email=its.crowd@gmail.com

kubectl patch serviceaccount default \
          -p '{"imagePullSecrets": [{"name": "gcr-json-key"}]}'

kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')

minikube addons configure registry-creds
minikube addons enable registry-creds

kubectl config use-context gke_my-project-tattoor_europe-west2-a_shippy-freight-cluster
kubectl config use-context minikube

kubectl port-forward mongo-controller-bfmkm 27018:27017
kubectl port-forward postgres-controller-jr8tg 5432:5432