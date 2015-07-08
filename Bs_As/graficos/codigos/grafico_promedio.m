function h = grafico_promedio(estacion, z);
  % Esta funcion hace el grafico de la concentracion promedio por dia en una dada estacion
  % en funcion del dia.
  % Como entrada tiene "estacion" que es la estacion en la que estamos interesado y z que es la matriz
  % con los datos.

estacion = estacion + 3;

num_dias = size(z(:,1),1)/24;
dias = 1:1:num_dias;
dias = dias(:);

% z2 es una matriz que tiene en cada columna las mediciones de la estacion
% elegida a lo largo de cada dia. Es decir, tiene 24 filas y num_dias columnas
% El elemento (i,j) es la medicion del dia j en la hora i.
z2 = reshape(z(:,estacion), 24, length(z(:,estacion))/24);

% z3 es un vector donde cada elemento es el promedio de cada columna de z2.
z3 = mean(z2);

% Ahora hago el grafico.
z3 = [dias, z3(:)];
figure;
h = plot(z3(:,1), z3(:,2), '.');
xlabel('dias', 'fontsize', 15);
ylabel('concentracion [ppm]', 'fontsize', 15);
set(gca,'ticklength', 2.5*get(gca,'ticklength'));
set(gca, 'linewidth', 2, 'fontsize', 15);

end