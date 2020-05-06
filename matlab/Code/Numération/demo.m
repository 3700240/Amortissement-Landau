% Demo de la numération des particules
% Objectif : obtenir une liste de particules placées uniformément sur une
% grille

clear; clf;

L=2*pi;
xaxis = [0,L];
vaxis = [-5,5];

nx = 10;
nv = 8;

x = linspace(xaxis(1),xaxis(2),nx);
v = linspace(vaxis(1),vaxis(2),nv);

[X,V] = meshgrid(x,v);

X = X(:);
V = V(:);

figure(1);
scatter(X,V);
xlim(xaxis);
ylim(yaxis);