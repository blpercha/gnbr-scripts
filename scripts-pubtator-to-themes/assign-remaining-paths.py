import sys
from collections import defaultdict


def get_dependency_paths_by_pair(matrix_fil, etype1, etype2):
    _paths_by_pair = defaultdict(list)
    with open(matrix_fil, 'r') as matfil:
        for line in matfil:
            sl = line.strip().split('\t')
            _entity1 = sl[0]
            _entity2 = sl[1]
            _path = sl[2]
            _count = int(sl[3])
            _paths_by_pair[((_entity1, etype1), (_entity2, etype2))].append((_path, _count))
    return _paths_by_pair


def read_config(config_fil):
    _cluster_mappings_reversed = defaultdict(set)
    _ordered_names = []
    with open(config_fil, 'r') as cfgfil:
        for _line in cfgfil:
            _sl = _line.strip().split('\t')
            _name = _sl[0]
            _ordered_names.append(_name)
            _clusters = _sl[1].split(',')
            for _cluster in _clusters:
                _cluster_mappings_reversed[_cluster].add(_name)
    return _cluster_mappings_reversed, _ordered_names


def read_frame_paths_file(cluster_data_file, cluster_map):
    fpaths = defaultdict(set)
    with open(cluster_data_file, 'r') as framfil:
        for _line in framfil:
            _sl = _line.strip().split('\t')
            _path = _sl[0]
            _cluster = _sl[1]
            if _cluster not in cluster_map:
                continue
            for _name in cluster_map[_cluster]:  # the same cluster can contribute to multiple frames
                fpaths[_name].add(_path)
    return fpaths


if __name__ == '__main__':
	theme_to_cluster_ids_file = sys.argv[1]
	flagship_path_to_cluster_id_file = sys.argv[2]
	large_matrix_file = sys.argv[3]
	output_file = sys.argv[4]

	# get sets of frame paths
	cluster_mapping, ordered_names = read_config(theme_to_cluster_ids_file)
	frame_path_map = read_frame_paths_file(flagship_path_to_cluster_id_file, cluster_mapping)

	# get dependency paths by pair for large matrix
	paths_by_pair = get_dependency_paths_by_pair(large_matrix_file, None, None)

	# for each path, get its distribution of cooccurrences with frame paths
	co_occurrences_counts = defaultdict(list)
	n_pairs = len(paths_by_pair)
	for i, pair in enumerate(list(paths_by_pair.keys())):
		print i, n_pairs
		for path, count in paths_by_pair[pair]:
			for other_path, other_count in paths_by_pair[pair]:
				# if path == other_path:  # can't vote for yourself
				# 	continue
				for frame in frame_path_map:
					if other_path in frame_path_map[frame]:
						co_occurrences_counts[path].extend([frame] * count)

	# for each path, print cooccurrence distribution
	fout = open(output_file, 'w')
	fout.write('%s\t%s\n' % ('path', '\t'.join(['\t'.join([e, e + '.ind']) for e in ordered_names])))
	for path in co_occurrences_counts:
		fout.write('%s' % path)
		for frame in ordered_names:
			score = float(co_occurrences_counts[path].count(frame))
			fout.write('\t' + '%f' % score + '\t' + ('1' if path in frame_path_map[frame] else '0'))
		fout.write('\n')
		fout.flush()
	fout.close()
