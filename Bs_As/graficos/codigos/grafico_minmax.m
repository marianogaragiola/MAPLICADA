function h = grafico_minmax(estacion, dia_i, dia_f, z);
% Esta funcion hace el grafico de la concentracion minima y maxima por dia en una dada estacion
% en funcion del dia.
% Como entrada tiene "estacion" que es la estacion en la que estamos interesado y z que es la matriz
% con los datos. Tambien tiene como entrada el dia inicial y final en el que estamos interesados para
% hacer el grafico. Como observacion el formato de entrada tiene que ser 'mm-dd-yyyy' (mes-dia-año)
% por ejemplo dia_i = '01-01-2012'; y dia_f = '01-31-2012';
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTAS: Para hacer el grafico de la concentracion hay que hacer varias cosas:
% 1) dados los dias dia_i y final dia_f que defino los valores startdate y enddate que
% son los dias escritos en un codigo.
% 2) despues creo el vector xData que es un equiespaciado en las fechas. El numero de puntos
% en el equiespaciado tiene que ser igual al numero de dias que vamos a graficar porque al vector
% xData va estar en el 'x' del grafico.
% 3) Creo el vector xData2 que tiene el mismo rango que xData pero con menos puntos. La cantidad
% de puntos es la cantidad de ticks que va a tener el grafico.
% 4) Despues de lo anterioro hago el grafico y lo editamos con el titulo, labels y demas.
% 5) Para poner la fecha en nombre de los ticks, defino el vector labesl usando datestrs, para pasar
% del numero de serie al formato deseado (uso 20 que es dd/mm/yy).
% 6) Hago que los ticks esten en los puntos de xData2.
% 7) Cambio el formato para que aparezca la fecha.
%%%%%%%%%%%%%%%%%%%%%%%%%%%

estacion = estacion + 3; % elijo la estacion que queremos graficar.

num_dias = size(z(:,1),1)/24; % numero de dias totales medidos.
startdate = datenum('01-01-2012'); % dia inicial donde se empezo a medir
enddate = datenum('03-31-2015'); % dia final donde se termino de medir.
dias = linspace(startdate, enddate, num_dias); % vector con todos los dias donde se midieron.
dias = dias(:);

% z2 es una matriz que tiene en cada columna las mediciones de la estacion
% elegida a lo largo de cada dia. Es decir, tiene 24 filas y num_dias columnas
% El elemento (i,j) es la medicion del dia j en la hora i.
z2 = reshape(z(:,estacion), 24, length(z(:,estacion))/24);

% z3 es un vector donde cada elemento es el minimo de cada columna de z2.
z3 = min(z2);
% z4 es un vector donde cada elemento es el minimo de cada columna de z2.
z4 = max(z2);

% Ahora hago el grafico.
% z3 y z4 son matrices con 2 columnas. la primera tiene la lista de los dias y la
% segunda el valor minimo y maximo de la concentracion por dia respectivamente.
z3 = [dias, z3(:)];
z4 = [dias, z4(:)];

dia_inicial = datenum(dia_i); % dia inicial donde va a empezar el grafico
dia_final = datenum(dia_f);   % dia final donde termina el grafico
num_puntos = dia_final-dia_inicial; % numero de puntos que va a tener el grafico.
xData = linspace(dia_inicial, dia_final, num_puntos); %vector para grafiar
xData2 = linspace(dia_inicial, dia_final, 5); % vector para poner las fechas en el eje.

% Para saber un poco mas leer el help find de matlab
in = find(~(dias-dia_inicial)); % me da el indice del vector donde tengo que empezar a graficar.
fi = find(~(dias-dia_final));   % me da el indice del vector donde tengo que terminar de graficar.

figure;
h = plot(z3(in:fi,1), z3(in:fi,2), '.', z4(in:fi,1), z4(in:fi,2), '.' );
title('Concentracion mínima y máxima por dia - Centenario','fontsize', 15)
legend('mínimo diario', 'máximo diario')
xlim([z3(in,1) z3(fi,1)]);
xlabel('dias', 'fontsize', 15);
ylabel('concentracion [ppm]', 'fontsize', 15);
set(gca, 'linewidth', 2, 'fontsize', 15);
set(gca,'ticklength', 2.5*get(gca,'ticklength'));
% Aca pongo el formato correcto en los ticks para que aparezca la fecha.
labels = datestr(xData2, 'mm/yy');
set(gca, 'XTick', xData2);
set(gca, 'XTickLabel', labels);

end
