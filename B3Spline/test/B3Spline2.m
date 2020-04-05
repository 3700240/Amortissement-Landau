function [out] = B3Spline2(y)
    out = zeros(1,length(y));
    y = abs(y);
    for i=1:length(y)
        if y(i)<2
           if y(i)<1
               out(i)=(4-6*y(i)^2+3*y(i)^3);
           else
               out(i)=(2-y(i))^3;
           end
       end
    end
    out = max(out/6,0);
end

