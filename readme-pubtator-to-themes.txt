How to go from raw PubTator files to themed dependency paths, assuming you are on Sherlock:

1. Break up the raw PubTator .gz file into smaller files of about 500k-1M lines.

break-raw-pubtator-file-sherlock.sh

2. Extract the raw dependency paths on all of those files, which takes like 3-4 days.

print-dependency-paths-sherlock.sh

3. Check to make sure the jobs completed (probably not necessary anymore).

check-job-success.sh

4. Create matrix for each entire dependency path dataset (1x1), which weeds out paths that don't meet criteria. It would be great if this were not the same as creating a matrix, but it works just as well.

Old way: create-matrices.sh (that was used on obama2 cluster)
New way: create-matrices-sherlock.sh

Note that these jobs run in ~50 min. 

5. Calculate theme distributions for all of the dependency paths in the new matrices. You do this by calculating their co-occurrences with the flagship paths from the earlier runs (the EBC runs that generated the clusters and hence the themes) using the following script:

assign-remaining-paths.py 

arg1: config/chemical-gene-remote.txt  <- the theme letters followed by cluster numbers
arg2: results-frames/chemical-gene-flagship-paths.txt <- flagship paths w/cluster numbers
arg3: matrices/Chemical-Gene-1x1.mat <- the new matrix you just created in step 4
arg4: results-frames/chemical-gene-path-theme-distributions.txt <- output (theme dists)

This script is wrapped in the following bash script (to submit jobs on slurm):

assign-remaining-paths-slurm.sh

This takes about 30 min.

6. If you want to go from theme *distributions* to just plain themes, you need to have some sort of cutoff for the theme distribution scores. Originally I did this by normalizing the scores (dividing by the total score for each path so that each theme assignment was a probability) and then only accepting those themes for which the normalized score was greater than 0.3. This meant that basically you could have no more than three theme assignments per path.

I really don't like this because it uses arbitrary cutoffs. I prefer the theme distributions, but for some applications, I guess this is helpful. Use the script assign-themes.py to do this.

assign-themes.py <theme distributions file> <output themes file>

Example:

assign-themes.py chemical-gene-path-theme-distributions.txt chemical-gene-path-themes.txt

#########################################################################################

To create the final supplement files:

1. Consolidate all the new dependency path mini-files into one big file per entity pair type.

consolidate-dependency-paths.sh

2. Sort the files by entity names. Unfortunately you cannot run this on the head node on Sherlock and now you need to do it using a script (i.e. slurm).

This is the basic command:

sort -k3,3 -k5,5 dependency-paths-chemical-gene.txt > dependency-paths-chemical-gene-sorted.txt 

Here's the script:

sort-dependency-paths-sherlock.sh

3. The files from step 2 are part of the supplement and should start with "part-ii-". The second part of the supplement restricts the paths to only those that have theme distributions.

You do this using the script:

restrict-dependency-paths-to-theme-paths.py

which, on Sherlock, is wrapped by the following bash script:

restrict-dependency-paths-to-themes-sherlock.sh

4. Rename the part i files, adding the "part-i-" designation to the beginning of the file names.

5. Compress (zip or gzip) all of the part-i and part-ii files so they are easier to upload/download from Zenodo.

gzip-files-for-upload.sh

CONGRATULATIONS, YOU'RE DONE!!!

