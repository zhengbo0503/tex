% long term behavior between MGS and N-S
clc; close all; clear; rng(1);
%%
n = round(linspace(3e3,3e4,50));
orth_ns = zeros(1,length(n)); 
orth_mgs = zeros(1,length(n));
for i = 1:length(n)
    % generating test matrices 
    A = my_randsvd(n(i), 100,'geo');
    [V,~] = eig(single(A)); V = double(V); 
    % orthogonality of Newton-Schulz
    V_new = nsorth(V);
    orth_ns(i) = norm( V_new' * V_new - eye(n(i)), inf );
    % orthogonality of modified Gram Schmidt
	[Q,~] = mgs(V);  
	orth_mgs(i) = norm( Q' * Q - eye(n(i)), inf );
	fprintf("finish iteration %d/%d\n",i,length(n));
end
