x = load('./Datos/datos.dat', '-ascii');

%Son las horas del dia. van desde 1 hasta 0
y1 = mod(x(:,1)-1, 24);

dias = size(y1(:),1)/24; %# de dias que hay en total


%Este vector indica el dia
%pone un numero distinto a cada dia.
for i = 1:dias
  y2((i-1)*24+1:i*24) = i;
end
y2 = y2(:);

z = [x(:,1) y2(:) y1(:) x(:,3) x(:,4) x(:,5)];

save('./Datos/datos_para_graficar-3.dat', '-ascii', 'z');

% hora = 13.0;
% y3 = [];
% y3 es una matriz en la cual se guarda la concentracion de CO de las
% 3 estaciones para la hora "hora" en funcion del dia. Las columnas son
% columna 1: dia
% columna 2: concentracion en Centenario
% columna 3: concentracion en Cordoba
% columna 4: concentracion en La Boca
% for i = 1:size(z(:,1))
%   if(z(i,3) == hora)
%     y3 = [y3; z(i,2) z(i,4) z(i,5) z(i,6)];
%   end
% end

%plot(y3(:,1), y3(:,4), '.');
%bar(y3(:,1), y3(:,4));
%title('Concentracion estacion La Boca, 13hs');
%xlabel('dias');
%ylabel('concentracion [ppm]');

%plot(z(1:24,3), z(1:24,4), '.');

% plot3(z(1:1000,2), z(1:1000,3), z(1:1000,6));
