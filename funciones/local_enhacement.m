
x=imread('dental_xray.jpg');
x=round(mean(x,3));

u=5;
v=5;

[M,N]=size(x);
aux=x;

for i=u+1:N-u
    for j=v+1:M-v
        sub_mx=aux(j-v:j+v,i-u:i+u);
        sub_mx=ecualizacion(sub_mx);
        aux(j,i)=sub_mx(v+1,u+1);
    end
end
    
u=1;
v=1;
[M,N]=size(xx);

aux_norm=double(xx)/double(max(xx(:)));
aux_median=zeros(M,N);
aux_mean=zeros(M,N);
aux_std=zeros(M,N);

for i=u+1:N-u
    for j=v+1:M-v
        sub_mx=aux_norm(j-v:j+v,i-u:i+u);
        %sub_mx=ecualizacion(sub_mx);
        aux_mean(j,i)=mean(sub_mx(:));
        aux_std(j,i)=var(sub_mx(:));
        aux_median(j,i)=median(sub_mx(:));
    end
end

aux_mean=round(aux_mean);
aux_std=round(aux_std);

media=mean(aux_norm(:));
desv=std(aux_norm(:));
k1=0.8;
k2=0.1;
k3=0.7;
E=4;
u=2;
v=2;

aux_enh=aux_norm;

for i=u+1:N-u
    for j=v+1:M-v
        sub_mx=aux_median(j-v:j+v,i-u:i+u);
        aux_media=mean(sub_mx(:));
        aux_std=std(sub_mx(:));
        if ((aux_media<k1*media) & (k2*desv<aux_std) & (aux_std<k3*desv))
            aux_enh(j,i)=sub_mx(v+1,u+1)*E;
        else
            aux_enh(j,i)=sub_mx(v+1,u+1);
        end
    end
end



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


x=imread('crane.tiff');
x_norm=double(x)/double(max(x(:)));

[M,N]=size(x_norm);

mask=[-1 -1 -1; -1 9 -1; -1 -1 -1];

u=1; 
v=1;

for i=u+1:N-u
    for j=v+1:M-v
        sub_mx=x_norm(j-v:j+v,i-u:i+u);
        aux=sub_mx.*mask;
        y(j-1,i-1)=abs(sum(aux(:)))+1*x_norm(j,i);
    end
end



for i=u+1:N-u
    for j=v+1:M-v
        sub_mx=aux_norm(j-v:j+v,i-u:i+u);
        %sub_mx=ecualizacion(sub_mx);
        aux_mean(j,i)=mean(sub_mx(:));
        aux_std(j,i)=var(sub_mx(:));
        aux_median(j,i)=median(sub_mx(:));
    end
end

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

mask1=[-1 -2 -1; 0 0 0; 1 2 1];

u=1; 
v=1;


for i=u+1:N-u
    for j=v+1:M-v
        sub_mx=x_norm(j-v:j+v,i-u:i+u);
        aux=sub_mx.*mask1;
        y1(j-1,i-1)=abs(sum(aux(:)))+1*x_norm(j,i);
    end
end

for i=u+1:N-u
    for j=v+1:M-v
        sub_mx=x_norm(j-v:j+v,i-u:i+u);
        aux=sub_mx.*mask1';
        y2(j-1,i-1)=abs(sum(aux(:)))+1*x_norm(j,i);
    end
end

a
