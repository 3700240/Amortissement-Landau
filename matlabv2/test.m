xfine = linspace(xaxis(1),xaxis(2),200);
vfine = linspace(vaxis(1),vaxis(2),200);
[XFINE,VFINE] = meshgrid(xfine,vfine);


FREC2 = interp2(XF,VF,FREC,XFINE,VFINE,'cubic',0);


figure(1);
surf(XFINE,VFINE,FREC2);
view(2);
xlim(xaxis);