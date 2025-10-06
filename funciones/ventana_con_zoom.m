function region = ventana_con_zoom(I,window)

    if nargin < 2
        % Definir coordenadas del rectángulo a ampliar
        window = [ 80 100 40 40];
        %x0 = 80; y0 = 100; ancho = 40; alto = 40;
    end
    
    
    % Mostrar imagen principal
    figure;
    imshow(I, []);
    title('Imagen con región de zoom');
    hold on;
    
    
    % Dibujar el rectángulo sobre la imagen
    rectangle('Position',window, ...
              'EdgeColor','r','LineWidth',1.5);
    
    % Extraer la región seleccionada
    region = imcrop(I, window);
    
    % Crear ejes secundarios para mostrar el zoom
    axZoom = axes('Position',[0.6 0.55 0.3 0.3]); % [x y ancho alto] relativos
    imshow(region, []);
    title('Región ampliada');
    axis on;
    
    % Dibujar marco para distinguir el zoom
    set(axZoom,'Box','on','XColor','r','YColor','r','LineWidth',1.2);