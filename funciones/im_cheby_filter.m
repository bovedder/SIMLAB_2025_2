function im_filter = im_cheby_filter (or, r, Ep, M, N)

if nargin < 2
    r = 0.1;
end
if nargin < 3
    Ep=0.01;
end
if nargin < 4
    M = 100;
end
if nargin < 5 
    N = M;
end

n = linspace(0,2,N);
n(n>1) = -(n(n>1)-1);
n = sort(n);

m = linspace(0,2,M);
m(m>1) = -(m(m>1)-1);
m = sort(m);

[nn,mm] = meshgrid(n,m);

im_filter = 1./(1+(Ep.^2 * cheby(or,(sqrt(nn.^2 + mm.^2)/r).^2)));


function T = cheby(or,x)

if abs(x)<1
    T = cos(or*acos(x));
else
    T = cosh(or*acosh(x));
end