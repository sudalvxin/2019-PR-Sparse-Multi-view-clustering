%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
% This is a demo for the LWEA and LWGP algorithms. If you find this %
% code useful for your research, please cite the paper below.       %
%                                                                   %
% Dong Huang, Chang-Dong Wang, and Jian-Huang Lai.                  %
% "Locally weighted ensemble clustering."                           %
% IEEE Transactions on Cybernetics, to appear, 2017.                %
%                                                                   %
% The code has been tested in Matlab R2014a and Matlab R2015a on a  %
% workstation with Windows Server 2008 R2 64-bit.                   %
%                                                                   %
% https://www.researchgate.net/publication/316681928                %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function allScores = computeNMI(results,gt)

allScores = zeros(size(results,2),1);
for i = 1:size(results,2)
    if min(results(:,i))>0
        allScores(i) = NMImax(results(:,i), gt);
    end
end

function NMImax = NMImax(x, y)

assert(numel(x) == numel(y));
n = numel(x);
x = reshape(x,1,n);
y = reshape(y,1,n);

l = min(min(x),min(y));
x = x-l+1;
y = y-l+1;
k = max(max(x),max(y));

idx = 1:n;
Mx = sparse(idx,x,1,n,k,n);
My = sparse(idx,y,1,n,k,n);
Pxy = nonzeros(Mx'*My/n); %joint distribution of x and y
Hxy = -dot(Pxy,log(Pxy+eps));

Px = mean(Mx,1);
Py = mean(My,1);

% entropy of Py and Px
Hx = -dot(Px,log(Px+eps));
Hy = -dot(Py,log(Py+eps));

% mutual information
MI = Hx + Hy - Hxy;

% maximum normalized mutual information
NMImax = MI/max(Hx,Hy);
