function [y] = fapprox(x,omega,xi,h)
%FAPPROX Calcul de la valeur approchée de f
%   Version naive, effectue beaucoup de sommes inutiles
y = zeros(1,length(x));
for i = 1:length(x)
    y(i) = sum(omega/h.*B3Spline((x(i)-xi)/h));
end

end

