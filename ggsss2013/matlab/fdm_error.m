clc; clear; close all;

% we would like to find the total error (truncation error + roundoff
% error) of f(x) = x^2 near x = 1. f'(x) = 2x.

power = -1:-1e-3:-16;
h = 10; h = h.^power;
error = zeros(length(h),1);
ref = 2; 
MC = 50;

for i = 1:length(h)
	acc = 0;
	for j = 1:MC
		acc = acc + ((1+h(i))*(1+h(i)) - 1)/h(i) - 2;
	end
	error(i) = acc/MC;
end

loglog(h,abs(error));
xlabel("Time step $(h)$");
ylabel("Total Error");
set(gca,"FontSize",20);