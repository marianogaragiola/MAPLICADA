function h = grafico_hora(hora, dia_i, dia_f, estacion, z);
% Esta funcion hace el grafico de la concentracion de una dada estacion
% en funcion del dia, para una dada hora.
% Como entrada tiene "hora" que es la hora en la que estamos interesados graficar.
% "estacion" que es la estacion en la que estamos interesado y z que es la matriz
% con los datos. Tambien como parametro de entrada tiene el dia inicial (dia_i) y el dia final (dia_f)
% que queremos graficar. Hay que tener en cuenta que el formato de entrada es 'mm-dd-yyyy', por ejemplo:
% dia_i = '01-01-2012' y dia_f = '02-01-2012'.

estacion = estacion + 3;
hora = hora + 1;

num_dias = size(z(:,1),1)/24; % numero de dias totales medidos.
startdate = datenum('01-01-2012'); % dia inicial donde se empezo a medir
enddate = datenum('03-31-2015'); % dia final donde se termino de medir.
dias = linspace(startdate, enddate, num_dias); % vector con todos los dias donde se midieron.
dias = dias(:);

% z2 es una matriz de dos columnas, donde la primera es el numero del dia y en
% la segunda tiene las mediciones.
z2 = [z(hora:24:size(z(:,1),1),2) z(hora:24:size(z(:,1),1),estacion)];


dia_inicial = datenum(dia_i); % dia inicial donde va a empezar el grafico
dia_final = datenum(dia_f);   % dia final donde termina el grafico
% num_puntos = dia_final-dia_inicial; % numero de puntos que va a tener el grafico.
% xData = linspace(dia_inicial, dia_final, num_puntos); %vector para grafiar
% xData2 = linspace(dia_inicial, dia_final, 5); % vector para poner las fechas en el eje.
% Para saber un poco mas leer el help find de matlab
in = find(~(dias-dia_inicial)); % me da el indice del vector donde tengo que empezar a graficar.
fi = find(~(dias-dia_final));   % me da el indice del vector donde tengo que terminar de graficar.

% I es un vector logico (con 0 y 1) donde el elemento i vale 1 si z2(i)/=0 y cero si z(i)=0
% lo uso para graficar los puntos donde hay mediciones.
I = logical(z2(in:fi,2));

% hago el grafico.
figure
h = plot(z2(I,1), z2(I,2),'.');
title('Concentracion CO a la hora ... - ', 'fontsize', 15)
xlabel('dias', 'fontsize', 15);
ylabel('concentracion [ppm]', 'fontsize', 15);
set(gca,'ticklength', 2.5*get(gca,'ticklength'));
set(gca, 'linewidth', 2, 'fontsize', 15);
%labels = datestr(xData2, 'mm/yy');
%set(gca, 'XTick', xData2);
%set(gca, 'XTickLabel', labels);
dateaxis('x', 12, dia_i)

end
