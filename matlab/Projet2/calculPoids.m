function [omega] = calculPoids(xi,f)
%CALCULPOIDS Clacul des poids omega
%   Explication
h = xi(2)-xi(1);
n = length(xi);
A = tridiag(n);
b = 6*h*f(xi)';
omega = (A\b)';
end

function [M] = tridiag(n) % Devrait etre renommee presquetridiag desormais
%TRIDIAG Matrice tridiagonale de coef 1 4 1
%   Hello World
M = diag(4*ones(1,n)) + diag(ones(1,n-1),1) + diag(ones(1,n-1),-1);
M(1,n)=1;
M(n,1)=1;
end