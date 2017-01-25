function [mu, sigma] = sge(x)
%
% SGE Mean and variance estimator for spherical Gaussian distribution                               
%
% x     : Data matrix of size n x p where each row represents a 
%         p-dimensional data point e.g. 
%            x = [2 1;
%                 3 7;
%                 4 5 ] is a dataset having 3 samples each
%                 having two co-ordinates.
%
% mu    : Estimated mean of the dataset [mu_1 mu_2 ... mu_p] 
% sigma : Estimated standard deviation of the dataset (number)                 
%
n=size(x,1);
p=size(x,2);
mu = [mean(x(:,1)) mean(x(:,2)) ];

sigma = sqrt(1/(n*p)*(sum(sum((x-mu).^2))));
