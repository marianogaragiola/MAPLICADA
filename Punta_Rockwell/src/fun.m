% funcion que me da el vector de la distancia de cada punto medido a
% la parte que le corresponde de la superficie de parametros p, segun
% el vector de clasificaci�n I:

% esta funcion no usa pesos estadisticos sobre los puntos de la esfera y
% del cono.
function y = fun(X, p);

p = p(:)';

V0(1:3) = p(3:5);
v1 = [cos(p(2))*sin(p(1)), sin(p(2))*sin(p(1)), cos(p(1))];
V1 = repmat(v1, [size(X,1), 1]);

c = V0(1:3) + p(6)*v1(1:3)/sin(p(7));
C = repmat(c, [size(X,1), 1]);

II = ( -sin(p(7)) >= dot(X-C,V1,2)./sqrt(dot(X-C,X-C,2)) ) ;

X_esf = X(II,:);
X_cono = X(~II,:);

y_esf = distesf(X_esf, p);
y_cono = distcono(X_cono, p);

y = [y_esf; y_cono ] ;

end
