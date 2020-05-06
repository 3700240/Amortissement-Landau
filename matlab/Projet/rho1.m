function [rho] = rho1(x,X,omega,h)
%RHOX Retourne la densité de charge au point x avec la B1Spline
%   x : position ou vecteurs de position des points où l'on souhaite
%   calculer la densité de charge
%   X : Position des électrons
%   omega : poids des électrons
%   h : pas de la discretisation

nx = length(x); % Taille du vecteur x en entrée
rho = zeros(nx,1);
for k = 1:nx
    rho(k)=sum(omega.*phi1(x(k)-X,h));
end

