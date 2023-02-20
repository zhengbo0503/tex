% Computes the exp(1) via symbolic and truncated Taylor series, and
% compare the error between these results

clc; close all; clear;
ref_sol = exp(-5.5);

for beta = 1:100
    taylor_sol = 0;
    for i = 0:(beta-1)
        taylor_sol = taylor_sol + ((-5.5)^i)/(factorial(i));
    end
    err(beta) =  abs(taylor_sol - ref_sol);
end

plot(1:100, err);
