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




To delete your cluster after you finish
```
eksctl delete cluster -f EKS/cluster.yaml
```
and navigate to cloudfoundation on your AWS acconut and make sure to delete the stack




