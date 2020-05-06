% Démo de l'interpolation B3Splines

clear; clf;

nx = 13;                            % Nombre de points d'interpolation
nr = 1000;                          % Nombre de points pour le rendu des fonctions

L = 2*pi;
xaxis = [0 L];
f = @(x) cos(x).*sin(2*x)+2;

figure(1); % Graphe de la fonction B3 (cubic spline)
x = linspace(-3,3);
y = B3(x);
plot(x,y);
title("Graphe de la fonction B3");

xi = linspace(xaxis(1), xaxis(2), nx); hx=xi(2)-xi(1); % Points d'interpolation
yi = f(xi);
omega = calculpoids(xi,f);

x = linspace(xaxis(1),xaxis(2),nr);
y = f(x);
yapprox = interpB3(xi,omega,x);

figure(2); hold on; % Graphe de la fonction f et son approximation
fig = zeros(1,2);
fig(1)=plot(x,y,'Color','#0072BD','LineWidth',3); % Bleu
fig(2)=plot(x,yapprox,'Color','#009432','LineWidth',2); % Vert
scatter(xi,yi);
xlim(xaxis);
title(["Graphe de la fonction f et de son approximation","Méthode des B3-Splines"]);

% Ajout des B3Splines qui composent l'approximation
for i=1:nx
    x = linspace(xi(i)-2*hx,xi(i)+2*hx);
    y = omega(i)/hx * B3( (x-xi(i))/hx );
    plot(x,y,'Color','r');
end

legend(fig,"y","yapprox");