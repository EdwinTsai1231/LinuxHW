touch ./missing_list
touch ./wrong_list
mkdir ./compressed_files/rar/
mkdir ./compressed_files/tar.gz/
mkdir ./compressed_files/zip/
mkdir ./compressed_files/unknown/

cat student_id|while read line 
do
	filename=$(find ./compressed_files -name "$line.*")

	if [ -z "$filename" ];then
		echo $line >> ./missing_list
	fi

	if [ -f "$filename" ] ; then
		temp=${filename##*/}
		extension=${temp#*.}

		case $extension in 
			"rar")
				mv $filename ./compressed_files/rar/
			;;

			"tar.gz")
				mv $filename ./compressed_files/tar.gz/
			;;

			"zip")
				mv $filename ./compressed_files/zip/
			;;

			*)
				mv $filename ./compressed_files/unknown/
				echo $line >> ./wrong_list
			;;
		esac

	fi

done

for file in ./compressed_files/rar/* ; do
	name=${file##*/}
	unrar e ./compressed_files/rar/$name ./compressed_files/rar
done

for file in ./compressed_files/tar.gz/* ; do
	name=${file##*/}
	tar zxvf ./compressed_files/tar.gz/$name -C ./compressed_files/tar.gz
done

for file in ./compressed_files/zip/* ; do
	name=${file##*/}
	unzip ./compressed_files/zip/$name -d ./compressed_files/zip
done

