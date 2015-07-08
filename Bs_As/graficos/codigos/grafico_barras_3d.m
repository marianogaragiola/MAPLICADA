function h = grafico_barras_3d(estacion, z);
% Esta funcion hace un grafico de barras 3D
% Como entrada tiene el entero estacion que es un numero que nos dice
% que estacion vamos a graficar. Y z que es una matriz con los datos y
% mediciones.

% Estacion que vamos a usar.
estacion = estacion + 3;

% Vector horas que va de 1 hasta 24. Es para el eje.
horas = 1:1:24;
horas = horas(:);

num_dias = size(z(:,1),1)/24; % numero de dias

% z2 es una matriz que tiene en cada columna las mediciones de la estacion
% elegida a lo largo de cada dia. Es decir, tiene 24 filas y num_dias columnas
% El elemento (i,j) es la medicion del dia j en la hora i.
z2 = reshape(z(:,estacion), 24, length(z(:,estacion))/24);

%hago el grafico de barras
dia_i = 1; % dia inicial a partir de donde mostrar
dia_f = 100;% dia final donde termina el grafico
num_tick = 11; % numero de ticks
dias = linspace(0, dia_f, num_tick); % esto es para los ticksmarks del grafico
figure;
h = bar3(horas,z2(:,dia_i:dia_f)); % aca hago el grafico
zlim([0 1]);
ylim([0 25]);
ylabel('hora','fontsize',15);
xlabel('dia','fontsize',15);
title('Concentracion por dias y horas - Centenario','fontsize', 15)
set(gca, 'XTick', dias);
zlabel('concentracion CO [ppm]','fontsize',15);
set(gca, 'fontsize', 15 );

end
