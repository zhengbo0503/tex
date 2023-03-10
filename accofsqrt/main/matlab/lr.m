function [i,T1,T2,D] = lr(A)
%LR LR iteration for diagonalization.
% [P,D] = lr(A) will compute a similar transformation of A,
% such that T1*A*T2=D, where D is diagonal with A's
% eigenvalues on its diagonal in arbitrary order.
% invP * P = I, however, P * invP =/= I
chol(A); % check pos. def.
% A(k+1) = R(k)...R(1) A(1) inv(R(1))...inv(R(k))
maxiter = 1e3; n = size(A,1); tol = n * eps/2;
T1 = eye(n); T2 = eye(n); print1 = true; A1 = A;
for i = 1:maxiter
    R = chol(A,'nocheck'); % A = R' * R;
%     R = chol(A);
	T1 = R * T1;
	T2 = T2 * inv(R); % T2 * inv(R)
	A = R * R';
	if (norm(T1 * A1 * T2 - A) >= n * norm(A1) * eps/2) && print1
		disp(i);
		print1 = false;
	end
% 	fprintf("norm(T1*T2 - eye(n)) = %d\n", norm(T1 * T2 - eye(n)));
% 	fprintf("norm(T2*T1 - eye(n)) = %d\n", norm(T2 * T1 - eye(n)));
	if off(A) <= tol
		break;
	end
end
D = diag(diag(A));
end




