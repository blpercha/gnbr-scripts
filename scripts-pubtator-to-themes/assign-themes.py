import sys

if __name__ == '__main__':
	input_distributions_file = sys.argv[1]
	output_file = sys.argv[2]

	# for each path, print cooccurrence distribution
	input_file = open(input_distributions_file, 'r')
	header_line = input_file.readline().strip().split('\t')
	headers = [header_line[j] for j in range(1, len(header_line), 2)]
	path_scores = {}
	path_indicators = {}
	print headers
	for line in input_file:
		sl = line.strip().split('\t')
		path = sl[0]
		scores = [float(sl[i]) for i in range(1, len(sl), 2)]
		indicators = [int(sl[i]) for i in range(2, len(sl), 2)]
		path_scores[path] = scores
		path_indicators[path] = indicators
	input_file.close()

	# print final frame assignments for each path (we just use cutoff of 1.0, not optimal cutoff)
	fout = open(output_file, 'w')
	for path in sorted(list(path_scores.keys())):
		sum_path_scores = sum(path_scores[path])
		if sum_path_scores <= 1.0:
			continue
		frame_assignments = [h for i, h in enumerate(headers) if float(path_scores[path][i]) / sum_path_scores > 0.3]
		frame_indicators = [path_indicators[path][i] for i, h in enumerate(headers) if h in frame_assignments]
		if len(frame_assignments) == 0:
			continue
		fout.write('%s\t%s\t%s\t%f\n' % (path, ' '.join(frame_assignments),
										 ','.join([str(e) for e in frame_indicators]),
										 sum_path_scores))
	fout.flush()
	fout.close()
