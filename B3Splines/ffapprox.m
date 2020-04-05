function [y] = ffapprox(x,omega,xi,h)
%FFAPPROX Calcul de la valeur approchée de f
%   Version presque optimisée

y = zeros(1,length(x));
l = length(xi);

for i = 1:length(x)
    xf = x(i)/h;
    start = ceil(xf)-1;  
    for offset=0:3
        k = start + offset;
        if k>=1 && k<=l
            y(i) = y(i) + omega(k)/h*B3Spline((x(i)-xi(k))/h);
        end
    end
end
end

