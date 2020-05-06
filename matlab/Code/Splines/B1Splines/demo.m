% Démo de l'interpolation B1Splines

clear; clf;

nx = 15;                            % Nombre de points d'interpolation
nr = 1000;                          % Nombre de points pour le rendu des fonctions

L = 2*pi;
xaxis = [0 L];
f = @(x) cos(x).*sin(2*x)+2;


figure(1); % Graphe de la fonction B1
x = linspace(-2,2,nr);
y = B1(x);
plot(x,y);
xlim([-2 2]);
title("Graphe de la fonction B1");


xi = linspace(xaxis(1),xaxis(2),nx); hx=xi(2)-xi(1);
yi = f(xi);

omega = hx*yi;

x = linspace(xaxis(1),xaxis(2),nr);
y = f(x);
yapprox = interpB1(xi,omega,x);

figure(2); hold on; % Graphe de la fonction f et son approximation
plot(x,y,'Color','#0072BD','LineWidth',2);
plot(x,yapprox,'Color','#009432','LineWidth',2);
scatter(xi,yi);
xlim(xaxis);
title(["Graphe de la fonction f et de son approximation","Méthode des B1-Splines"]);

% Ajout des B1Splines qui composent l'approximation

for i=1:nx
    x = linspace(xi(i)-hx,xi(i)+hx);
    y = omega(i)/hx * B1( (x-xi(i))/hx );
    plot(x,y,'Color','r');
end

