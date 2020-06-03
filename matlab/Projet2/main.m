clear; clc; clf;

T = 15;
L = 4*pi;

taxis = [0 T];  nt = 500;
xaxis = [0 L];  nx = 30;
vaxis = [-5 5]; nv = 30;

ne = 100;  % Nombre de points pour le calcul du champs

np = nx*nv; % Nombre de particules

alpha = 10^(-3);
k = 0.5;

g1 = @(X) 1+alpha*cos(k*X);
g2 = @(V) 1/(sqrt(2*pi)) * exp((-V.^2)./2); %.* power(V,2); % Retirer le dernier membre pour l'amortissement Landau
f0 = @(X,V) g2(V).*g1(X);

%%%%%%%%%%%%%%%%%%%
% INITIALLISATION %
%%%%%%%%%%%%%%%%%%%

t = linspace(taxis(1),taxis(2),nt);  ht=t(2)-t(1);
x = linspace(xaxis(1),xaxis(2),nx+1);  hx=x(2)-x(1);
x = x(1:nx); % Petite technique our ne pas avoir de doublons d'électrons sur les bords
v = linspace(vaxis(1),vaxis(2),nv); hv=v(2)-v(1);

[XX,VV] = meshgrid(linspace(xaxis(1),xaxis(2),40),linspace(vaxis(1),vaxis(2),40));


x_E = linspace(xaxis(1),xaxis(2),ne); hE = x_E(2)-x_E(1);

energie_elec = zeros(1,nt); % Pour stocker ||E(t)||

[X,V] = meshgrid(x,v);             % GRID pour le calcul de la densite de particules reconstruite

X = X(:); % Matrice -> Vecteur
V = V(:);

omega1  = calculPoids(x,g1);
omega2  = calculPoids(v,g2);
[O1,O2] = meshgrid(omega1,omega2);
omega   = O1.*O2;
omega   = omega(:); % Matrice -> Vecteur

omegalong = [omega;omega;omega]; % Version de omega compatible avec la periodicite
rho = rho3(x_E,[X-L;X;X+L],omegalong,hx);
phi = tridiagsolver([1 -2 1],(1-rho)/(hE^-2));
E = calcul_champ(phi,hE);
energie_elec(1)=norm(E);


tic;

FF = f_reconstruite(X,V,XX,VV,omegalong,L);

maxini = 0;

for step=2:nt %% L'etape 1 est la condition initiale
    
    rho = rho3(x_E,[X-L;X;X+L],omegalong,hx);
    
    phi = tridiagsolver([1 -2 1],(1-rho)/(hE^-2));
    
    E = calcul_champ(phi,hE);
    energie_elec(step)=norm(E);
    
    EX = interp1(x_E,E,X,'spline');   % Valeur du champ a� l'emplacement des particules
    
    V = V - ht*EX;
    X = mod(X + V*ht,L);
    
    
    if mod(step,50)==0
        FF = f_reconstruite(X,V,XX,VV,omegalong,L);
    end
    
    if mod(step,3)==0 % Remapping a ajouter
        
        hFig = figure(1);
        width=1280;
        height=600;
        set(gcf,'position',[0,0,width,height]);
        tiledlayout(2,2)
        
        % Figure 2 : Champ electrique
        nexttile
        plot(x_E,E)
        xlim(xaxis);
        m = max(abs(E));
        if m>maxini
           maxini = m; 
        end
        ylim([-maxini,maxini]);
        title("Champ electrique");
        xlabel("x");
        ylabel("E");
        
        nexttile
        plot(t(1:step),energie_elec(1:step));
        xlim(taxis);
        ylim([0,max(energie_elec)*1.05]);
        title("Energie electrique au cours du temps");
        xlabel("t");
        ylabel("|E|");
        
        nexttile
        sc = scatter(X,V,'filled');
        xlim(xaxis);
        ylim(vaxis*1.2);
        title("Parametres des particules");
        xlabel("x");
        ylabel("v");
      
        
        nexttile
        su = surf(XX,VV,FF);
        su.EdgeColor = 'none';
        title("Densit� de particules reconstruite");
        xlabel("x");
        ylabel("v");
        xlim(xaxis);
        ylim(vaxis);
        view(2);
    end

    % Affichage de l'etape en cours
    if mod(step,nt/20)==2 || step==nt, fprintf('Etape: %d/%d - %5.1f%% termine\n', step, nt,step*100.0/nt), end
end
    
    
    
    
toc;
