## k8s-service-scanner

k8s-service-scanner is a simple utility to scan all the services in a Kubernetes
cluster and print them out.

Currently, my use-case is to print them out for consumption in my Nuclei
vulnerability scanner deployment in my Kubernetes cluster:

https://github.com/heywoodlh/flakes/blob/6cac62abe125d7ae1e95845d392b45a36ace1497/kube/templates/nuclei.yaml#L107-L128

This service scanner allows me to automate vulnerability scanning in my cluster.

### Usage:

```
docker run -it --rm -v $HOME/.kube/config:/kubeconfig -e KUBECONFIG="/kubeconfig" docker.io/heywoodlh/k8s-service-scanner
```

Add the `EXTRA_TARGETS` environment variable with comma separated hostnames to
append to the list that is generated:

```
docker run -it -e EXTRA_TARGETS="192.168.1.0/24,example.com" --rm -v $HOME/.kube/config:/kubeconfig -e KUBECONFIG="/kubeconfig" docker.io/heywoodlh/k8s-service-scanner
```
