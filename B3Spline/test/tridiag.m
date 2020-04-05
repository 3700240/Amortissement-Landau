function [M] = tridiag(n)
%TRIDIAG Retourne la matrice triagonale de taille n avec pour diagonales
% 1/6, 4/6, 1/6
M = diag(4/6*ones(1,n)) + diag(1/6*ones(1,n-1),1) + diag(1/6*ones(1,n-1),-1);
end

