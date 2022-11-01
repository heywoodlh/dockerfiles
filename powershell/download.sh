#!/usr/bin/env bash

## Get version numbers
export VERSION_TAG=$(curl -sL https://api.github.com/repos/PowerShell/PowerShell/releases/latest | jq -r ".tag_name")
export VERSION_NUMBER=$(echo $VERSION_TAG | tr -d 'v')
export MAJOR_VERSION_NUMBER=$(echo $VERSION_TAG | cut -d '.' -f 1 | tr -d 'v')

export arch=$(arch)

## Logic to match Powershell repo's arch 
[[ ${arch} == 'x86_64' ]] && export release_arch='x64'
[[ ${arch} == 'aarch64' ]] && export release_arch='arm64'
[[ ${arch} == 'armv7l' ]] && export release_arch='arm32'

## Download Powershell release
curl -L https://github.com/PowerShell/PowerShell/releases/download/${VERSION_TAG}/powershell-${VERSION_NUMBER}-linux-${release_arch}.tar.gz -o /tmp/powershell.tar.gz

## Extract Powershell and make executable
mkdir -p /opt/microsoft/powershell/${MAJOR_VERSION_NUMBER}
tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/${MAJOR_VERSION_NUMBER}
chmod +x /opt/microsoft/powershell/${MAJOR_VERSION_NUMBER}/pwsh
