#!/usr/bin/env python
# coding: utf-8

# In[1]:


from os import listdir, makedirs
from csv import reader, writer
from platform import machine, system
import numpy as np

from scipy.sparse import csc_array

import glmnet_python
import glmnet
from glmnet import glmnet
import cvglmnet
from cvglmnet import cvglmnet


# In[2]:


def load_csv(dirname, filename, discard_rows=1, discard_cols=0):
    array = []
    with open(dirname + '/' + filename, 'r') as csvfile:
        rdr = reader(csvfile)
        for row in rdr:
            array.append(row)
    
    array = array[discard_rows:]
    array = [a[discard_cols:] for a in array]
    
    array = [[float(a) for a in row] for row in array]
        
    return np.array(array)

def load_csv_files(dirname):
    check_data = {}
    for filename in listdir(dirname):
        var = filename.split('_')[-1].split('.')[0]
        if var == 'a':
            var = 'a0'
        check_data[var] = load_csv(dirname, filename)
    return check_data

def maxdiff_vs_csv_data(fit_data, check_data, tol):
    fields = set(fit_data.keys()).intersection(check_data.keys())

    max_diff = []
    for field in fields:
        if field == 'nulldev':
            continue
        print(field, end=' ')
        d1 = fit_data[field]
        if not isinstance(d1, np.ndarray):
            d1 = np.array([d1])

        d2 = check_data[field]
        if not isinstance(d2, np.ndarray):
            d1 = np.array([d2])
        
        d1 = np.squeeze(d1)
        d2 = np.squeeze(d2)

        if len(d1.shape) != len(d2.shape) or np.any(d1.shape!=d2.shape):
            print('shape mismatch!', end = ' ')
            max_diff.append(np.inf)
        else:
            max_diff.append(np.max(np.abs(d1-d2)))
        if max_diff[-1] > tol:
            print('x', end=' ')

    return np.max(max_diff)

def save_csv_files(data_dir, dirname, dct):
    # skip nulldev which seems different in python
    selected_fields = ['x', 'y', 'a0', 'beta', 'lambda', 'dev', 'df']

    makedirs(data_dir, exist_ok=True)

    for field in selected_fields:
        if field not in dct:
            continue
            
        data = dct[field]
        if not isinstance(data, np.ndarray):
            data = np.array([data])
        data = np.squeeze(data)

        with open(data_dir + '/' + dirname + '_' + field + '.csv', 'w') as csvfile:
            wrtr = writer(csvfile, quotechar = "'")
            if len(data.shape) == 1:
                wrtr.writerow(['"x"'])
                for row in data:
                    wrtr.writerow([row])
            else:
                wrtr.writerow(['"V%d"' % i for i in range(data.shape[1])])
                for row in data:
                    wrtr.writerow(row)


# In[3]:


comparison_root = './comparison-data'
comparison_dir = 'matlab-glnxa64' # 'linux'

save_results = True

save_dir = '%s/python-%s-%s' % (comparison_root, system().lower(), machine())
print(save_dir)

tol = 1e-9;
print('Tolerance = %0.1e' % tol)

dirnames = ['quickstart', 'poisson', 'binomial']
families = ['gaussian', 'poisson', 'binomial']
algs = ['glmnet', 'glmnet', 'cvglmnet', 'cvglmnet']
datatypes = ['regular', 'sparse', 'regular', 'sparse']

failed = False

for dirname, family in zip(dirnames, families):
    print('\n== Testing %s (%s family)\n' % (dirname, family))
    
    for alg, datatype in zip(algs, datatypes):

        comparison_data_dir = '%s/%s/%s-%s' % (comparison_root, comparison_dir, dirname, alg)
        check_data = load_csv_files(comparison_data_dir)

        print('Fitting with %s on %s data...' % (alg, datatype), end='')
        x = check_data['x']
        if datatype=='sparse':
            x = csc_array(x)
        fitfunc = eval(alg)
        if 'cv' in alg:
            foldid = check_data['foldid'].astype(int)-1
            fit = fitfunc(x=x, y=check_data['y'], family=family, foldid=foldid)
        else:
            fit = fitfunc(x=x, y=check_data['y'], family=family)
        print('done')

        print('Checking results...', end='')
        max_diff = maxdiff_vs_csv_data(fit, check_data, tol)
        if max_diff<tol:
            print('\nOK, max difference = %0.1e (within tolerance)' % max_diff);
        else:
            print('\n** FAILED, max difference = %0.1e (above tolerance) **' % max_diff);
            failed = True;

        if save_results and datatype!='sparse':
            save_data_dir = '%s/%s-%s' % (save_dir, dirname, alg)
            fit['x'] = check_data['x']
            fit['y'] = check_data['y']
            if 'cv' in alg:
                fit['foldid'] = check_data['foldid']
            save_csv_files(save_data_dir, dirname, fit)

if failed:
    print('\n** SOME TESTS FAILED TO MATCH **')
else:
    print('\nAll ok!')

if save_results:
    print('\nResults saved to ''%s''' % save_dir)

