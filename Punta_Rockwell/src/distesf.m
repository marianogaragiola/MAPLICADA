% funcion que me da el vector de distancias de cada punto medido a
% la esfera de parametros p:

function y = distesf(X, p)

v0 = p(3:5);
v1 = [cos(p(2))*sin(p(1)) sin(p(2))*sin(p(1)) cos(p(1))] ; % eje del cono

c = v0(1:3) + v1(1:3)*(p(6)/sin(p(7))) ; % vector con las coordenadas del centro de la esfera
C = repmat(c, [size(X, 1), 1]); % esto hace una matriz de N filas, y en cada fila tiene el vector c

y = sqrt(dot(X-C, X-C, 2)) - p(6);

y = y(:) ;

end
