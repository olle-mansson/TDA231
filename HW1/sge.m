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
    nSamples=size(x,1);
    np=numel(x);
    mu=mean(x);
    Z=x-repmat(mu,nSamples,1);
    sigma=sqrt((1/np)*sum(sum(Z.*Z)));
end