%------------------------------------------------------------------------------------------%
% Este codigo llama a distintas funciones que hace distintos graficos.                     %
% Lo que primero que hace es leer los datos del archivo. Hay que estar atento al           %
% directorio donde estan los datos.                                                        %
% Luego elegimos la estacion que queremos graficar, los dias inicial y final que           %
% vamos a graficar y la hora.                                                              %
% Los graficos que hace son:                                                               %
% 1) Grafico de barra 3D que esta la concentracion en funcion del dia y de la hora.        %
% 2) Grafico por hora, grafica la concentracion en funcion del dia a una determinada hora. %
% 3) Grafico del promedio, grafica el promedio de cada dia en funcion del dia.             %
% 4) Grafico minmax. grafica el minimo y maximo de cada dia en funcion del dia.            %
%------------------------------------------------------------------------------------------%

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

estacion = 3; % Elijo la estacion que queremos graficar.
% Aca elegimos los dias que vamos a graficar. El formato tiene que ser 'mm-dd-yyyy'
dia_i = '01-01-2012';
dia_f = '01-01-2015';

hora = 13; % Elijo la hora a la que quiero graficar

%%%% Aca hacemos un grafico de barras 3D

h = grafico_barras_3d(estacion, dia_i, dia_f, z);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Aca hago el grafico para una misma hora en funcion del dia.


% estacion = 3; % Elijo la estacion que queremos graficar.
%
h = grafico_hora(hora, dia_i, dia_f, estacion, z);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Aca hago un grafico en el que primero hago el promedio de la concentracion
%%%% por dia y luego grafico el promedio por dia vs el dia.

% estacion = 3; % Elijo la estacion que queremos graficar.

h = grafico_promedio(estacion, dia_i, dia_f, z);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Aca hago el grafico de la concentracion minima y maxima de cada dia
%%%% en funcion del dia.
% estacion = 3;
%%%% Elejimos los dias para hacer el grafico. Acordarse que el formato es 'mm-dd-yyyy'.


h = grafico_minmax(estacion, dia_i, dia_f, z);
