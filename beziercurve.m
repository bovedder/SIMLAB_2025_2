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