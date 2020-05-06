clear; clf;

n = 5; % Nombre de points d'interpolation dans la démo
xaxis = [-pi,pi];
f = @(x) cos(x);


figure(1); % [GRAPHE] Fonction B3 (cubic spline)
x = linspace(-3,3);
y = B3(x);
plot(x,y);
title("Graphe de la fonction B3");

xi = linspace(xaxis(1), xaxis(2), n); h=xi(2)-xi(1); % Points d'interpolation
A = diag(4/6*ones(1,n)) + diag(1/6*ones(1,n-1),1) + diag(1/6*ones(1,n-1),-1);
% A(1,n) = 1/6;
% A(n,1) = 1/6;
b = h * f(xi)';
omega = (A\b)';


figure(2); % Demo de l'interpolation de f par des B3-Splines
x = linspace(xaxis(1), xaxis(2),2000);
y_exact  = f(x);
y_interp = interspline(xi,omega,x);
plot(x,y_exact);
hold on;
plot(x,y_interp);
title("Graphe de la fonction à interpoler");
xlim(xaxis);



