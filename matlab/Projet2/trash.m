T = 10;
L = 4*pi;

taxis = [0 T];  nt = 500;
xaxis = [0 L];  nx = 50;
vaxis = [-5 5]; nv = 50;

alpha = 10^(-3);
k = 0.5;

g1 = @(X) 1+alpha*cos(k*X);
g2 = @(V) 1/(sqrt(2*pi)) *  exp((-V.^2)./2) ;%.* power(V,2); % Retirer le dernier membre pour l'amortissement Landau
f0 = @(X,V) g2(V).*g1(X);

x = linspace(xaxis(1),xaxis(2),100);
v = linspace(vaxis(1),vaxis(2),100);


[X,V] = meshgrid(x,v); 

Z = f0(X,V);


s = surf(X,V,Z);
s.EdgeColor = 'none';
xlim(xaxis);
view(2);