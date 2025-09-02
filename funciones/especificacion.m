% Esta función realiza la especificación de la imagen "y" usando el
% cdf de la imagen "x". La función asume que las imágenes vienen en
% cualquier formato, pero convierte a doble.
% Se hace una normalización de las imágenes y posteriormente se hace el
% ajuste de los valores de "y". Cómo paso de la especificación, la función
% realiza primero la ecualización de la imagen "y".
%
% [y_sp]=especificacion(x,y,Nbins)
%
% x: imagen a usar como marco
% y: imagen a especificar
% Nbins: número de niveles de gris a ser usados
%
% Las imágenes son escaladas en el rango 0,1 y posteriormente se convierte
% a enteros para facilitar la asignación de la función de densidad
% acumulada.
%
% erik [dot] bojorges [at] ibero [dot] mx
% 2025/08/31
%


function [y_sp]=especificacion(x,y,Nbins)

if nargin<3
    Nbins = 256;
end

x = double(x);
y = double(y);


L=max([x(:);y(:)]);

x = round(reshape(normalize(x(:),"range"),size(x))*(Nbins-1))+1;
y = round(reshape(normalize(y(:),"range"),size(y))*(Nbins-1))+1;

[NNx, XX_edges]=histcounts(x(:),Nbins,...
                        "BinLimits",[1,Nbins],...
                        "Normalization","probability" );

[NNy, ~]=histcounts(y(:),Nbins,...
                        "BinLimits",[1,Nbins],...
                        "Normalization","probability" );

yeq = ecualizacion(y,Nbins);

cmfx=1-cumsum(NNx);

y_sp=round(cmfx(yeq) * (Nbins-1)) + 1  ;
[NNsp, ~]=histcounts(y_sp(:),Nbins,...
                        "BinLimits",[1,Nbins],...
                        "Normalization","probability" );

binCenters  = (XX_edges(1:end-1) + XX_edges(2:end))/2;

figure()
subplot(231)
imshow(x,[])
axis('equal')
title('X original')

subplot(232)
imshow(y,[])
axis('equal')
title('Y original')

subplot(233)
imshow(y_sp,[])
axis('equal')
title('especificada')

subplot(223)
plot(binCenters,NNx,'r', LineWidth=3)
hold on
plot(binCenters,NNy,'b',LineWidth=3)
plot(binCenters,NNsp,'C',LineWidth=3)
hold off
title('Histogramas')
legend('imagen X','imagen Y','especificación')

subplot(224)
plot(binCenters,cumsum(NNx),'r', LineWidth=3)
hold on
plot(binCenters,cumsum(NNy),'b',LineWidth=3)
plot(binCenters,cumsum(NNsp),'C',LineWidth=3)
hold off
title('CDF')
legend('imagen X','imagen Y','especificación')

