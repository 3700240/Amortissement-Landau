function [phi] = quicksolve(b)
    n = length(b); % Taille du vecteur b
    N = n + 2; % Taille du vecteur phi (+2 car conditions aux limites !)
    phi = zeros(N,1);
    
    
    phi(1)=0;
    phi(N)=0;
    
    % Calcul phi(2)
    s=0;
    for i=1:length(b)
        s=s-(n+1-i)*b(i);
    end
    phi(2)=1/(n+1)*s;
    
    % Calcul phi(3)->phi(n+1)
    for i=3:length(b)
       phi(i)=b(i-1)+2*phi(i-1)-phi(i-2);
    end
end
