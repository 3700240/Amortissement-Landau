% Demo du solveur de systèmes linéaire Ax=b avec A une matrice tridiagonale
% à coefficients constants

clear;

n=10;

b = cos(1:n)';
tic;
x = tridiagsolver([1 -2 1],b); % Cas différences finies
toc;

A = tridiag([1 -2 1],n);
disp 'norme erreur:';
norm(A*x-b)