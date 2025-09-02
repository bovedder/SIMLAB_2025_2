% Esta función realiza la ecualización del histograma, de una imagen en
% Nbins de niveles de gris. La función realiza primero una normalización en
% el rango 0,1 para posteriormente cambiarla a enteros. Se regresa una
% imagen descrita en niveles de gris es decir, la imagen de regreso tendra
% valores enteros entre 1 y Nbins.
%
% [y]=ecualizacion(x,Nbins)
% 
% x : imagen a ser ecualizada
% Nbins : número de niveles de gris, por omisión se asume 256.
% y : imagen ecualizada
%
% si no se solicitan argumentos de salida, la función pinta una figura
% descriptiva de los resultados.
%
% erik [dot] bojorges [at] ibero [dot] mx
% 2025/08/31


function [y]=ecualizacion(x,Nbins)

if nargin<2
    Nbins = 256;
end

x = double(x);

x = round(reshape(normalize(x(:),"range"),size(x))*(Nbins-1))+1;


[NN, XX_edges]=histcounts(x(:),Nbins,...
                        "BinLimits",[1,Nbins],...
                        "Normalization","probability" );

XbinCenters = (XX_edges(1:end-1) + XX_edges(2:end))/2;

cmf=cumsum(NN);

y = round(cmf(x) * (Nbins-1)) + 1  ;

[NN_eq,YY_edges]=histcounts(y(:),Nbins,...
                        'BinLimits',[min(y(:)),max(y(:))],...
                        'Normalization','probability');

YbinCenters = (YY_edges(1:end-1) + YY_edges(2:end))/2;

if nargout==0

    
    figure()
    subplot(221)
    imshow(x,[])
    axis('equal')
    title('original')

    subplot(222)
    imshow(y,[])
    axis('equal')
    title('ecualizada')

    subplot(223)
    bar(XbinCenters,NN)
    hold on 
    plot(XbinCenters,cmf,'r','LineWidth',3)
    hold off
    legend({'histograma';'cdf'})


    subplot(224)
    bar(YbinCenters,NN_eq)
    hold on 
    plot(XbinCenters,cumsum(NN_eq),'r','LineWidth',3)
    hold off
    legend({'histograma';'cdf'})
end

