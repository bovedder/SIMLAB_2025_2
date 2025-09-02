
% Ecualizacion
mymap=[linspace(0,1,256)'*ones(1,3)];
colormap(mymap)
 
x=imread('eritrocitos.png');

N_tot=length(x(:));
[NN,XX]=hist(x(:),256);

cmf=cumsum(NN)/N_tot;

y=round(cmf(x+1)*256);

[NN_eq,XX_eq]=hist(y(:),256);

figure()
colormap(mymap)
subplot(221)
image(x)
axis('equal')
title('original')

subplot(222)
image(y)
axis('equal')
title('ecualizada')

subplot(223)
plot(XX,NN)

subplot(224)
plot(XX_eq,NN_eq)


% Especificacion

x=imread('eritrocitos.png');
y=imread('aalcc.png');
z=imread('angio2.pgm');

[y_sp]=especificacion(x,y);

[y_sp]=especificacion(y,z);

%N_tot=length(x(:));
%[NN,XX]=hist(x(:),256);

%cmf=cumsum(NN)/N_tot;

%y_sp=round(cmf(y+1)*256);
%[NN_sp,XX_sp]=hist(y_sp(:),256);

%figure()
%colormap(mymap)
%subplot(221)
%image(y)
%axis('equal')
%title('original')

%subplot(222)
%image(y_sp)
%axis('equal')
%title('ecualizada')

%subplot(223)
%plot(XX,NN)

%subplot(224)
%plot(XX_sp,NN_sp)

