e = 1e-8;
A = [e,1;0,e];
[X,alpha,condx] = sqrtm(A);

B = [e,1,0;0,e,0;0,0,e];
[Y,beta,condy] = sqrtm(B);
well_condiB = [sqrt(e),0,1;0,sqrt(e),0;0,1,-sqrt(e)];
fprintf("norm(well_condiB**2 - A) = %d\n",norm(well_condiB^2 - B));
alpha_well_condiB = norm(well_condiB,1)^2/norm(A,1);
