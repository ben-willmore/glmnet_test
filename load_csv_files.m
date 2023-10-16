function s = load_csv_files(data_dir)

	s = struct;

	files = dir([data_dir '/*.csv']);
	for ff = 1:length(files)
		bits = split(files(ff).name, '_');
		bit = bits{end};
		bits = split(bit, '.');
		varname = bits{1};
		if strcmp(varname, 'a')
			varname = 'a0';
		end
		data = readmatrix([data_dir '/' files(ff).name]);
		s = setfield(s, varname, data);
	end
end
