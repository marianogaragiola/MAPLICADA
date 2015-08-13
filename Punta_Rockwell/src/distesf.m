% funcion que me da el vector de distancias de cada punto medido a
% la esfera de parametros p:

function y = distesf( p, X)

% R2 = 0.25; % radio del esfera de medicion
% R = p(6);
% fi = p(7);
%{
v0 = [p(3) p(4) p(5)] ; % vertice del cono medido, el vertice real ser�a v0+v1(R2/sin(fi))
v1 = [cos(p(2))*sin(p(1)) sin(p(2))*sin(p(1)) cos(p(1))] ; % eje del cono
V0(:,1) = v0(1)*ones(N,1) ; % ni idea si esta bien escrito esto, el resultado
V0(:,2) = v0(2)*ones(N,2) ;% de estas tres lineas deber�a ser una matriz
V0(:,3) = v0(3)*ones(N,3) ; % V0 donde cada fila sea el vector v0
V1(:,1) = v1(1)*ones(N,1) ;
V1(:,2) = v1(2)*ones(N,2) ;
V1(:,3) = v1(3)*ones(N,3) ;
C=V0+V1*((R+R2)/sin(fi)) % matriz donde cada fila es el vector 'c', de las coordenadas del centro de la esfera
%}

v0 = p(3:5) ;
v1 = [cos(p(2))*sin(p(1)) sin(p(2))*sin(p(1)) cos(p(1))] ; % eje del cono

c = v0(1:3) + v1(1:3)*(p(6)/sin(p(7))) ; % vector con las coordenadas del centro de la esfera
C = repmat(c, size(X, 1), 1) ; % esto hace una matriz de N filas, y en cada fila tiene el vector c

% y = abs( sqrt(dot(X-C,X-C,2)) - p(6)) ;
y = sqrt(dot(X-C, X-C, 2)) - p(6);

y = y(:) ;

end
