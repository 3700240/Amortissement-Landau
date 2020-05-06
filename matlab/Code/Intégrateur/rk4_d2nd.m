function [y] = rk4_d2nd(t,y0,yprime0,f)
%RK4_D2ND Intégrateur RK4 avec dérivées secondes
%   pour le problème y''= f(t,y,y')
% t : temps discrétisé
% y0 : condition initiale
% yprime0 : condition initiale
% f : fonction telle que y''= f(t,y,y')

n = length(t);
y = zeros(1,n); y(1) = y0;
yprime = zeros(1,n); yprime(1) = yprime0;

for i=1:n-1
    
    % Calcul du pas de temps
    h = t(i+1)-t(i);
    
    % Calculs des coefficients
    k1 = f(t(i),y(i),yprime(i));
    k2 = f(t(i)+h/2,y(i)+h/2*yprime(i),yprime(i)+h/2*k1);
    k3 = f(t(i)+h/2,y(i)+h/2*yprime(i)+h^2/4*k1,yprime(i)+h/2*k2);
    k4 = f(t(i)+h,y(i)+h*yprime(i)+h^2/2*k2,yprime(i)+h*k3);
    
    % Calcul de y_n+1 et yprime_n+1
    y(i+1) = y(i) + h*yprime(i) + h^2/6*(k1+k2+k3);
    yprime(i+1) = yprime(i) + h/6*(k1+2*k2+2*k3+k4);
    
end

end

