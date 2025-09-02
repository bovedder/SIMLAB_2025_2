function [X_windowed] = ventaneo(X_norm,window_center, window_width, modo)

if nargin<2
    window_center = 0.5; % Default value for window_center
end

if nargin<3
    window_width = 0.1;  % Default value for window_width
end

if nargin<4
    modo = "bajo";    % Default value for modo
end

% Calculamos límites inferior y superior
low  = window_center - window_width/2;
high = window_center + window_width/2;


% Aplicamos el ajuste de intensidades (clipping)
X_windowed = X_norm;
X_windowed(X_norm < low)  = low;

if modo == "bajo"
    X_windowed(X_norm > high)  = low;
else
    X_windowed(X_norm > high) = high;
end

colormap(gray(256))
subplot(221)
imagesc(X_norm)
axis square
title('imagen original')

subplot(222)
imagesc(X_windowed)
axis square
title('imagen con ventana')

subplot(223)
histogram(X_norm(:), linspace(0,1,256))
ylim([0 1000])
title('Histograma Original')

subplot(224)
histogram(X_windowed(:), linspace(0,1,256))
ylim([0 1000])
title('Histograma Ventana')



end