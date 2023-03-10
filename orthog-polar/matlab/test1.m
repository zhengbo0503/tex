% testscript Version Date : 2023-03-05
clc; close all; clear; rng(1);
%%
endsize = 3e3;
n = round(linspace(10,endsize,1e2));
orth_ns = zeros(1,length(n)); 
orth_mgs = zeros(1,length(n));
orth_qr = zeros(1,length(n));
for i = 1:length(n)
    % generating test matrices
    A = my_randsvd(n(i), 100,'geo');
    [V,~] = eig(single(A)); V = double(V); 
    % orthogonality of Newton-Schulz
    V_new = nsorth(V);
    orth_ns(i) = norm( V_new' * V_new - eye(n(i)), inf );
    % orthogonality of modified Gram Schmidt
	[Q,~] = mgs(V);  
	orth_mgs(i) = norm( Q' * Q - eye(n(i)), inf );
	% orthogonality of matlab qr
	[Q,~] = qr(V);
	orth_qr(i) = norm( Q' * Q - eye(n(i)), inf );
	fprintf("finish iteration %d/%d\n",i,length(n));
end

%%
close all;
loglog(n,orth_ns, "-^b" ); hold on;
% loglog(n,orth_mgs);
loglog(n,orth_qr,'-xr');
loglog(n, n.^(0.8) * eps(1/2),'--k');
xlabel("$n$","Interpreter","latex");
ylabel("Deviation from orthogonality")
legend( ...
	"N-S iteration", ...
...% 	"MGS", ...
	"MATLAB \texttt{qr()}", ...
	"$nu_{\mathrm{double}}$", ...
	"location","northwest","interpreter","latex");
xlim([0,endsize]);
axis square 
    


