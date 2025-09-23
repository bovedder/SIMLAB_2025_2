% Esta función realiza la corrección de fondo de la imagen "X" estimando
% la iluminación global mediante un polinomio de tercer orden o un ajuste
% alternativo mediante filtrado gaussiano, dependiendo del "modo" elegido.
%
% Se permite reducir la cantidad de datos a procesar usando el parámetro
% "paso". En el modo polinómico, controla el diezmado de la imagen; en el
% modo gaussiano, se interpreta como el tamaño del kernel y la varianza se
% fija automáticamente en paso/2.
%
% [X_bck, background] = background_adjst(X, modo, paso)
%
% X: imagen a corregir (puede ser cualquier tipo, se convierte a doble y se
%    normaliza al rango [0,1]).
% modo: define el tipo de estimación del fondo. Puede ser:
%       'poly'  → ajuste polinómico de tercer orden.
%       'gauss' → filtrado gaussiano como aproximación del fondo (default).
% paso: parámetro de control.
%       - En 'poly': factor de diezmado para reducir la carga computacional
%         (por defecto 10).
%       - En 'gauss': tamaño del kernel de suavizado; la varianza se fija
%         automáticamente en paso/2.
%
% X_bck: imagen corregida por fondo (normalizada en el rango [0,1]).
% background: estimación de la función de iluminación global.
%
% Procedimiento general:
% 1. Normaliza la imagen original al rango [0,1].
% 2. Si "modo" = 'poly':
%       - Diezma la imagen usando "paso" para disminuir la carga computacional.
%       - Construye la matriz de regresión polinómica de tercer orden para
%         estimar la iluminación mediante pseudoinversa.
%       - Estima la función de fondo en toda la imagen con los coeficientes
%         obtenidos.
%    Si "modo" = 'gauss':
%       - Aplica un filtrado gaussiano con tamaño de kernel = paso y
%         varianza = paso/2 sobre la imagen normalizada.
% 3. Corrige la imagen dividiendo la imagen normalizada por la función de
%    fondo estimada y vuelve a normalizar al rango [0,1].
%
% erik [dot] bojorges [at] ibero [dot] mx
% 2025/09/22



function [X_bck, background] = background_adjst(X, modo, paso)

if nargin<2
    modo = 'gauss';
end

if nargin<3
    paso = 10;
end



[M,N] = size(X);

X_norm = reshape(normalize(X(:),'range'),M,N);

if strcmpi(modo,'gauss')
    h = fspecial('gaussian', [paso paso], 0.5*paso);
    background = imfilter(X_norm, h, 'replicate');
else
    % Este código es para construir la función de fondo diezmando la imagen a
    % fin de disminuir el peso del procesamiento
    X_interp = X_norm(1:paso:end,1:paso:end);
    
    [M_interp , N_interp] = size(X_interp);
    
    j = linspace(0,1,M_interp);
    i = linspace(0,1,N_interp);
    
    [ii,jj] = meshgrid(i,j);
    
    % construccion de la matriz para estimacion de coeficientes del polinomio
    C = [ jj(:).^3, (jj(:).^2).*ii(:), (ii(:).^2).*jj(:), ii(:).^3, jj(:).^2, ii(:).*jj(:), ii(:).^2, jj(:), ii(:) , ones(M_interp*N_interp,1)];
    
    % B son los coeficientes del polinomio de tercer orden estimados por
    % pseudoinversa
    % lb = zeros(size(X_interp(:))); % límite inferior >= 0
    % B = lsqlin(C, X_interp(:), [], [], [], [], lb, []);
    B = (C'*C)\C' * X_interp(:);
    
    %
    % Ahora se estima la función de fondo usando la cantidad completa de
    % pixeles
    [M , N] = size(X_norm);
    
    j = linspace(0,1,M);
    i = linspace(0,1,N);
    
    [ii,jj] = meshgrid(i,j);
    
    % construccion de la matriz para estimacion de coeficientes del polinomio
    C = [ jj(:).^3, (jj(:).^2).*ii(:), (ii(:).^2).*jj(:), ii(:).^3, jj(:).^2, ii(:).*jj(:), ii(:).^2, jj(:), ii(:) , ones(M*N,1)];
    
    
    background = reshape(C*B,M,N);
end


%X_bck = 10.^(log10(X_norm+eps)-log10(background+eps));
%X_bck = reshape(normalize(X_bck(:),'range'),M,N);
X_bck = X_norm./(background+eps);
X_bck = reshape(normalize(X_bck(:),'range'),M,N);