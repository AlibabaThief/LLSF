% ========================================================================================
% To reproduct the results published in our  paper, the following parameters are suggested.
% On the other hand, best parameter setting could be searched by cross validation on the 
% training data by the function 'JLCLS_adaptive_validate'
% ========================================================================================
% JLCLS
% Parameters     : alpha, beta, gamma
% for genbase    : 2^-10, 2^-3, 0.1
% for medical    : 2^-1, 2^-1, 0.1
% for arts       : 2^-8, 2^-2, 1
% for education  : 2^-10,2^-2, 10
% for science    : 2^-6, 2^-2, 1.5 
% for birds      : 2^-8, 2^-4, 10
% for business   : 2^-6, 2^-3, 100
% for computers  : 2^-6, 2^-3, 10
% for emotions    : 2^-5, 2^-2, 1.4
% for society    : 2^-8, 2^-2, 10
% for yeast    : 2^-6, 2^-2, 1
% for enron    : 2^-5, 2^-1, 1
% for flags    : 2^-6, 2^-1, 1