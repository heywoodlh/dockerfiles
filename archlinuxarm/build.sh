#!/usr/bin/env bash

qemu_version="v6.1.0-8"
arch_target=("arm64" "armv7")
root_dir=$(pwd)
date_tag=$(date +%Y_%m_snapshot)

for arch in "${arch_target[@]}"
do
	target_dir="${root_dir}/${arch}"
	mkdir -p ${target_dir}
	cd ${target_dir}

	[[ ${arch} == "arm64" ]] && carch="aarch64" && darch="linux/arm64" && qemu_arch="aarch64" && label="arm64"
	[[ ${arch} == "armv7" ]] && carch="armv7" && darch="linux/arm/v7" && qemu_arch="arm" && label="armv7"

	wget -nc http://il.us.mirror.archlinuxarm.org/os/ArchLinuxARM-${carch}-latest.tar.gz
	
	wget -nc https://github.com/multiarch/qemu-user-static/releases/download/${qemu_version}/qemu-${qemu_arch}-static -O qemu-${qemu_arch}-static
	chmod +x qemu-${qemu_arch}-static

	cp ${root_dir}/Dockerfile ${target_dir}/Dockerfile
	cp ${root_dir}/locale.nopurge ${target_dir}
	sed -e "s|%qemu_arch%|${qemu_arch}|g" -e "s|%carch%|${carch}|g" -i ${target_dir}/Dockerfile

	docker buildx build --platform ${darch} --squash -t heywoodlh/archlinuxarm:${label} -t heywoodlh/archlinuxarm:${label}_${date_tag} --push .
done

images=""

for arch in "${arch_target[@]}"
do
	[[ ${arch} == "arm64" ]] && label="arm64"
	[[ ${arch} == "armv7" ]] && label="armv7"
	images+="heywoodlh/archlinuxarm:${label} "
done

docker buildx imagetools create --tag heywoodlh/archlinuxarm:latest ${images} 
docker buildx imagetools create --tag heywoodlh/archlinuxarm:${date_tag} ${images} 
