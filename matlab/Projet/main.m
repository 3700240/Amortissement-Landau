clear;

%%%%%%%%%%%%%%
% PARAMETRES f(XF,VF,X,V,omega,hx,hv)%
%%%%%%%%%%%%%%

DISPLAY = false; % Affiche la densité de particules recontruite à chaque étape
% ATTENTION! très gourmand en temps de calcul !

% /!\ Parametres des axes /!\ %

T = 50; % t appartient à [O,T]
L = 4*pi; % x appartient à [0,L]

taxis = [0 T];
xaxis = [0 L];
vaxis = [-5 5]; % v appartient à [-5,5]

nt = 500; % Nombre de points pour la discretisation du temps
nx = 50; % Nombre de points pour la discretisation de x
nv = 50; % Nombre de points pour la discretisation de v
np = nx*nv; % Nombre de particules

% Parametres du double faisceau
alpha = 10^(-3);
k = 0.2;
f0 = @(X,V) 1/(sqrt(2*pi)) *  exp((-V.^2)./2)  .*(1+alpha*cos(k*X));

%%%%%%%%%%%%%%%%%%%
% INITIALLISATION %
%%%%%%%%%%%%%%%%%%%

t = linspace(0,T,nt); ht=t(2)-t(1);
x = linspace(0,L,nx);  hx=x(2)-x(1);
v = linspace(-5,5,nv); hv=v(2)-v(1);

energie_elec = zeros(1,nt); % Pour stocker ||E(t)||

xf = linspace(xaxis(1),xaxis(2),100);
vf = linspace(vaxis(1),vaxis(2),100);
[XF,VF] = meshgrid(xf,vf);             % GRID pour le calcul de la densité de particules reconstruite


%%%%%%%%%%%%%%%%%%%%%%
% CORPS DU PROGRAMME %
%%%%%%%%%%%%%%%%%%%%%%

X = zeros(1,np); % Liste des positions des électrons, numération à un indice
V = zeros(1,np); % Liste des vitesses des électrons, numération à un indice

% Init des electrons surs.EdgeColor = 'none'; une grille (formée par les deux linspace x et v)
for cx=1:nx    
    for cv=1:nv
        X((cx-1)*nv+cv)=x(cx);
        V((cx-1)*nv+cv)=v(cv);
    end
end

omega = hx*hv*f0(X,V); % Calcul des poids pour une B1-Spline
rho   = rho1(x,X,omega,hx); % Calcul de rho0 (densité de particule)
phi   = diff_finies_solver((1-rho)/(hx^-2)); % calcul de Phi0
E     = calcul_champ(phi,hx); % Calcul des Ei0
energie_elec(1)=norm(E); % Energie electrique à t=0


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1); clf; % densité de particules recontruite initiale
FREC = f(XF,VF,X,V,omega,hx,hv);
s1 = surf(XF,VF,FREC);
title("Densité de particules recontruite initiale");
s1.EdgeColor = 'none';
xlim(xaxis);
view(2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for step=2:nt
    step
    % Résolution de Poisson pour obtention du Champ
    phi = diff_finies_solver((1-rho)/(hx^-2));
    E = calcul_champ(phi,hx); % Champ sur les points de
    % l'intervalle discrétisé x
    energie_elec(step)=norm(E);
    % Résolution des équations du mouvement pour calcul de Xn+1, Vn+1

    V = V - interpolation_champ(x,E,X)*ht;
    X = mod(X + V*ht,L);
    
    rho = rho1(x,X,omega,hx);
    
    if DISPLAY
        figure(4);
        FREC = f(XF,VF,X,V,omega,hx,hv);
        s = surf(XF,VF,FREC);
        title("Densite de particules reconstruite finale");     
        s.EdgeColor = 'none';
        xlim(xaxis);
        view(2);
    end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2); clf; % énergie électrique en fonction du temps
plot(t,energie_elec)
xlim([0 T]);
title("ENERGIE CINETIQUE EN FONCTION DU TEMPS")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3); clf; % Densité de particules reconstruite finale
s = surf(XF,VF,f(XF,VF,X,V,omega,hx,hv));
title("Densité de particules reconstruite finale");
s.EdgeColor = 'none';
xlim(xaxis);
view(2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


