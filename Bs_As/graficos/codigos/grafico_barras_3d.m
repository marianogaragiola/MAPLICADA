function h = grafico_barras_3d(estacion, dia_i, dia_f, z);
% Esta funcion hace un grafico de barras 3D
% Como entrada tiene el entero estacion que es un numero que nos dice
% que estacion vamos a graficar. Y z que es una matriz con los datos y
% mediciones.

% Estacion que vamos a usar.
estacion = estacion + 3;

% Vector horas que va de 1 hasta 24. Es para el eje.
horas = 1:1:24;
horas = horas(:);

num_dias = size(z(:,1),1)/24; % numero de dias totales medidos.
startdate = datenum('01-01-2012'); % dia inicial donde se empezo a medir
enddate = datenum('03-31-2015'); % dia final donde se termino de medir.
dias = linspace(startdate, enddate, num_dias); % vector con todos los dias donde se midieron.
%dias = dias(:);
%size(dias)

% z2 es una matriz que tiene en cada columna las mediciones de la estacion
% elegida a lo largo de cada dia. Es decir, tiene 24 filas y num_dias columnas
% El elemento (i,j) es la medicion del dia j en la hora i.
z2 = reshape(z(:,estacion), 24, length(z(:,estacion))/24);
%z2 = [dias; z2];
%size(z2(:,1),1)

dia_inicial = datenum(dia_i); % dia inicial donde va a empezar el grafico
dia_final = datenum(dia_f);   % dia final donde termina el grafico
num_puntos = dia_final-dia_inicial; % numero de puntos que va a tener el grafico.
xData = linspace(dia_inicial, dia_final, num_puntos); %vector para grafiar
xData2 = linspace(dia_inicial, dia_final, 3); % vector para poner las fechas en el eje.
% Para saber un poco mas leer el help find de matlab
in = find(~(dias-dia_inicial)); % me da el indice del vector donde tengo que empezar a graficar.
fi = find(~(dias-dia_final));   % me da el indice del vector donde tengo que terminar de graficar.

figure;
h = bar3(horas, z2(:,in:fi)); % aca hago el grafico
title('Concentracion por dias y horas - Centenario','fontsize', 15)
ylim([0 25]);
ylabel('hora','fontsize',15);
xlabel('dia','fontsize',15);
zlabel('concentracion CO [ppm]','fontsize',15);
set(gca, 'linewidth', 2, 'fontsize', 15);
set(gca,'ticklength', 2.5*get(gca,'ticklength'));
dateaxis('x', 2, dia_i);

end
