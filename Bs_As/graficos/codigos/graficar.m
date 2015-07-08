clear all;
close all;

%%%% Leo los datos para hacer los graficos.
% Hay que tener cuidado con el directorio. Hay que poner el directorio
% donde se encuentra el archivo datos_para_graficar-3.dat.
z = load('../Datos/datos_para_graficar-3.dat', '-ascii');

%%%% Lo que sigue aca es para hacer un grafico de barras 3D
% la variables estacion indica que estacion vamos a graficar.
% estacion = 1 ---> indica estacion Centenario.
% estacion = 2 ---> indica estacion Cordoba.
% estacion = 3 ---> indica estacion La Boca.

estacion = 1; % Elijo la estacion que queremos graficar.

% h = grafico_barras_3d(estacion, z);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Aca hago el grafico para una misma hora en funcion del dia.

% hora = 23; % Elijo la hora a la que quiero graficar
% estacion = 3; % Elijo la estacion que queremos graficar.
%
% h = grafico_hora(hora, estacion, z);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Aca hago un grafico en el que primero hago el promedio de la concentracion
%%%% por dia y luego grafico el promedio por dia vs el dia.

% estacion = 3; % Elijo la estacion que queremos graficar.

% h = grafico_promedio(estacion, z);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Aca hago el grafico de la concentracion minima y maxima de cada dia
%%%% en funcion del dia.
% estacion = 3;
%%%% Elejimos los dias para hacer el grafico. Acordarse que el formato es 'mm-dd-yyyy'.
dia_i = '01-01-2012';
dia_f = '02-01-2012';

h = grafico_minmax(estacion, dia_i, dia_f, z);