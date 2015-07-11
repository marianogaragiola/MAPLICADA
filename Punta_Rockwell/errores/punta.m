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

function [r, rmed ]= punta(L, R, R2, alpha, sigma )


% % parametros de la punta
% L = 0.4; % en mm
% R = 0.2; % en mm
% R2 = 0.01; % en mm
% alpha = pi/3 ; % en radianes
% sigma = 0.005; % en mm

phi = 0 ; % en radianes
theta = 0;
phi2 = 0;

% otros parametros que dependen de los anteriores
gamma = pi/2-alpha ;
xe = R*cos(alpha) ; % punto sobre el eje x donde se juntan el cono y la esfera
xc = xe + L*cos(gamma); % punto en el eje x donde empieza el cono
zc = L*sin(gamma) ; % punto sobre el eje z donde se juntan el cono y la esfera
zce = zc - R*sin(alpha) ; % z del centro de la esfera
xce = 0 ; % x del centro de la esfera
Dxc = R2*cos(alpha) ;
Dzc = R2*sin(alpha) ;

% armo una grilla equiespaciada
x = linspace(-xc, xc, 30);

% aca tengo las tres regiones 
I1 = (x <= -xe) ;
I2 = and(x >= -xe, x <= xe ) ;
I3 = (x >= xe) ;

I1med = (x <= -(xe+Dxc) ) ;
I2med = and(x >= -(xe+Dxc), x <= (xe+Dxc) ) ;
I3med = (x >= (xe+Dxc) ) ;
%%%%%%%%%%%%%%%%%%
s= linspace(-xc, xc, 30);
IS1 = (s <= -xe) ;
IS2 = and(s >= -xe, s <= xe ) ;
IS3 = (s >= xe) ;
rs=[(s(I1)*(1+tan(gamma))^(-1/2))  R*atanh((s(I2)-xce)/R) (s(I3)*(1+tan(gamma))^(-1/2))];%R*atanh((s(I2)-xce)/R) is the other way around
%%%%%%%%%%%%%%%%%%

% armo las dos curvas, z es la punta real y zmed es la de medicion
z = [tan(gamma)*(rs(I1)+xc) sqrt(R^2-(rs(I2)-xce).^2)+zce -tan(gamma)*(rs(I3)-xc)] ;

zmed = [tan(gamma)*(x(I1med)+xc+Dxc)+Dzc sqrt((R+R2)^2-(x(I2med)-xce).^2)+zce -tan(gamma)*(x(I3med)-xc-Dxc)+Dzc] ;

x = x(:);
z = z(:) ;
zmed = zmed(:);
rs = rs(:);

r = [ ] ;
rmed = [ ] ;

%for i = 1: 9

r = [r; cos(phi)*rs sin(phi)*rs z] ;
aux = [cos(phi)*x sin(phi)*x zmed]+sigma*randn(size(x,1), 3) ;
rmed = [rmed; aux ] ;

phi = phi + pi/9 ;

%end
plot3(r(:,1), r(:,2), r(:,3), '.');
% if and(theta ~= 0, phi2 ~= 0)
% 
% a = sin(theta)*cos(phi2);
% b = sin(theta)*sin(phi2);
% c = cos(theta);
% norma = sqrt( (1/a)^2 + (1/b)^2 ) ;
% norma2 = sqrt( (c/b)^2 + (c/a)^2 + (a/b+b/a)^2) ;
% 
% MR =  [1/(a*norma) c/(b*norma2) a; -1/(b*norma) c/(a*norma2) b; 0 -1/norma2*(a/b+b/a) c ];
% 
% aux2 = rmed.';
% 
% aux3 = MR*aux2;
% 
% rmed = aux3.';
% 
% end

% plot3(r(:,1), r(:,2), r(:,3), '.', rmed(:,1), rmed(:,2), rmed(:,3), '.')

% save('punta.dat', 'r', '-ascii');
% save('medicion.dat', 'rmed', '-ascii');

end
