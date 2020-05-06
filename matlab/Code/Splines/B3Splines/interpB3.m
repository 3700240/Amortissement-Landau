function [y] = interpB3(xi,omega,x)
%INTERSPLINE Interpolation par des splines cubiques
%   Version 1D

h = xi(2)-xi(1);
y = zeros(1,length(x));

for i = 1:length(x)
    y(i) = sum(omega/h.*B3( (x(i)-xi) /h)  );
end

end