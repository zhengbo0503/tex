clear; close all; clc; rng(1);
addpath("~/Dropbox/matlab/mftoolbox/");
kappa = [1e2:1e2:1e3,2e3:1e3:1e4,2e4:1e4:1e5,...
	2e5:1e4:1e6,2e6:1e5:1e7,2e7:1e6:5e7];
for i = 1:length(kappa)
	fprintf("%d/%d\n", i, length(kappa));

	X = gallery("randsvd", 1e2, -1 * kappa(i), 1); % Symm. pd. sqrt X
	A = X * X'; %TODO: multiplication may not accurate?
	

	[X1] = sqrt_chol_polar(A,'svd'); % Polar
	[X2] = sqrt_eig(A); % Schur
	fwd_err1(i) = norm(X1 - X)/norm(X);   % use Alg. 1
	fwd_err2(i) = norm(X2 - X)/norm(X);   % use Alg. 2
	bwd_err1(i) = norm(X1^2 - A)/norm(A); % use Alg. 1
	bwd_err2(i) = norm(X2^2 - A)/norm(A); % use Alg. 2
	condi(i) = cond(A,2);
end

%%
loglog(condi,fwd_err1,'-^',"MarkerSize",8); hold on;
loglog(condi,fwd_err2,'-o',"MarkerSize",8)
loglog(condi,bwd_err1,'--^',"MarkerSize",8)
loglog(condi,bwd_err2,'--o',"MarkerSize",8)
legend("Fwd. Err. Alg. 1","Fwd. Err. Alg. 2", ...
	"Bwd. Err. Alg. 1", "Bwd. Err. Alg. 2", ...
	"Location", "best");
xlabel("\kappa(A)")
ylabel("Error")
ylim([0,1e-7])
axis square 

function X = sqrt_chol_polar(A,method)
R = chol(A);
switch method
	case "newton"
		[~,X,~] = polar_newton(R); % newton
	case "svd"
		[~,X] = polar_svd(R); % svd
end
end

function X = sqrt_eig(A)
[Q,D] = eig(A); % Drmac Veselic
for i = 1:length(A), D(i,i) = sqrt(D(i,i)); end
X = Q * D * Q';
end