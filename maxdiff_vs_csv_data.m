function maxdiff = maxdiff_vs_csv_data(data, csv_data, tol)

	maxdiff = 0;
	fields = intersect(fieldnames(data), fieldnames(csv_data));
	if length(fields)==0
		disp('No overlapping fields to test!');
	end
	% fprintf('Checking fields: ');
	for ff = 1:length(fields)
		fprintf([fields{ff} ' ']);
		d1 = getfield(data, fields{ff});
		d2 = getfield(csv_data, fields{ff});
		try
			diff = d1 - d2;
			maxdiff(end+1) = max(max(abs(diff)));
		catch
			fprintf('shape mismatch! ');
			maxdiff(end+1) = inf;
		end
		if maxdiff(end) > tol
			fprintf('x ');
		end
	end
	maxdiff = max(maxdiff);
	fprintf('\n');
end
