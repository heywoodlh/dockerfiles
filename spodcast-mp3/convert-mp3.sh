#!/usr/bin/env bash

root_dir=/data

files=$(find ${root_dir} -name "*.ogg")

for file in ${files}
do 
	base_ogg=${file%.ogg}
	base_name=$(echo "$(basename ${file})" | sed 's/.ogg//g')
	ogg_info="${file}.info"
	outfile="${base_ogg}.mp3"

	echo "converting ${file} to ${outfile}" \
		&& ffmpeg -n -loglevel quiet -i ${file} ${outfile} -speed 8
	sed -i 's/audio\/ogg/audio\/mp3/g' ${ogg_info}
	sed -i "s/${base_name}.ogg/${base_name}.mp3/g" ${ogg_info}
	cp ${base_ogg}.mp3 ${file}
	mv ${ogg_info} ${base_ogg}.mp3.info
	chown -R 101:101 ${root_dir}
done


