% Esta función construye una curva de Bézier cúbica a partir de 4 puntos
% de control y aplica dicha curva como función de transformación de
% intensidades a una imagen o vector de niveles de gris normalizados.
%
% [B, X_bezier] = beziercurve(ctrlPts, Xn)
%
% ctrlPts: matriz 4x2 que contiene los puntos de control de la curva
%          de Bézier, cada fila representa un punto [x y].
% Xn: imagen o vector de niveles de gris normalizados en el rango [0,1]
%
% B: puntos de la curva Bézier evaluados en 1000 pasos (1000x2)
% X_bezier: imagen o vector transformado usando la curva Bézier
%
% Procedimiento:
% 1. Se genera un vector de parámetros t en [0,1] con 1000 puntos.
% 2. Se extraen los puntos de control P0, P1, P2 y P3.
% 3. Se calculan las funciones de mezcla (Bézier blending functions) B0, B1, B2, B3.
% 4. Se evalúa la curva de Bézier en los 1000 pasos usando los puntos de control.
% 5. Se interpola la curva resultante sobre los valores de entrada Xn usando
%    interpolación lineal y extrapolación.
% 6. Se devuelve la imagen o vector transformado X_bezier con la misma
%    dimensión que Xn.
%
% Nota: Esta función puede usarse para transformar niveles de gris de una
%       imagen de forma no lineal y controlada por la curva de Bézier.
%
% erik [dot] bojorges [at] ibero [dot] mx
% 2025/09/14
%


function [B,X_bezier] = beziercurve(ctrlPts,Xn)

t = linspace(0,1,1000); % parameter
% Control points
P0 = ctrlPts(1,:);
P1 = ctrlPts(2,:);
P2 = ctrlPts(3,:);
P3 = ctrlPts(4,:);

% Bézier blending functions
B0 = (1-t).^3;
B1 = 3*(1-t).^2 .* t;
B2 = 3*(1-t) .* t.^2;
B3 = t.^3;

% Apply to control points (2D curve)
Bx = B0*P0(1) + B1*P1(1) + B2*P2(1) + B3*P3(1);
By = B0*P0(2) + B1*P1(2) + B2*P2(2) + B3*P3(2);

B = [Bx;By]';

% Apply LUT to normalized image
X_bezier = interp1(Bx, By, Xn(:), 'linear','extrap');
X_bezier = reshape(X_bezier,size(Xn));


end