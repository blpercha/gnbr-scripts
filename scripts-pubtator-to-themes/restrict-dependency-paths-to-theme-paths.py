import sys

if __name__ == '__main__':
	theme_distributions_file = sys.argv[1]
	dependency_paths_file = sys.argv[2]
	output_file = sys.argv[3]

	# get theme distribution paths
	allowed_paths = set()
	with open(theme_distributions_file, 'r') as themefile:
		themefile.readline()  # throw away headers
		for line in themefile:
			sl = line.split('\t')
			lowercase_path = sl[0]
			allowed_paths.add(lowercase_path)

	# restrict dependency paths to these allowed paths
	fout = open(output_file, 'w')
	with open(dependency_paths_file, 'r') as fin:
		line_count = 0
		for line in fin:
			sl = line.strip().split('\t')
			lowercase_path = sl[12].lower()
			if lowercase_path not in allowed_paths:
				continue
			fout.write(line)
	fout.flush()
	fout.close()
