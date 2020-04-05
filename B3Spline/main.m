xi = [-1 -1/2 0 1/2 1];           
yi = [1.5 1 0 1 1/2];         
x = -1:0.01:1;

ylinear = interp1 (xi, yi, x);            % méthode linéaire utilisée par défaut
ycubic = interp1 (xi, yi, x, 'spline');

figure(1); clf;
plot(xi,yi,'o', x,ylinear,'-', x,ycubic,'--')
legend('Données', 'Interpolation linéaire', 'Interpolation cubique')