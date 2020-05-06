function [x] = tridiagsolver(coeffs,b)
%TRIDIAGSOLVER Pour résoudre Ax=b (algo de Thomas modifié)
%   avec A une matrice tridiagonale à coefficients constants
% coeffs : [c1, c2, c3] tel que :
% A = 
% c2 c3
% c1 c2 c3
%    c1 c2

c1 = coeffs(1);
c2 = coeffs(2);
c3 = coeffs(3);

n = length(b);
x = zeros(n,1);
v = zeros(n-1,1);   

w = c2;
x(1) = b(1)/w;

for i=2:n
    v(i-1) = c3/w;
    w = c2 - c1*v(i-1);
    x(i) = ( b(i) - c1*x(i-1) )/w;
end

for i=n-1:-1:1
   x(i) = x(i) - v(i)*x(i+1);
end
