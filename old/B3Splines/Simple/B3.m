function [out] = B3(y)
%B3Spline
%   Plus rapide que B3Spline2 sur les vecteurs y avec peu d'élements en
%   dehors de [-2,2]
y = abs(y);
out = ((y<1).*(4-6*y.^2+3*y.^3) + (y>=1).*(2-y).^3)/6;
out = max(out,0);
end
