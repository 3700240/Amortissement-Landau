function [M] = tridiag(n)
%TRIDIAG Retourne la matrice triagonale de taille n avec pour diagonales
% 1,2,1 (Fonction inutile depuis )
M = diag(-2*ones(1,n)) + diag(1*ones(1,n-1),1) + diag(1*ones(1,n-1),-1);
end
