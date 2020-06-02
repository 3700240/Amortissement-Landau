function [y] = interpB3_2D(xi,vi,omega,hx,hv,x,v)
%INTERSPLINE Interpolation par des splines cubiques
%   Version 1D

y = zeros(size(x));

for i = 1:length(x)
    y(i) = sum(omega/(hx*hv).*B3((x(i)-xi)/hx).*B3((v(i)-vi)/hv));
end

end