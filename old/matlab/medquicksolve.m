function [phi] = medquicksolve(b)
    n = length(b); % Taille du vecteur b
    N = n + 2; % Taille du vecteur phi (+2 car conditions aux limites !)
    
    phi = zeros(N,1);
    phi(1) = 0;
    phi(N) = 0;
    
    for i=1:n
        s=0;
       for j=1:i
           s = s - 1/(n+1)*(n+1-i)*j*b(j);
       end
       for j=i+1:n
           s = s - 1/(n+1)*i*(n+1-j)*b(j);
       end
       phi(i+1)=s;
    end
    
end
