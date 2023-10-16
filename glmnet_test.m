% run the glmnet QuickStartExample and check results against
% those from R on linux/mac

% results of running r_export.r on CRAN-installed R/glmnet on linux/mac (etc)
comparison_dir = 'matlab-glnxa64'; % 'linux'

save_results = true;

save_dir = sprintf('matlab-%s', computer('arch'));

tol = 1e-9;
fprintf('Tolerance = %0.1e\n', tol);

dirnames = {'quickstart', 'poisson', 'binomial'};
families = {'gaussian', 'poisson', 'binomial'};
algs = {'glmnet', 'glmnet', 'cvglmnet', 'cvglmnet'};
datatypes = {'regular', 'sparse', 'regular', 'sparse'};

failed = false;

for idx = 1:length(dirnames)
	dirname = dirnames{idx};
	family = families{idx};
	fprintf('\n== Testing %s (%s family)\n', dirname, family);

	for mm = 1:length(algs)
		alg = algs{mm};
		datatype = datatypes{mm};


		comparison_data_dir = sprintf('./comparison-data/%s/%s-%s', ...
			comparison_dir, dirname, alg);

		check_data = load_csv_files(comparison_data_dir);

		fprintf('\nFitting wth %s on %s data...', alg, datatype);
		x = check_data.x;
		if strcmp(datatype, 'sparse')
			x = sparse(x);
		end
		if contains(alg, 'cvglmnet')
			fit = feval(alg, x, check_data.y, family, [], [], [], check_data.foldid);
		else
			fit = feval(alg, x, check_data.y, family);
		end
		fprintf('done\n');

		fprintf('Checking results...');
		max_diff = maxdiff_vs_csv_data(fit, check_data, tol);
		if max_diff<tol
			fprintf('OK, max difference = %0.1e (within tolerance)\n', max_diff);
		else
			fprintf('** FAILED, max difference = %0.1e (above tolerance) **\n', max_diff);
			failed = true;
		end

		if save_results && strcmp(datatype, 'regular')
			save_data_dir = sprintf('./comparison-data/%s/%s-%s', ...
	                                 save_dir, dirname, alg);
			fit.x = check_data.x;
			fit.y = check_data.y;
			if contains(alg, 'cvglmnet')
				fit.foldid = check_data.foldid;
			end
			save_csv_files(save_data_dir, dirname, fit);
		end
	end
end

if failed
	fprintf('\n** SOME TESTS FAILED TO MATCH **\n');
else
	fprintf('\nAll ok!\n');
end

if save_results
	fprintf('\nResults saved to ''%s''\n', save_dir);
end
