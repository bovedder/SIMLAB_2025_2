function [y]=mascareado(x,mascara)

if nargin<2
    mascara=0.9*ones(3);
end
    
[u,v]=size(mascara);
u=floor(u/2); 
v=floor(v/2);

[M,N]=size(x);

for i=u+1:N-u
    for j=v+1:M-v
        sub_mx=x(j-v:j+v,i-u:i+u);
        aux=sub_mx.*mascara;
        y(j-1,i-1)=sum(aux(:));
    end
end


