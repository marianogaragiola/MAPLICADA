% funcion que me da el vector de distancias de cada punto medido a
% el cono de parametros p:

function y = distcono( p, X)

%{
R2=0.25
R=p(6)
fi=p(7)
v0=[p(3) p(4) p(5)] % vertice del cono medido, el vertice real sería v0+v1(R2/sin(fi))
v1=[cos(p(2))*sin(p(1)) sin(p(2))*sin(p(1)) cos(p(1))] % eje del cono
V0(:,1)=v0(1)*ones(N,1) % ni idea si esta bien escrito esto, el resultado
V0(:,2)=v0(2)*ones(N,2) % de estas tres lineas debería ser una matriz
V0(:,3)=v0(3)*ones(N,3) % V0 donde cada fila sea el vector v0
V1(:,1)=v1(1)*ones(N,1)
V1(:,2)=v1(2)*ones(N,2)
V1(:,3)=v1(3)*ones(N,3)
%} 

v0 = p(3:5) ;
v1 = [cos(p(2))*sin(p(1)) sin(p(2))*sin(p(1)) cos(p(1))] ; % eje del cono

V0 = repmat(v0, size(X, 1), 1) ;
V1 = repmat(v1, size(X, 1), 1) ;

y = ( sqrt(dot(cross(X-V0,V1,2),cross(X-V0,V1,2),2)) )*cos(p(7)) - (dot(X-V0,V1,2))*sin(p(7)) ;

y = y(:) ;

end