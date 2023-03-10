function V = nsorth(V)
% V = nsorth(V) Newton-Schulz iteration orthogonalization
% The input matrix should be an almost orthogonal matrix in the sense
% that the input is computed from the low precision eigensolver. This
% function is specifically for orthogonlizing an orthogonal matrix in
% single precision to double precision.
% After two iteration, the output matrix is orthogonal as
%			norm( V' * V - I ) = n * eps(1/2)
for i = 1:2
	V = 0.5 * (3 * V - (V * V') * V);
end
end
