function [out] = phi1(x,h)
%PHI1 Fonction Phi associée à la B1-Spline
% Retourne le vecteur Phi utilisé pour calculer rho1
out = B1Spline(x/h)/h;


