# EKS 

A- you need to create account access key and secret

Setps:
1- Sign in to your account

2- Navigate to the IAM service

3- Go for users

4- Select your username

5- Select Security Credintials

6- Create Access Key


B- Install AWS CLI and configure it

1- Download the AWS CLI

2- make sure the installation success by excuting

```
aws --version
```
3- configure the access key
```
aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json
```

Alternative Solution
download the eksctl

then

```
export AWS_ACCESS_KEY_ID=[...]

export AWS_SECRET_ACCESS_KEY=[...]

export KUBECONFIG=$PWD/kubeconfig.yaml

eksctl create cluster \
    --config-file EKS/cluster.yaml


kubectl get nodes
```

this will create a cluster with kubernetes version 1.20 with 3 t2.small worker nodes

then deploy the application 


```
./deploy-all.sh
```

Deploy Promethueus


```
kubectl apply -f prometheus/0-crd

kubectl apply -f prometheus/1-prometheus-operator

kubectl apply -f prometheus/2-prometheus


```


Deploy Nignx using HELM 


```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update

helm search repo nginx

helm install my-ing ingress-nginx/ingress-nginx --namespace ingress --version 3.35.0 --values my-ing/ingress-nginx/values.yaml --create-namespace

helm list -n ingress

```

Check Prometheus


```
kubectl port-forward svc/prometheus-operated 9090 -n monitoring
```

if you need to monitor nginx-ingress with promethues do the below

```
kubectl edit namespace ingress
```

Add the below label

``` 
monitoring: prometheus
```



Deploy Grafana

``` 
kubectl apply -f grafana
kubectl port-forward svc/grafana 3000 -n monitoring
```
After you login using admin/devops123 you should add new datasource 
http://prometheus-operated:9090

Now time to create new dashboard
Manage -> Import -> paste the ID '9614'


Now we will create Ingresses

1- make sure to paste your ingress DNS record to the host in the ingresses YAML

```
kubectl get svc -n ingress 
```

2- create the ingress for prometheus OR grafana OR Application
```
kubectl apply -f Ingresses/prometheus-ingress/
kubectl apply -f Ingresses/grafana-ingress/
kubectl apply -f Ingresses/application-ingress/
```
NOTE: you can't run Both in gress at the same time unless you used Custom DNS




To delete your cluster after you finish
```
eksctl delete cluster -f EKS/cluster.yaml
```
and navigate to cloudfoundation on your AWS acconut and make sure to delete the stack




