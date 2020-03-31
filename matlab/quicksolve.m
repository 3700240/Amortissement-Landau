function [x] = quicksolve(n,b)
    x = zeros(length(b),1);
    
    % Calcul x1, x2
    s=0;
    for i=1:n
        s=s-(n+1-i)*b(i);
    end
    x(1)=1/(n+1)*s;
    x(2)=b(1)+2*x(1);
    
    % Calcul x2->xn
  
    for i=3:n
       x(i)=b(i-1)+2*x(i-1)-x(i-2);
    end
end

