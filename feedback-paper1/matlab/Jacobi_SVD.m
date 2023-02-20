function [ VX , X ] = Jacobi_SVD( X , tol , maxiter )
[m,n] = size(X);
VX = eye(n);
do_rot = true;
while do_rot
	do_rot = false;
	for p = 1:n-1
		for q = p + 1:n
			if abs(X(:,q)'*X(:,p)) > tol*norm(X(:,p))*norm(X(:,q))
				[c,s] = jacobi_pair(X'*X,p,q);
				J = [c,s;-s,c];
				X(:,[p,q]) = X(:,[p,q]) * J;
				VX(:,[p,q]) = VX(:,[p,q]) * J;
				do_rot = true;
			end
		end
	end
end
disp('V'); disp(VX);
disp('X'); disp(X);
end



function [c,s] = jacobi_pair(A,p,q)
if A(p,q) == 0
  c = 1; s = 0;
else
  tau = (A(q,q)-A(p,p))/(2*A(p,q));
  if tau >= 0
    t = 1/(tau + sqrt(1+tau*tau));
  else
    t = -1/(-tau + sqrt(1+tau*tau));
  end
  c = 1/sqrt(1+t*t);
  s = t*c;
end
end