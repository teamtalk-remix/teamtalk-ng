# Example Kubernetes Configurations for TeamTalk-NG

This directory contains example Kubernetes objects
in YAML format for deploying TeamTalk-NG server to Kubernetes.

## Usage

All Kubernetes objects are categorized into directories based on component names.

Please make sure to check and edit configmaps and secrets accordingly before applying them. If you want to keep your customizations separated from our example objects, consider to use [Kustomize][].

1. Prepare a Kubernetes namespace for your deployment.
For example, create a new namespace `teamtalk-ng`:

```sh
kubectl create ns teamtalk-ng
```

2. Deploy a component using `kubectl`:

```sh
kubectl apply -f ./db-mariadb
kubectl apply -f ./redis
kubectl apply -f ./db-proxy
kubectl apply -f ./login
kubectl apply -f ./route
kubectl apply -f ./msg
kubectl apply -f ./http-msg
kubectl apply -f ./msfs
kubectl apply -f ./file
kubectl apply -f ./dashboard
``

3. Expose your services with Ingress or LoadBalancer:

```sh
kubectl apply -f ./export-ingress # using Ingress
# or
kubectl apply -f ./export-lb # using LoadBalancer services
```


[Kustomize]: https://kustomize.io/
