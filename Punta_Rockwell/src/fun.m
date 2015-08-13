% funcion que me da el vector de la distancia de cada punto medido a
% la parte que le corresponde de la superficie de parametros p, segun
% el vector de clasificaci�n I:

% esta funcion no usa pesos estadisticos sobre los puntos de la esfera y
% del cono.
function y = fun( p, X, I)

y = [distesf(p, X(I,:)); distcono(p, X(~I,:)) ] ;
y = norm(y);

end
