
function y = Test_SMVSC(X,label,para)
% Input: X:m*n*v
%          label: n*1
%          para: regualrization parameter
v = length(X);   % the number of views
k = max(label);  % clusters
n = length(label); % the number of instance


options.NeighborMode = 'KNN';
options.k = 10; 
options.WeightMode = 'HeatKernel';

% normalization
for i = 1 :v
    for  j = 1:n
         X{i}(j,:) = ( X{i}(j,:) - mean( X{i}(j,:) ) ) / std( X{i}(j,:) ) ;
    end
    A0 = constructW(X{i},options);
    Cw{i} = A0; 
end
W = SMVSC(Cw,para);

% spectral clustering
[y] = spectral_clustering(W, k);