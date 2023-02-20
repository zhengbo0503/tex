function F = funm_ev(A,fun)
[V,D] = eig(A); disp(cond(V));
F = V * diag(feval(fun,diag(D))) / V;