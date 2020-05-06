function [output] = f(xgrid,vgrid,X,V,ome,hx,hv)
%F Summary of this function goes here
%   Detailed explanation goes here

output = zeros(size(xgrid));

for i =1:size(xgrid,1)
    for j=1:size(xgrid,2)
        output(i,j) = sum(ome .*  phi1(xgrid(i,j)-X,hx) .* phi1(vgrid(i,j)-V,hv));
    end
end

