
x=imread('ct2.07.png');
x_norm=double(x)/double(max(x(:)));

laplaciano=[-1 -1 -1; -1 9 -1; -1 -1 -1];
sobeles=[-1 -2 -1; 0 0 0; 1 2 1];
media=ones(5)./25;

aux1=mascareado(x_norm,laplaciano);
aux2=mascareado(x_norm,sobeles);
aux3=mascareado(x_norm,sobeles');
aux4=aux2+aux3;

