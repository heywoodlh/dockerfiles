#!/usr/bin/env bash

# Loop through each namespace
for namespace in $(kubectl get ns -o name | cut -d'/' -f2)
do
    for service in $(kubectl get services -n "${namespace}" -o name | cut -d'/' -f2 | sort -u)
    do
        echo "${service}.${namespace}.svc.cluster.local"
    done
done
