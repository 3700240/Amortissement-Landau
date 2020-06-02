function [FF] = f_reconstruite(X,V,XX,VV,omega,L)

nvv = size(XX,1);
nxx = size(VV,2);

FF = zeros(size(XX));

omegalong = [omega;omega;omega];

X = [X-L;X;X+L];
V = [V; V; V];

for i=1:nxx
    for j=1:nvv
        FF(j,i)= sum(  omegalong.*B3(XX(j,i)-X)  .* B3(VV(j,i)-V)  );
    end
end

end