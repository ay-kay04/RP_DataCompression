#!/bin/bash
echo "Enter directory name"
read direct
echo "Enter compression tool"
read tool

if [ $tool = "zip" ]
 then
 	echo "Enter compression level"
 	read numz
	echo "Zipping now"
	python3 script.py "zip -$numz -r z.zip $direct" "compression using zip, level $numz"
	echo "Unzipping now"
	python3 script.py "unzip z.zip" "decompression using zip"
	echo -e "\n"
elif [ $tool = "gzip" ]
 then
 	echo "Enter compression level"
 	read num
	echo "Compressing using gzip now"
	python3 script.py "tar cvf - $direct | gzip -$num - > archive.tar.gz" "compression using gzip, level $num"
	echo "Decompressing using gzip now"
	python3 script.py "tar -zxvf archive.tar.gz" "decompression using gzip"
	echo -e "\n"
elif [ $tool = "zstd" ]
 then
 
 	#python3 script.py "zstd --train -r "/trainingset" -o dict" "building dictionary"
 	
	echo "Enter level of compression"
	read level
	
	echo "Compressing using zstd now"
	python3 script.py "tar -I 'zstd -$level' -cf archive.tar.zst $direct" "compression using zstd, mode $level"
	echo "Decompressing using zstd now"
	python3 script.py "tar -I 'zstd --decompress' -xf archive.tar.zst $direct" "decompression using zstd"

	echo -e "\n"
else
	echo "Invalid tool" 
fi


