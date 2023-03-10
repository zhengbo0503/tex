%%
clc; clear; close all; rng(1);
% test of lr.m
% n = 3;
% Q = rand_or(3);
% A = diag([2,2,2]);
% A = Q * A * Q';

n = 5;
A = gallery("randsvd",n,-5,3);
A_vpa = vpa(A,34);

[iter,T1,T2,D] = lr(A_vpa);

fprintf("Iter. Required = %d\n",iter); 
comp = sort(diag(D));
eiga = sort(eig(A));
fprintf("Abs. Err. of Evals = %d\n", norm(comp - eiga));
fprintf("norm(T2 * T1 - eye(n)) = %d\n", norm(T2 * T1 - eye(n)));
fprintf("norm(T1 * T2 - eye(n)) = %d\n", norm(T1 * T2 - eye(n)));
% fprintf("cond(T1) = %d, cond(T2) = %d\n", cond(T1,2), cond(T2,2));
fprintf("Rel. Err. = %d\n", norm(T1 * A * T2 - D));

% norm(T2 * T1 - eye(n)) is small, whileas 
% norm(T1 * T2 - eye(n)) is large
% norm(D * T1 - T1 * A) is accurate 
% norm(T1 * A * T2 - D) is large