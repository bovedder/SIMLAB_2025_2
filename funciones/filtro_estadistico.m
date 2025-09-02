function [y_mediana,y_media,y_std]=filtro_estadistico(x,ventana)



if nargin<2
    u=1;
    v=1;
elseif length(ventana<2)
    u=ventana;
    v=u;
else
    u=ventana(1);
    v=ventana(2);
end
    
   
x_norm=double(x)/double(max(x(:)));
[M,N]=size(x);


for i=u+1:N-u
    for j=v+1:M-v
        sub_mx=x_norm(j-v:j+v,i-u:i+u);
        y_media(j,i)=mean(sub_mx(:));
        y_std(j,i)=var(sub_mx(:));
        y_mediana(j,i)=median(sub_mx(:));
    end
end


