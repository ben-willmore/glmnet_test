function s = save_csv_files(data_dir, dirname, strct)
	selected_fields = {'x', 'y', 'a0', 'beta', 'lambda', 'dev', ...
	                   'df', 'nulldev', 'cvlo', 'cvm', 'cvsd', ...
	                   'cvup', 'lambda', 'nzero', 'foldid'};

	if not(isfolder(data_dir))
		mkdir(data_dir);
	end

	fields = fieldnames(strct);

	for ff = 1:length(fields)
		name = fields{ff};

		if ~any(strcmp(selected_fields, name))
			continue
		end
		data = num2cell(getfield(strct, name));
		sz = size(data);
		if sz(2)==1
			headers = {'x'};
		else
			headers={};for ii=1:size(data,2);headers{ii}=sprintf('V%d',ii);end;
		end
		parts = {headers, data};
		data = cat(1, parts{:});
		writecell(data, [data_dir '/' sprintf('%s_%s.csv', dirname, name)]);
end
