function Xequ = myhisteq(X,Nbins)

if nargin<2
    Nbins = 256;
end

%[M,N] = size(X);

[pdfx, ~] =  histcounts(X(:),Nbins);

cdf = cumsum(pdfx);

Xequ = cdf(round(X*(Nbins-1))+1);

end