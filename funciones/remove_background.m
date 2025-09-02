%X = double(imread('campo_1.jpg'));
X = double(imread('eritrocitos.png'));
%X = double(imread('IMG-20180616-WA0022.jpg'));
%X = double(imread('l_hires.jpg'));
X = mean(X,3);
 
cmap = linspace(0,1,256);
cmap = repmat(cmap,3,1)';

colormap(cmap)

[M,N] = size(X);

X_norm = reshape(normalize(X(:),'range'),M,N);

%i = 1:N;
%j = 1:M;

i = linspace(0,1,N);
j = linspace(0,1,M);

[ii,jj] = meshgrid(i,j);

% construccion de la matriz para estiamcion de coeficientes del polinomio
C = [ jj(:).^3, (jj(:).^2).*ii(:), (ii(:).^2).*jj(:), ii(:).^3, jj(:).^2, ii(:).*jj(:), ii(:).^2, jj(:), ii(:) , ones(M*N,1)];

% B son los coeficientes del polinomio de tercer orden estimados por
% pseudoinversa
B = inv(C'*C)*C' * X_norm(:);

background = reshape(normalize(C* B, 'range', [mean(X_norm(:)),mean(X_norm(:))+std(X_norm(:))]),M,N);

X_bck = 10.^(log10(X_norm+eps)-log10(background));
X_bck = reshape(normalize(X_bck(:),'range'),M,N);
X_bck = myhisteq(X_bck);
%X_bck = X_norm/background;

[ha,pos] = tight_subplot(1,3,0.01,0.1,0.1);

axes(ha(1))
imagesc(X_norm)
axis('equal')

axes(ha(2))
imagesc(background)
axis('equal')

axes(ha(3))
imagesc(X_bck)
axis('equal')
