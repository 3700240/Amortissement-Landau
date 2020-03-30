clear; clf;

steps = 1000;
L = 20;

h = @(x) sin(x); % E'

x = linspace(0,L,steps);

H = h(x(2:steps-1)');


delta = x(2)-x(1);
A = tridiag(steps-2);
phi = [0 ; delta^-2*A\H ; 0]'; % Solution du systeme lineaire + conditions aux limites

%y(0)=0 ; y(steps)=0; % Conditions aux limites


E = zeros(1,steps);
E(1) = (phi(2)-phi(1))/delta;
for i = 2:steps-1
    E(i) = (phi(i+1)-phi(i-1))/(2*delta);
end
E(steps) = -(phi(steps-1)-phi(steps))/delta;

figure(1)
sgtitle("Approximation de \phi par la résolution d'un système linéaire")
subplot(2,1,1);
plot(x,phi)
title('\phi(x)')
subplot(2,1,2);
plot(x,E)
title('E(x)')