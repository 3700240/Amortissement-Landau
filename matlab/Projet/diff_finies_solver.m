function [phi] = diff_finies_solver(b)
    N = length(b); % Taille du vecteur b
    n = N-2;
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