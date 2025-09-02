function [X] = gradiente_gris(N)

    if N < 8
        print("el valor mínimo es de 8")
        N = 8
    end


    X = 1:N;
    X = ones(N,1) * X;

    image(X);
    colormap(gray(N));
    axis square
end