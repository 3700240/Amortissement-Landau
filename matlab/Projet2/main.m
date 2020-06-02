clear; clc; clf;

T = 10;
L = 4*pi;

taxis = [0 T];  nt = 10000;
xaxis = [0 L];  nx = 20;
vaxis = [-5 5]; nv = 20;

np = nx*nv; % Nombre de particules

alpha = 10^(-3);
k = 0.5;

g1 = @(X) 1+alpha*cos(k*X);
g2 = @(V) 1/(sqrt(2*pi)) *  exp((-V.^2)./2);
f0 = @(X,V) g2(V).*g1(X);

%%%%%%%%%%%%%%%%%%%
% INITIALLISATION %
%%%%%%%%%%%%%%%%%%%

t = linspace(0,T,nt);  ht=t(2)-t(1);
x = linspace(0,L,nx+1);  hx=x(2)-x(1);
x = x(1:nx);
v = linspace(-5,5,nv); hv=v(2)-v(1);

energie_elec = zeros(1,nt); % Pour stocker ||E(t)||

[X,V] = meshgrid(x,v);             % GRID pour le calcul de la densité de particules reconstruite

X = X(:); % Matrice -> Vecteur
V = V(:);

omega1  = calculPoids(x,g1);
omega2  = calculPoids(v,g2);
[O1,O2] = meshgrid(omega1,omega2);
omega   = O1.*O2;
omega   = omega(:); % Matrice -> Vecteur

rho = rho3(x,X,omega,hx);
phi = tridiagsolver([1 -2 1],(1-rho)/(hx^-2)); 
E = calcul_champ(phi,hx);

energie_elec(1)=norm(E);

% figure(1);
% scatter(x, rho);
% 
% figure(2);
% scatter(x,phi);
% 
% figure(3);
% scatter(x,E);

% Zex  = f0(X,V);
% Zapp = interpB3_2D(X,V,omega,hx,hv,X,V);
% scatter3(X,V,abs(Zex-Zapp));

figure(1);
scatter(X,V)


pause(5)
%%%%%%%%%%%%%%%%%%%%%%
% CORPS DU PROGRAMME %
%%%%%%%%%%%%%%%%%%%%%%
tic;

for step=2:nt %% L'etape 1 est la condition initiale
    %X = mod(X+0.01,L); %V = V + (rand(size(V))-0.5)/100;
    
    EX = interp1(x,E,X,'spline');   % Valeur du champ à l'emplacement des particules
    
    V = V - ht*EX;
    X = mod(X + V*ht,L);
    
    rho = rho3(x,X,omega,hx);
    phi = tridiagsolver([1 -2 1],(1-rho)/(hx^-2)); 
    E = calcul_champ(phi,hx);
    energie_elec(step)=norm(E);
    
    
    if mod(step,nt/20)==0 % Remapping
        
        figure(1);
        scatter(X,V)
        
        figure(2);
        plot(x,rho);
%         
%         figure(3);
%         plot(x,phi);
%         
%         figure(4);
%         plot(x,E);

    end
    
    % Affichage de l'etape en cours
    if mod(step,nt/20)==2 || step==nt, fprintf('Etape: %d/%d - %5.1f%% termine\n', step, nt,step*100.0/nt), end
end


figure(5);
plot(1:length(energie_elec),energie_elec);


toc;
