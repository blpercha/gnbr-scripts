sbatch --job-name=cdthemes -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-i-chemical-disease-path-theme-distributions.txt"

sbatch --job-name=cgthemes -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-i-chemical-gene-path-theme-distributions.txt"

sbatch --job-name=gdthemes -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-i-gene-disease-path-theme-distributions.txt"

sbatch --job-name=ggthemes -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-i-gene-gene-path-theme-distributions.txt"


sbatch --job-name=cdsorted -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-ii-dependency-paths-chemical-disease-sorted.txt"

sbatch --job-name=cdsortedt -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-ii-dependency-paths-chemical-disease-sorted-with-themes.txt"


sbatch --job-name=cgsorted -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-ii-dependency-paths-chemical-gene-sorted.txt"

sbatch --job-name=cgsortedt -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-ii-dependency-paths-chemical-gene-sorted-with-themes.txt"


sbatch --job-name=gdsorted -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-ii-dependency-paths-gene-disease-sorted.txt"

sbatch --job-name=gdsortedt -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-ii-dependency-paths-gene-disease-sorted-with-themes.txt"


sbatch --job-name=ggsorted -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-ii-dependency-paths-gene-gene-sorted.txt"

sbatch --job-name=ggsortedt -p rbaltman --mail-user=blpercha@alumni.stanford.edu --mail-type=FAIL,END --wrap="gzip /home/groups/rbaltman/blpercha/experiments-pubtator-v-20190915/part-ii-dependency-paths-gene-gene-sorted-with-themes.txt"
