% Démo de l'intégrateur RK4

clear; clf;

L = 10;
xaxis = [0,L];
f = @(t,y,yprime) -yprime-y-cos(t);
yexact = @(t) 4*exp(-t/2).*sin(sqrt(3)*t/2)./sqrt(3)-sin(t);

t = linspace(0,L,1000);
yapprox = rk4_d2nd(t,0,1,f);
y = yexact(t);

figure(1); hold on; % Graphe de y et de son approximation
plot(t,y,'LineWidth',5,'Color','r');
plot(t,yapprox,'LineWidth',2,'Color','g');
legend("y(x)","yapprox");
xlim(xaxis);
title(["Graphe de y et de son approximation","Intégrateur RK4 avec dérivées secondes"]);

figure(2); % Graphe de l'erreur
plot(t,y-yapprox);

figure(3); % Erreur en fonction de n
% Calcul numérique de l'odre de la méthode
e = zeros(1,100);
for n=30:130
    t = linspace(0,L,n);
    yapprox = rk4_d2nd(t,0,1,f);
    y = yexact(t);
    e(n-29) = max(abs(y-yapprox));
end
plot(log(30:130),log(e));
p = polyfit(log(30:130),log(e),1);
title("Logarithme de l'erreur en fonction du logarithme de n");
xlabel("log(n)"); ylabel("log(e)");
xlim([log(30),log(130)]);