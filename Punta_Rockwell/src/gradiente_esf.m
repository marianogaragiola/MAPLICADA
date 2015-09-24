% gradiente_esf() es una funcion que evalua el gradiente anilitico de
% la distancia de un punto X = [Xi, Yi, Zi] a la superficie de
% una esfera.
%
% Devuelve un vector de 7 elementos con cada elemento correspondiente en el
% siguiente orde:
% d_theta, d_phi, d_vx, d_vy, d_vz, d_R, d_alpha.

function [grad_esf] = gradiente_esf(X, p);

Theta = p(1);
Phi = p(2);
vx = p(3);
vy = p(4);
vz = p(5);
R = p(6);
Alpha = p(7);

v1 = [cos(Phi)*sin(Theta), sin(Phi)*sin(Theta), cos(Theta)];
V0 = [vx, vy, vz];

c =  V0(1:3) + v1(1:3)*(R/sin(Alpha)) ;

largo = size(X,1);

C = repmat(c, [largo, 1]);
V1 = repmat(v1, [largo, 1]);

g_esf = zeros([largo, 7]);


g_esf(:,1) = ((2..*R.*csc(Alpha).*(X(:,3)-C(:,3)).*sin(Theta)-2.*R.*v1(3).*cos(Phi).*csc(Alpha).*(X(:,1)-C(:,1))-2.*R.*v1(3).*csc(Alpha).*sin(Phi).*(X(:,2)-C(:,2)))
              .*(-R+sqrt(dot(C-X,C-X,2))))./sqrt(dot(C-X,C-X,2));

g_esf(:,2) = ((2.*R.*csc(Alpha).*sin(Theta).*(X(:,1)-C(:,1)).*sin(Phi)-2.*R.*v1(1).*csc(Alpha).*(X(:,2)-C(:,2))).*(-R+sqrt(dot(X-C,X-C,2))))./sqrt(dot(X-C,X-C,2));

g_esf(:,3) = (-2.*(X(:,1)-C(:,1)).*(-R+sqrt(dot(X-C,X-C,2))))./sqrt(dot(X-C,X-C,2));

g_esf(:,4) = (-2.*(X(:,2)-C(:,2)).*(-R+sqrt(dot(X-C,X-C,2))))./sqrt(dot(X-C,X-C,2));

g_esf(:,5) = (-2.*(X(:,3)-C(:,3)).*(-R+sqrt(dot(X-C,X-C,2))))./sqrt(dot(X-C,X-C,2));

g_esf(:,6) = 2.*(-R + sqrt(dot(X-C,X-C,2))).*(-1+(-2.*dot(V1,X-C,2).*csc(Alpha))./(2.*sqrt(dot(X-C,X-C,2))));

g_esf(:,7) = 2.*R.*cot(Alpha).*csc(Alpha).*dot(V1,X-C,2).*(-R+sqrt(dot(X-C,X-C,2)))./sqrt(dot(X-C,X-C,2));

% Hacemos la suma sobre las filas
grad_esf = sum(g_esf);
grad_esf = grad_esf(:);

end
