#!/bin/sh
#Make sure you CD to the pubtator-dependencies-YYYYMMDD directory first. :)
original_file_directory="/home/groups/rbaltman/blpercha/pubtator-bioconcepts-20190915"
dependency_file_directory="/home/groups/rbaltman/blpercha/pubtator-dependencies-20190915"
final_file_directory="/home/groups/rbaltman/blpercha/pubtator-dependencies-final-20190915"
for FILE in ${original_file_directory}/pubtator-split-*;
do 
	filename=$(basename "${FILE}")
	echo ${filename}
	last_pmid_orig=$(grep "." ${FILE} | tail -n100 | cut -d\| -f1 | cut -f1 | sort | uniq)
	FILE_dep=${dependency_file_directory}/${filename}
	last_pmid_dep=$(tail -n2 ${FILE_dep} | cut -d\| -f1 | cut -f1 | sort | uniq | head -n1)
	echo ${last_pmid_orig} 
	echo ${last_pmid_dep}
	if [[ "${last_pmid_orig}" == *"${last_pmid_dep}"* ]]; then
		echo "GOOD"
		mv ${FILE_dep} ${final_file_directory}/${filename}
		rm ${FILE}
	else
		echo "BAD"
	fi
done
