% Example that the Newton iteration is not stable
clc; clear; close all; rng(1);
d = 1/3;
Q = rand_or(16); % generate random orth. mtx using qmult
T = triu(randn(16)); T_diag = abs(diag(T));
T_diag(1:8) = d * T_diag(1:8); 
T_diag(9:16) = -1 * d * T_diag(9:16);
T = T - diag(diag(T)) + diag(T_diag);
A = Q * T * Q';
[X,k] = signm_newton(A,Q);
fun = @(x) x/abs(x); 
k_sign = funm_condest_fro(A,fun); % estimate the condition number

% d = 1/3
% smallest rel. err. 7.815284e-02
% k_sign(A) = 3.0556e+08
% Norm(S,2) = 7.4998e+09
% Norm(A,2) = 7.4647e+13

% d = 1 
% smallest rel. err. 3.573666e-08
% k_sign(A) = 3.1727e+08
% Norm(S,2) = 7.6222e+04
% Norm(A,2) = 6.0953e+00
