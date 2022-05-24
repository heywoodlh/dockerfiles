#!/usr/bin/env bash

[[ -z ${GOTIFY_URI} ]] && echo 'Please set GOTIFY_URI variable.' && error='true'
[[ -z ${GOTIFY_TOKEN} ]] && echo 'Please set GOTIFY_TOKEN variable.' && error='true'

[[ ${error} == 'true' ]] && echo 'Exiting.' && exit 0

/app/run.sh "${GOTIFY_URI}" "${GOTIFY_TOKEN}"
