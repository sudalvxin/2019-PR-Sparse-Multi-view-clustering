%% SMVSC
function W = LowMVSC(Cw,lambda)
% Input: Cw: n*n*v: v similarity matrices
%        lambda: regularization parameter
c = length(Cw);
[m,n]= size(Cw{1});
TW = zeros(m,n);
for i = 1:c
    wi = Cw{i};
    TW = TW + wi;
end
lambda = lambda/2*c;
[U S V] = svd(TW);
s = diag(S);
s = max(s - lambda,0);
W = U*diag(s)*V';
% W = max(TW - lambda,0) + min(TW + lambda,0);