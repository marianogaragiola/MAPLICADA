function h = grafico_hora(hora, estacion, z);
% Esta funcion hace el grafico de la concentracion de una dada estacion
% en funcion del dia, para una dada hora.
% Como entrada tiene "hora" que es la hora en la que estamos interesados graficar.
% "estacion" que es la estacion en la que estamos interesado y z que es la matriz
% con los datos.

estacion = estacion + 3;
hora = hora + 1;

num_dias = size(z(:,1),1)/24; % numero de dias

% z2 es una matriz de dos columnas, donde la primera es el numero del dia y en
% la segunda tiene las mediciones.
z2 = [z(hora:24:size(z(:,1),1),2) z(hora:24:size(z(:,1),1),estacion)];
c = z2(:,2); % vector igual a la segunda columna de z2, es para ponerle colores al grafico.

% I es un vector logico (con 0 y 1) donde el elemento i vale 1 si z2(i)/=0 y cero si z(i)=0
% lo uso para graficar los puntos donde hay mediciones.
I = logical(z2(:,2));

% hago el grafico.
figure
h = plot(z2(I,1), z2(I,2),'.');
%h = scatter(z2(:,1), z2(:,2), 20, c, 'filled');
xlabel('dias', 'fontsize', 15);
ylabel('concentracion [ppm]', 'fontsize', 15);
set(gca,'ticklength', 2.5*get(gca,'ticklength'));
set(gca, 'linewidth', 2, 'fontsize', 15);

end
