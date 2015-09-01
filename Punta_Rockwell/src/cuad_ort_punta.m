% La funcion cuad_ort_punta.m toma los valores medidos de una punta y
% calculo los parametros
%
% Como entrada le tengo que pasar:
% L ---> largo del cono (explicar mejor)
% R ---> radio de la esfera de la punta
% R2 ---> radio de la esfera de medicion
% alpha ---> mitad del angulo de abertura del cono
% sigma ---> desviaicon estandar de las mediciones (no se usa)
% X ---> mediciones (es una matriz con 3 columnas y los puntos xyz de las mediciones)
%
% Como salida tiene un vector con los parametros de la punta popt de la siguiente forma:
% popt(1) ---> �ngulo con el z del vector unitario del eje del cono (�ngulo theta)
% popt(2) ---> �ngulo azimutal del vector unitario del eje del cono (�ngulo phi)
% popt(3)\
% popt(4) ---> coordenadas cartecianas del vertice del cono en mm
% popt(5)/
% popt(6) ---> radio de la esfera de la punta
% popt(7) ---> �ngulo de abertura del cono
% Tambien como salida devuelve un vector con las distancias en el punto m�nimo


function [popt, residual, dist, theta_umbral, zce, popt_err] = cuad_ort_punta(L, R, R2, alpha, sigma, X)

% ****** inicio cuerpo del programa ******

M = max(X,[],1) ;  % deberia devolver un arreglo de 3 elementos, con el maximo de cada columna de X
Z2max=M(3) ; % si no anda, probar Z2max=max(X(:,3))
m = min(X,[],1) ; % me parece que no hace falta saber el m�nimo, no se usa en ningun lado despues
Z2min=m(3) ;
Z2umbral = Z2max - (R + R2)*(1 - sin(alpha)) ; % es el umbral entre cono y esfera. Conviene usar sin(alpha)=sqrt(3)/2 ?
theta_umbral = acos(Z2umbral/sqrt((R+R2)^2*cos(alpha)^2+Z2umbral^2));
N = size(X,1) ;  % devuelve la cantidad de filas, que deberia ser la cantidad de puntos, si X estaba bien definido

I = (X(:,3) >= Z2umbral) ;

p0(1) = pi ; % �ngulo con el eje z
p0(2) = 0 ; % �ngulo azimutal
p0(3) = mean(X(:,1)) ; % si no anda, probar mean(X)(1)
p0(4) = mean(X(:,2)) ;
p0(5) = Z2max - (R + R2) + (R + R2)/sin(alpha) ;% vertice del cono medido. Para vertice del cono 'real' usar Z2max-(R+R2)+R/sin(alpha)
p0(6) = R + R2 ;  % radio de la esfera medida. Para radio de la esfera 'real' usar R
p0(7) = pi/3 ;

NUM_MAX_IT = 30 ;% numero maximo de iteraciones
pasar = 0;
contador = 1;

while pasar == 0

  % [popt, resnorm, residual] = lsqnonlin(@(p) fun(p, X, I), p0) ;
  options = optimset('TolX',1e-18,'TolFun',1e-18,'MaxIter',2000,'Display','Final');
  %options
  %fminsearch se puede usar tambi�n.
  % [popt, residual] = fminunc(@(p) fun(p, X, I), p0,options) ;
  [popt, residual, EXITFLAG, OUTPUT, GRAD] = fminunc(@(p) fun(p, X, I), p0, options) ;

  HESSIAN = hessian(@(p) fun(p, X, I), popt);



  Cov = diag(inv(HESSIAN));
  save('-ascii', 'hesiano.dat', 'Cov')
  neg_cov = (Cov<0.0);
  % errores = sqrt(diag(inv(HESSIAN)));
  errores = sqrt(Cov);
  errores(neg_cov) = 0.;

  popt = popt(:)' ;

  v0 = popt(3:5) ;
  v1 = [cos(popt(2))*sin(popt(1)) sin(popt(2))*sin(popt(1)) cos(popt(1))] ; % eje del cono

  c = v0(1:3) + v1(1:3)*((R+R2)/sin(popt(7))) ; % vector con las coordenadas del centro de la esfera
  C = repmat(c, N, 1) ; % esto hace una matriz de N filas, y en cada fila tiene el vector c

  V1 = repmat(v1, N, 1); % idem C

  I1 = ( -sin(popt(7)) >= dot(X-C,V1,2)./sqrt(dot(X-C,X-C,2)) ) ;

  pasar = isequal(I,I1); % devuelve true si son iguales, false si son distintos
  I = I1;
  contador = contador + 1 ;

  if contador > NUM_MAX_IT
    disp('Número máximo de iteraciones alcanzado')
    return
  end

end %end while

dist = [distesf(popt, X(I,:)); distcono(popt, X(~I,:)) ];

dist = [X dist];


Z2umbral = Z2max - (popt(6))*(1 - sin(popt(7))) ; % es el umbral entre cono y esfera medida
zce = Z2umbral - popt(6)*sin(popt(7));
% sino poner popt(6)-R2 en todos lados
% theta_umbral mediddo desde el plano z = 0, a la esfera medida.
% theta_umbral = acos(Z2umbral/sqrt((popt(6))^2*cos(popt(7))^2+Z2umbral^2));

% theta_umbral medido desde el centro de la esfera
theta_umbral = acos(sin(popt(7)));

% delvolvemos los parametros en unidades de grados para los angulos y R.
popt(1) = abs(popt(1)-pi)*180/pi*60;
popt(6) = popt(6)-R2;
popt(7) = popt(7)*360/pi;
popt = popt(:);

%errores(1) = abs(errores(1)-pi)*180/pi*60;
errores(1) = errores(1)*180/pi*60;
errores(7) = errores(7)*360/pi;
errores(:) = errores(:);

popt_err = [popt, errores];

end
% ****** fin del cuerpo del programa ******
