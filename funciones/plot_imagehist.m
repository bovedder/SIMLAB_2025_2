function plot_imagehist(X1,X2,Nbins)

subplot(221)
imagesc(X1)
axis('equal')

subplot(223)
histogram(X1(:),Nbins)

subplot(222)
imagesc(X2)
axis('equal')

subplot(224)
histogram(X2(:),Nbins)
