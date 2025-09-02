function im_filter = im_butter_filter (or, r, M, N)

if nargin < 2
    r = 0.1;
end
if nargin < 3
    M = 100;
end
if nargin < 3 
    N = M;
end

n = linspace(0,2,N);
n(n>1) = -(n(n>1)-1);
n = sort(n);

m = linspace(0,2,M);
m(m>1) = -(m(m>1)-1);
m = sort(m);

[nn,mm] = meshgrid(n,m);

im_filter = 1./(1+((nn.^2 + mm.^2)/r).^or);