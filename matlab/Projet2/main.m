clear; clc; clf;

T = 10;
L = 4*pi;

taxis = [0 T];  nt = 500;
xaxis = [0 L];  nx = 50;
vaxis = [-5 5]; nv = 50;

ne = 100;  % Nombre de points pour le calcul du champs

np = nx*nv; % Nombre de particules

alpha = 10^(-3);
k = 0.5;

g1 = @(X) 1+alpha*cos(k*X);
g2 = @(V) 1/(sqrt(2*pi)) *  exp((-V.^2)./2) ; %.* power(V,2); % Retirer le dernier membre pour l'amortissement Landau
f0 = @(X,V) g2(V).*g1(X);

%%%%%%%%%%%%%%%%%%%
% INITIALLISATION %
%%%%%%%%%%%%%%%%%%%

t = linspace(taxis(1),taxis(2),nt);  ht=t(2)-t(1);
x = linspace(xaxis(1),xaxis(2),nx+1);  hx=x(2)-x(1);
x = x(1:nx); % Petite technique our ne pas avoir de doublons d'électrons sur les bords
v = linspace(vaxis(1),vaxis(2),nv); hv=v(2)-v(1);


x_E = linspace(xaxis(1),xaxis(2),ne); hE = x_E(2)-x_E(1);

energie_elec = zeros(1,nt); % Pour stocker ||E(t)||

[X,V] = meshgrid(x,v);             % GRID pour le calcul de la densité de particules reconstruite

X = X(:); % Matrice -> Vecteur
V = V(:);

omega1  = calculPoids(x,g1);
omega2  = calculPoids(v,g2);
[O1,O2] = meshgrid(omega1,omega2);
omega   = O1.*O2;
omega   = omega(:); % Matrice -> Vecteur

omegalong = [omega;omega;omega]; % Version de omega compatible avec la périodicité

rho = rho3(x_E,[X-L;X;X+L],omegalong,hx);

phi = tridiagsolver([1 -2 1],(1-rho)/(hE^-2));
    
E = calcul_champ(phi,hE);

energie_elec(1)=norm(E);

% Zex  = f0(X,V);
% Zapp = interpB3_2D(X,V,omega,hx,hv,X,V);
% scatter3(X,V,abs(Zex-Zapp));

% Figure 2 : Champ electrique
figure(2);
plot(x_E,E)
xlim(xaxis);
title("Champ electrique");
xlabel("x");
ylabel("E");

pause(1)
%%%%%%%%%%%%%%%%%%%%%%
% CORPS DU PROGRAMME %
%%%%%%%%%%%%%%%%%%%%%%
tic;

for step=2:nt %% L'etape 1 est la condition initiale
    %X = mod(X+0.01,L); %V = V + (rand(size(V))-0.5)/100;
    
    rho = rho3(x_E,[X-L;X;X+L],omegalong,hx);
    
    phi = tridiagsolver([1 -2 1],(1-rho)/(hE^-2));
    
    E = calcul_champ(phi,hE);
    
    energie_elec(step)=norm(E);
    
    EX = interp1(x_E,E,X,'spline');   % Valeur du champ à l'emplacement des particules
    
    V = V - ht*EX;
    X = mod(X + V*ht,L);
    
    
    if mod(step,1000)==0 % Remapping a ajouter

        % Figure 1 : Positions et vitesses initiales des particules
        figure(1);
        scatter(X,V)
        xlim(xaxis);
        ylim(vaxis);
        title("Positions et vitesses initiales");
        xlabel("x");
        ylabel("v");
        
        % Figure 2 : Champ electrique
        figure(2);
        plot(x_E,E)
        xlim(xaxis);
        title("Champ electrique");
        xlabel("x");
        ylabel("E");
        
        figure(3); % Energie electrique au cours du temps
        plot(t,energie_elec);
        xlim(taxis);
        title("Energie electrique au cours du temps");
        xlabel("t");
        ylabel("E");

    end
    
    % Affichage de l'etape en cours
    if mod(step,nt/20)==2 || step==nt, fprintf('Etape: %d/%d - %5.1f%% termine\n', step, nt,step*100.0/nt), end
end


figure(3); % Energie electrique au cours du temps
plot(t,energie_elec);
title("Energie electrique au cours du temps");
xlim(taxis);
xlabel("t");
ylabel("E");

    
    
    
    
toc;
