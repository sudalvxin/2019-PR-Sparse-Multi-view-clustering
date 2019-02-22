function [ids] = spectral_clustering(W,k)

D = diag(1./sqrt(sum(W, 2)));
W = D * W * D;
[U, s, V] = mySVD(W,k);
V = normr(U);

ids = kmeans(V, k, 'emptyaction', 'singleton', 'replicates', 1, 'display', 'off');
