function [iter,P,D,X] = sqrtm_lr(A)
%SQRTM_LR compute the matrix square root using the LR iteration
n = size(A,1);
[iter,P,D] = lr(A);
for i = 1:n, D(i,i) = sqrt(D(i,i)); end
X = P\D*P;
end
