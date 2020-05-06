function [y] = interpB1(xi,omega,x)
%INTERPB1 Interpolation avec des B1Splines
%   Explication

n = length(x);
y = zeros(1,n);

h = xi(2)-xi(1);
for i=1:n
	y(i)=sum( omega/h .* B1( (x(i)-xi)/h ) );
end


end

