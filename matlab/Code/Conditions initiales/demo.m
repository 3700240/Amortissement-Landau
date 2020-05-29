L = 4*pi; % x appartient à [0,L]

xaxis = [0 L];
vaxis = [-5 5]; % v appartient à [-5,5]

alpha = 10^(-3);
k = 0.5;

f0_amort   = @(X,V) 1/(sqrt(2*pi))            .*  exp((-V.^2)./2)  .*(1+alpha*cos(k*X));
f0_doublef = @(X,V) 1/(sqrt(2*pi)) *  (V.^2)  .*  exp((-V.^2)./2)  .*(1+alpha*cos(k*X));



xf = linspace(xaxis(1),xaxis(2),100);
vf = linspace(vaxis(1),vaxis(2),100);

[XF,VF] = meshgrid(xf,vf);

Z_amort = f0_amort(XF,VF);
Z_doublef = f0_doublef(XF,VF);


figure(1); clf; % densité de particules recontruite initiale
s1 = surf(XF,VF,Z_amort);
% title("Densité de particules initiale");
s1.EdgeColor = 'none';
xlim(xaxis);
view(2);


figure(2); clf; % densité de particules recontruite initiale
s2 = surf(XF,VF,Z_doublef);
% title("Densité de particules initiale");
s2.EdgeColor = 'none';
xlim(xaxis);
view(2);


