clc;clear;close all;
A = randn(4); A = A'*A ; [Q,A] = qr(A);
A = abs(A); D = zeros(length(A),length(A));
for i = 1:length(A)
	D(i,i) = norm(A(i,i)); % row scaling
end
A_scaled = inv(D) * A;
disp(norm(A_scaled));