a=0;
b=10;
N=20; %% Nombre de points d'interpolation

x = linspace(0,10,2000); % Pour afficher la fonction à interpoler
y = f(x);

xi = linspace(a,b,N); h = xi(2)-xi(1); % Points d'interpolation
yi = f(xi);


A = tridiag(N);
b = h * f(xi)';
omega = (A\b)'; % système à résoudre pour calculer les poids



figure(2); clf;
tic; yapprox = fapprox(x,omega,xi,h); toc;
plot(x,yapprox);
hold on;
scatter(xi,yi); 
plot(x,y);
title("B3-Spline fapprox");

figure(3); clf;
tic; fyapprox = ffapprox(x,omega,xi,h); toc;
plot(x,fyapprox);
hold on;
scatter(xi,yi);
plot(x,y);

for i=1:length(omega) % Pour afficher les B3-Splines
    xx = linspace(xi(i)-2,xi(i)+2);
    yyy = omega(i)/h*B3Spline((xx-xi(i))/h);
    plot(xx,yyy,'r');
end

title("B3-Spline ffapprox");


figure(4); clf;
tic; matlabapprox = interp1(xi,yi,x,'spline');
plot(x,matlabapprox);
hold on;
scatter(xi,yi);
plot(x,y);
title("B3-Spline Matlab");

figure(5)
xb = linspace(-3,3);
plot(xb,B3Spline(xb));
title("B3(y)");


