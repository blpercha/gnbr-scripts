#!/bin/bash 

sbatch --job-name=breakfile -p rbaltman --mail-user=blpercha@gmail.com --mail-type=FAIL,END --mem-per-cpu=5000 --time=3-00:00:00 --wrap="java -cp /home/groups/rbaltman/blpercha/pubtator-nlp-1.0-SNAPSHOT-jar-with-dependencies.jar pubtator.breakfile.BreakRawPubtatorFile /home/groups/rbaltman/blpercha/bioconcepts2pubtator_offsets.gz 1000000 /home/groups/rbaltman/blpercha/pubtator-bioconcepts-20190915/pubtator-split 0" 



