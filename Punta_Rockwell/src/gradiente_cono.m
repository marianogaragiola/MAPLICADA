% gradiente_cono() es una funcion que evalua el gradiente anilitico de
% la distancia de un punto X = [Xi, Yi, Zi] a la superficie de
% un cono.
%
% Devuelve un vector de 7 elementos con cada elemento correspondiente en el
% siguiente orde:
% d_theta, d_phi, d_vx, d_vy, d_vz, d_R, d_alpha.

function [grad_cono] = gradiente_cono(X, p);

Theta = p(1);
Phi = p(2);
vx = p(3);
vy = p(4);
vz = p(5);
R = p(6);
Alpha = p(7);

v1 = [cos(Phi)*sin(Theta), sin(Phi)*sin(Theta), cos(Theta)];
v0 = [vx, vy, vz];

largo = size(X,1);
V0 = repmat(v0, [largo, 1]);
V1 = repmat(v1, [largo, 1]);

g_cono = zeros([largo, 7]);

g_cono(:,1) = 2.*(-(sin(Alpha).*((-V0(:,1) + X(:,1)).*cos(Theta).*cos(Phi) - (-V0(:,3) + X(:,3)).*sin(Theta) + (-V0(:,2) + X(:,2)).*cos(Theta).*sin(Phi))) +
              (cos(Alpha).*(2.*((-V0(:,3) + X(:,3)).*cos(Theta).*cos(Phi) + (-V0(:,1) + X(:,1)).*sin(Theta)).*(-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)) +
               2.*(-((-V0(:,2) + X(:,2)).*cos(Theta).*cos(Phi)) + (-V0(:,1) + X(:,1)).*cos(Theta).*sin(Phi)).*(-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)) +
               2.*(-((-V0(:,2) + X(:,2)).*sin(Theta)) - (-V0(:,3) + X(:,3)).*cos(Theta).*sin(Phi)).*((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi))))./
              (2..*sqrt((-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)).^2 +
              (-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)).^2 + ((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi)).^2))).*...
              (-(sin(Alpha).*((-V0(:,3) + X(:,3)).*cos(Theta) + (-V0(:,1) + X(:,1)).*cos(Phi).*sin(Theta) + (-V0(:,2) + X(:,2)).*sin(Theta).*sin(Phi))) +
              cos(Alpha).*sqrt((-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)).^2 +
              (-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)).^2 + ((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi)).^2));

g_cono(:,2) = 2.*(-(sin(Alpha).*((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta) - (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi))) +
           (cos(Alpha).*(-2.*(-V0(:,3) + X(:,3)).*sin(Theta).*(-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)).*sin(Phi) +
           2.*(-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)).*((-V0(:,1) + X(:,1)).*cos(Phi).*sin(Theta) + (-V0(:,2) + X(:,2)).*sin(Theta).*sin(Phi)) -
           2.*(-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta).*((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi))))./
           (2..*sqrt((-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)).^2 +
           (-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)).^2 + ((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi)).^2))).*...
           (-(sin(Alpha).*((-V0(:,3) + X(:,3)).*cos(Theta) + (-V0(:,1) + X(:,1)).*cos(Phi).*sin(Theta) + (-V0(:,2) + X(:,2)).*sin(Theta).*sin(Phi))) +
           cos(Alpha).*sqrt((-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)).^2 +
           (-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)).^2 + ((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi)).^2));

g_cono(:,3) = 2.*(cos(Phi).*sin(Alpha).*sin(Theta) + (cos(Alpha).*(2.*cos(Theta).*(-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)) -
            2.*sin(Theta).*sin(Phi).*(-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi))))./
           (2..*sqrt((-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)).^2 +
           (-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)).^2 + ((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi)).^2))).*...
           (-(sin(Alpha).*((-V0(:,3) + X(:,3)).*cos(Theta) + (-V0(:,1) + X(:,1)).*cos(Phi).*sin(Theta) + (-V0(:,2) + X(:,2)).*sin(Theta).*sin(Phi))) +
            cos(Alpha).*sqrt((-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)).^2 +
           (-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)).^2 + ((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi)).^2));

g_cono(:,4) = 2.*(sin(Alpha).*sin(Theta).*sin(Phi) + (cos(Alpha).*(2.*cos(Phi).*sin(Theta).*(-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)) -
            2.*cos(Theta).*((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi))))./
           (2..*sqrt((-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)).^2 +
           (-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)).^2 + ((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi)).^2))).*...
           (-(sin(Alpha).*((-V0(:,3) + X(:,3)).*cos(Theta) + (-V0(:,1) + X(:,1)).*cos(Phi).*sin(Theta) + (-V0(:,2) + X(:,2)).*sin(Theta).*sin(Phi))) +
            cos(Alpha).*sqrt((-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)).^2 +
           (-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)).^2 + ((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi)).^2));

g_cono(:,5) = 2.*(cos(Theta).*sin(Alpha) + (cos(Alpha).*(-2.*cos(Phi).*sin(Theta).*(-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)) +
            2.*sin(Theta).*sin(Phi).*((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi))))./
           (2..*sqrt((-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)).^2 +
           (-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)).^2 + ((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi)).^2))).*...
           (-(sin(Alpha).*((-V0(:,3) + X(:,3)).*cos(Theta) + (-V0(:,1) + X(:,1)).*cos(Phi).*sin(Theta) + (-V0(:,2) + X(:,2)).*sin(Theta).*sin(Phi))) +
            cos(Alpha).*sqrt((-((-V0(:,1) + X(:,1)).*cos(Theta)) + (-V0(:,3) + X(:,3)).*cos(Phi).*sin(Theta)).^2 +
           (-((-V0(:,2) + X(:,2)).*cos(Phi).*sin(Theta)) + (-V0(:,1) + X(:,1)).*sin(Theta).*sin(Phi)).^2 + ((-V0(:,2) + X(:,2)).*cos(Theta) - (-V0(:,3) + X(:,3)).*sin(Theta).*sin(Phi)).^2));


%%% el g_cono(6) y g_cono(7) deberian estar bien.
g_cono(:,6) =0;

g_cono(:,7) = 2.*((sqrt(dot(cross(X-V0,V1,2),cross(X-V0,V1,2),2)) ).*cos(Alpha)-(dot(X-V0,V1,2)).*sin(Alpha)).*...
              (-(sqrt(dot(cross(X-V0,V1,2),cross(X-V0,V1,2),2))).*sin(Alpha)-(dot(X-V0,V1,2)).*cos(Alpha));


% Ahora hago la suma sobre las filas
grad_cono = sum(g_cono);
grad_cono = grad_cono(:);

end
