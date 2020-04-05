function [out] = B3Spline3(y)
    y = abs(y);
    out = ((y<1).*(4-6*y.^2+3*y.^3) + (y>=1).*(2-y).^3)/6;
    out = max(out,0);
end

