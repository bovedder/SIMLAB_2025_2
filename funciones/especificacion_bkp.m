

function [y_sp]=especificacion(x,y, Nbins)

%x=imread('eritrocitos.png');
%y=imread('aalcc.png');

N_tot=length(x(:));
x_L=max(x(:));
y_L=max(y(:));

L=max([x(:);y(:)]);
mymap=[linspace(0,1,L+1)'*ones(1,3)];

[NN,XX]=hist(x(:),0:L);

cmf=cumsum(NN)/N_tot;


y_sp=round(cmf(y+1)*L);
[NN_sp,XX_sp]=hist(y_sp(:),0:L);

figure()
colormap(mymap)
subplot(221)
image(y)
axis('equal')
title('original')

subplot(222)
image(y_sp)
axis('equal')
title('ecualizada')

subplot(223)
plot(XX,NN)

subplot(224)
plot(XX_sp,NN_sp)

