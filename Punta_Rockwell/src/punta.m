% La funcion punta es una funcion que devuelve la superficie de la punta con los
% parametros adecuados y ademas devuelve una nube de puntos que simulan mediciones
% para una dada desviacion estandar.
%
% Como parametros de entrada hay que ingresar:
% L ---> largo del cono (explicar mejor)
% R ---> radio de la esfera de la punta
% R2 ---> radio de la esfera de medicion
% alpha ---> mitad del angulo de abertura del cono
% sigma ---> desviacion estandar para mediciones
%
% Como salida tiene:
% r ---> matriz de 3 columnas con los puntos x,y,z de la punta
% rmed ---> matriz de 3 columnas con los puntos xyz de la nube, (mediciones simuladas)

function [r, rmed ]= punta(L, R, R2, alpha, sigma, NUM_PUNTOS )

phi = 0 ; % en radianes

% otros parametros que dependen de los anteriores
gamma = pi/2-alpha ;
xe = R*cos(alpha) ; % punto sobre el eje x donde se juntan el cono y la esfera
xc = xe + L*cos(gamma); % punto en el eje x donde empieza el cono
zc = L*sin(gamma) ; % punto sobre el eje z donde se juntan el cono y la esfera
zce = zc - R*sin(alpha) ; % z del centro de la esfera
xce = 0 ; % x del centro de la esfera

%% valores de la longitud de arco de la curva en distintos puntos.
s1 = -(xe-xc)*sqrt(1+tan(gamma)^2); %union cono y esfera lado izquierdo
s2 = R*atan((xe+xce)/sqrt(R^2-(xe+xce)^2)); %punto mas alto de la esfera
s3 = R*atan((xe-xce)/sqrt(R^2-(xe-xce)^2)); %union de la esfera y el cono lado derecho
s4 = s1+s2+s3+(xc-xe)*sqrt(1+tan(gamma)^2); %ultimo punto de la curva

%% armo una grilla en la longitud de curva
NUM_PUNTOS = floor(s4/0.01);%paso de una centésima de milímetro

s = linspace(0, s4, NUM_PUNTOS);

%% separo las regiones de interes
I1 = (s<=s1);
I2 = and( s>s1, s<s1+s2+s3);
I3 = (s1+s2+s3<=s);

%% calculo la grilla de tal forma que los puntos esten equiespaciados en la longitud de curva
x = [s(I1)/sqrt(1+tan(gamma)^2)-xc R*tan((s(I2)-s1-s2)/R)./sqrt(1+tan((s(I2)-s1-s2)/R).^2)+xce (s(I3)-s1-s2-s3)/sqrt(1+tan(gamma)^2)+xe];

%%% separo las regiones pero ahora en la coordenada
I1 = (x <= -xe) ;
I2 = and(x > -xe, x < xe ) ;
I3 = (x >= xe) ;

% armo las dos curvas, z es la punta real y zmed es la de medicion
z = [tan(gamma)*(x(I1)+xc) sqrt(R^2-(x(I2)-xce).^2)+zce -tan(gamma)*(x(I3)-xc)] ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xe = (R+R2)*cos(alpha) ; % punto sobre el eje x donde se juntan el cono y la esfera
xc = xe + L*cos(gamma); % punto en el eje x donde empieza el cono
zc = L*sin(gamma) ; % punto sobre el eje z donde se juntan el cono y la esfera
zce = zc - (R+R2)*sin(alpha) ; % z del centro de la esfera
xce = 0. ; % x del centro de la esfera

%% valores de la longitud de arco de la curva en distintos puntos.
s1 = -(xe-xc)*sqrt(1+tan(gamma)^2); %union cono y esfera lado izquierdo
s2 = (R+R2)*atan((xe+xce)/sqrt((R+R2)^2-(xe+xce)^2)); %punto mas alto de la esfera
s3 = (R+R2)*atan((xe-xce)/sqrt((R+R2)^2-(xe-xce)^2)); %union de la esfera y el cono lado derecho
s4 = s1+s2+s3+(xc-xe)*sqrt(1+tan(gamma)^2); %ultimo punto de la curva

%% armo una grilla en la longitud de curva
s = linspace(0, s4, NUM_PUNTOS);

%% separo las regiones de interes
I1 = (s<=s1);
I2 = and( s>s1, s<s1+s2+s3);
I3 = (s1+s2+s3<=s);

%% calculo la grilla de tal forma que los puntos esten equiespaciados en la longitud de curva
xmed = [s(I1)/sqrt(1+tan(gamma)^2)-xc (R+R2)*tan((s(I2)-s1-s2)/(R+R2))./sqrt(1+tan((s(I2)-s1-s2)/(R+R2)).^2)+xce (s(I3)-s1-s2-s3)/sqrt(1+tan(gamma)^2)+xe];

I1med = (xmed <= -xe) ;
I2med = and(xmed > -xe, xmed < xe ) ;
I3med = (xmed >= xe) ;

zmed = [tan(gamma)*(xmed(I1med)+xc) sqrt((R+R2)^2-(xmed(I2med)-xce).^2)+zce -tan(gamma)*(xmed(I3med)-xc)] ;

s = s(:);
x = x(:);
xmed = xmed(:);
z = z(:);
zmed = zmed(:);

r = [ ] ;
rmed = [ ] ;

for i = 1: 9

	r = [r; cos(phi)*x sin(phi)*x z] ;
	aux = [cos(phi)*xmed sin(phi)*xmed zmed]+sigma*randn(size(x,1), 3) ;
	rmed = [rmed; aux ] ;

	phi = phi + pi/9 ;

end

end
