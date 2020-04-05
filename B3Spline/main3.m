% rng(4);
% 
% xaxis = [-1000,1000];
% yaxis = [0 10];
% 
% x = rand(10,1)*10;
% y = rand(10,1)*10;
% 
% figure(1);
% scatter(x,y);
% xlim(xaxis);
% ylim(yaxis);

figure(2); clf;
t = linspace(-3,3,3000000);
xlim([-2 2]);
xlim([-2 2]);

tic
B1 = B1Spline(t);
toc
plot(t,B1);
hold on;

tic
B3 = B3Spline(t);
toc
plot(t,B3);
hold on;


tic
B33 = B3Spline3(t);
toc
plot(t,B33);