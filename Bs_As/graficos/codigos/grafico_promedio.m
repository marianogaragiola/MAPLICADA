function h = grafico_promedio(estacion, dia_i, dia_f, z);
% Esta funcion hace el grafico de la concentracion promedio por dia en una dada estacion
% en funcion del dia.
% Como entrada tiene "estacion" que es la estacion en la que estamos interesado y z que es la matriz
% con los datos. Tambien como parametro de entrada tiene el dia inicial (dia_i) y el dia final (dia_f)
% que queremos graficar. Hay que tener en cuenta que el formato de entrada es 'mm-dd-yyyy', por ejemplo:
% dia_i = '01-01-2012' y dia_f = '02-01-2012'.

estacion = estacion + 3;

num_dias = size(z(:,1),1)/24; % numero de dias totales medidos.
startdate = datenum('01-01-2012'); % dia inicial donde se empezo a medir
enddate = datenum('03-31-2015'); % dia final donde se termino de medir.
dias = linspace(startdate, enddate, num_dias); % vector con todos los dias donde se midieron.
dias = dias(:);

% z2 es una matriz que tiene en cada columna las mediciones de la estacion
% elegida a lo largo de cada dia. Es decir, tiene 24 filas y num_dias columnas
% El elemento (i,j) es la medicion del dia j en la hora i.
z2 = reshape(z(:,estacion), 24, length(z(:,estacion))/24);

z3 = [];
for i = 1:num_dias
  % I es un vector logico con ceros y unos. I(j)=1 si z2(j,i)/=0, I(j)=0 si z2(j,i)=0
  I = logical(z2(:,i));
  % Tomo el promedio de la concentracion por dia sin tener en cuenta los dias u horas en los que no
  % se midieron.
  z3 = [z3; mean(z2(I,i))];
end
z3 = [dias, z3(:)];

dia_inicial = datenum(dia_i); % dia inicial donde va a empezar el grafico
dia_final = datenum(dia_f);   % dia final donde termina el grafico
num_puntos = dia_final-dia_inicial; % numero de puntos que va a tener el grafico.
xData = linspace(dia_inicial, dia_final, num_puntos); %vector para grafiar
xData2 = linspace(dia_inicial, dia_final, 5); % vector para poner las fechas en el eje.
% Para saber un poco mas leer el help find de matlab
in = find(~(dias-dia_inicial)); % me da el indice del vector donde tengo que empezar a graficar.
fi = find(~(dias-dia_final));   % me da el indice del vector donde tengo que terminar de graficar.


% Ahora hago el grafico.
figure;
h = plot(z3(in:fi,1), z3(in:fi,2), '.');
title('Concentración promedio por día', 'fontsize', 15);
xlabel('dias', 'fontsize', 15);
xlim([z3(in,1) z3(fi,1)]);
ylabel('concentracion [ppm]', 'fontsize', 15);
set(gca,'ticklength', 2.5*get(gca,'ticklength'));
set(gca, 'linewidth', 2, 'fontsize', 15);
labels = datestr(xData2, 'mm/yy');
set(gca, 'XTick', xData2);
set(gca, 'XTickLabel', labels);

end
