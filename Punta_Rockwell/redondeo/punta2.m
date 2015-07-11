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

function [r, rmed ]= punta2(L, R, R2, alpha, sigma )


% % parametros de la punta
% L = 0.4; % en mm
% R = 0.2; % en mm
% R2 = 0.01; % en mm
% alpha = pi/3 ; % en radianes
% sigma = 0.005; % en mm

phi = 0 ; % en radianes

% otros parametros que dependen de los anteriores
gamma = (pi/2)-alpha ;
xe = R*cos(alpha) ; % punto sobre el eje x donde se juntan el cono y la esfera
xc = xe + L*cos(gamma); % punto en el eje x donde empieza el cono
zc = L*sin(gamma) ; % punto sobre el eje z donde se juntan el cono y la esfera
zce = zc - R*sin(alpha) ; % z del centro de la esfera
xce = 0 ; % x del centro de la esfera
Dxc = R2*cos(alpha) ;
Dzc = R2*sin(alpha) ;

% armo una grilla equiespaciada
% x = linspace(-xc, xc, 30);

% aca tengo las tres regiones 
% I1 = (x <= -xe) ;
% I2 = and(x > -xe, x < xe ) ;
% I3 = (x >= xe) ;

% I1med = (x <= -(xe+Dxc) ) ;
% I2med = and(x >= -(xe+Dxc), x <= (xe+Dxc) ) ;
% I3med = (x >= (xe+Dxc) ) ;

%% valores de la longitud de arco de la curva en distintos puntos.
s1 = -(xe-xc)*sqrt(1+tan(gamma)^2); %union cono y esfera lado izquierdo
s2 = R*atan((xe+xce)/sqrt(R^2-(xe+xce)^2)); %punto mas alto de la esfera
s3 = R*atan((xe-xce)/sqrt(R^2-(xe-xce)^2)); %union de la esfera y el cono lado derecho
s4 = s1+s2+s3+(xc-xe)*sqrt(1+tan(gamma)^2); %ultimo punto de la curva

%% armo una grilla en la longitud de curva
s = linspace(0, s4, 100);

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

I1med = (x <= -(xe+Dxc) ) ;
I2med = and(x >= -(xe+Dxc), x <= (xe+Dxc) ) ;
I3med = (x >= (xe+Dxc) ) ;

% armo las dos curvas, z es la punta real y zmed es la de medicion
z = [tan(gamma)*(x(I1)+xc) sqrt(R^2-(x(I2)-xce).^2)+zce -tan(gamma)*(x(I3)-xc)] ;
zmed = [tan(gamma)*(x(I1med)+xc+Dxc)+Dzc sqrt((R+R2)^2-(x(I2med)-xce).^2)+zce -tan(gamma)*(x(I3med)-xc-Dxc)+Dzc] ;

s = s(:);
x = x(:);
z = z(:);
zmed = zmed(:);

r = [ ] ;
rmed = [ ] ;

for i = 1: 9

	r = [r; cos(phi)*x sin(phi)*x z] ;
	aux = [cos(phi)*x sin(phi)*x zmed]+sigma*randn(size(x,1), 3) ;
	rmed = [rmed; aux ] ;

	phi = phi + pi/9 ;

end



%plot3(r(:,1), r(:,2), r(:,3), '.', rmed(:,1), rmed(:,2), rmed(:,3), '.');
%save("-ascii","r.mat","r");
%save("-ascii","rmed.mat","rmed");
%plot(x(:),z(:), '.')

end
