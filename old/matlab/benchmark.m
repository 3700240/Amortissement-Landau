nmax=5000;

time_backslash = zeros(1,nmax-1);
time_quicksolve = zeros(1,nmax-1);

%{
for i=2:nmax
    tic
    A=tridiag(i);
    b=ones(i,1);
    x=A\b;
    t = toc;
    time_backslash(i-1)=t;
end
%}

for i=2:nmax
    i
    tic
    b=ones(i,1);
    x=quicksolve(i,b);
    t = toc;
    time_quicksolve(i-1)=t;
end
%{
figure(1)
plot(2:nmax,time_backslash,2:nmax,time_quicksolve)
xlim([30 nmax]);
%}

figure(2)
plot(2:nmax,time_quicksolve)
xlim([30 nmax]);