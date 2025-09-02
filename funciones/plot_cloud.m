function plot_cloud(file, pow, Ngrey)
if nargin<2
    pow = 1;
end
if nargin <3
    Ngrey = 128;
end

cmap = repmat(linspace(0,1,Ngrey),3,1)';
colormap(cmap);

X = double(imread(file));

if length(size(X)) == 3
    X = mean(X,3);
end

[M,N] = size(X);

% construccion de los ejes
ii = meshgrid(1:N);
jj = meshgrid(1:M)';

% Normalizacion de la imagen
X = (X-min(X(:)))/(max(X(:))-min(X(:)));

X = X.^pow;

scatter3(ii(:),jj(:),X(:),3*ones(M*N,1),X(:)*Ngrey)
view(0,-90);
xlabel('i')
ylabel('j')

