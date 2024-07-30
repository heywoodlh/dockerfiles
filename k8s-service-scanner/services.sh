#!/usr/bin/env bash

# Loop through each namespace
for namespace in $(kubectl get ns -o name | cut -d'/' -f2)
do
    for service in $(kubectl get services -n "${namespace}" -o name | cut -d'/' -f2 | sort -u)
    do
        echo "${service}.${namespace}.svc.cluster.local"
    done
done

# Print EXTRA_TARGETS vars

if [[ -n ${EXTRA_TARGETS} ]]
then
  orig_ifs="${IFS}"
  IFS=','
  for target in ${EXTRA_TARGETS}
  do
    echo "${target}"
  done
  IFS="${orig_ifs}"
fi
