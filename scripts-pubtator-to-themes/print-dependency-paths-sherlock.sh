#!/bin/sh
# Make sure you're IN the pubtator-bioconcepts-${versiondate} directory when you submit this.
versiondate="20190915"
for FILE in pubtator-split-*;
do 
	echo ${FILE}
	filename=$(basename "${FILE}")
	extension="${FILE##*.}"
	filename="${FILE%.*}"
	sbatch --job-name=${filename} -p rbaltman --mail-user=blpercha@gmail.com --mail-type=FAIL,END --mem-per-cpu=6000 --time=7-00:00:00 --wrap="java -cp /home/groups/rbaltman/blpercha/pubtator-nlp-1.0-SNAPSHOT-jar-with-dependencies.jar -mx6g pubtator.parsing.PrintDependencyPaths /home/groups/rbaltman/blpercha/pubtator-bioconcepts-${versiondate}/${FILE} /home/groups/rbaltman/blpercha/pubtator-dependencies-${versiondate}/${FILE} 4 60" 
sleep 0.5 # pause for 1 second so we don't overload the scheduler  
done