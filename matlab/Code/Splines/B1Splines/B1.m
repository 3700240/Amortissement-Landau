function [y] = B1(x)
%B1 Fonction B1
%   Explications

x = abs(x);
y = (x<1).*(1-x);

end

