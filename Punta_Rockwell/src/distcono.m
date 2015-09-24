% funcion que me da el vector de distancias de cada punto medido a
% el cono de parametros p:

function y = distcono(X, p)

v0 = p(3:5) ;
v1 = [cos(p(2))*sin(p(1)) sin(p(2))*sin(p(1)) cos(p(1))] ; % eje del cono

V0 = repmat(v0, size(X, 1), 1) ;
V1 = repmat(v1, size(X, 1), 1) ;

y = ( sqrt(dot(cross(X-V0,V1,2),cross(X-V0,V1,2),2)) )*cos(p(7)) - (dot(X-V0,V1,2))*sin(p(7)) ;

y = y(:) ;

end
