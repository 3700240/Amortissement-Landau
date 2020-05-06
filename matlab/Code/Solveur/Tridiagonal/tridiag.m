function [M] = tridiag(coeffs,n)
%TRIDIAG Retourne la matrice tridiagonale de coeffs c_k et de taille n
% coeffs : [c2, c1, c3]
%
% c2 c3
% c1 c2 c3
%    c1 c2

c1 = coeffs(1);
c2 = coeffs(2);
c3 = coeffs(3);

M = diag(c2*ones(1,n)) + diag(c3*ones(1,n-1),1) + diag(c1*ones(1,n-1),-1);

end

