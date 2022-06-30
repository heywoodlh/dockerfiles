#!/usr/bin/env bash

arch_target=("amd64" "arm64" "armv7")
root_dir=$(pwd)
date_tag=$(date +%Y_%m_snapshot)

for arch in "${arch_target[@]}"
do
	target_dir="${root_dir}/${arch}"
	mkdir -p ${target_dir}
	cd ${target_dir}

	[[ ${arch} == "amd64" ]] && carch="amd64" && darch="linux/amd64" && qemu_arch="amd64" && label="amd64" && base_image='archlinux'
	[[ ${arch} == "arm64" ]] && carch="aarch64" && darch="linux/arm64" && qemu_arch="aarch64" && label="arm64" && base_image='heywoodlh/archlinuxarm'
	[[ ${arch} == "armv7" ]] && carch="armv7" && darch="linux/arm/v7" && qemu_arch="arm" && label="armv7" && base_image='heywoodlh/archlinuxarm'

	cp ${root_dir}/Dockerfile ${target_dir}/Dockerfile
	sed -e "s|%base_image%|${base_image}|g" -i ${target_dir}/Dockerfile

	[[ ${arch} == "arm64" ]] && cp ${root_dir}/arm64-pacman.conf ${target_dir}/pacman.conf && printf "COPY pacman.conf /etc/pacman.conf" >> ${target_dir}/Dockerfile
	[[ ${arch} == "armv7" ]] && cp ${root_dir}/arm-pacman.conf ${target_dir}/pacman.conf && printf "COPY pacman.conf /etc/pacman.conf" >> ${target_dir}/Dockerfile

	docker buildx build --no-cache --platform ${darch} --squash -t heywoodlh/archlinux:${label} -t heywoodlh/archlinux:${label}_${date_tag} --push .
done

images=''
for arch in "${arch_target[@]}"
do
	[[ ${arch} == "amd64" ]] && label="amd64"
	[[ ${arch} == "arm64" ]] && label="arm64"
	[[ ${arch} == "armv7" ]] && label="armv7"
	images+="heywoodlh/archlinux:${label} "
done

docker buildx imagetools create --tag heywoodlh/archlinux:latest ${images} 
docker buildx imagetools create --tag heywoodlh/archlinux:${date_tag} ${images} 
