function [rho] = rho3(x,X,omega,hx)
%RHOX Retourne la densité de charge au point x avec la B3Spline
%   x : position ou vecteurs de position des points où l'on souhaite
%   calculer la densité de charge
%   X : Position des électrons
%   omega : poids des électrons
%   h : pas de la discretisation
p = phi3(x-X,hx);
rho = sum(omega.*p);
end

function [out] = phi3(x,hx)
%PHI1 Fonction Phi associée à la B3-Spline
% Retourne le vecteur Phi utilisé pour calculer rho3
out = B3(x/hx)/hx;
end
