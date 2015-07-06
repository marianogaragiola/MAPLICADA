function h = grafico_barras_3d(estacion, z);

estacion = estacion + 3;

horas = 1:1:24;
horas = horas(:);

num_dias = size(z(:,1),1)/24; % numero de dias

z2 = [];
for i = 1:num_dias
  z2 = [z2, z((i-1)*24+1:i*24,estacion)];
end

%hago el grafico de barras
dia_i = 1; % dia inicial a partir de donde mostrar
dia_f = 100;% dia final donde termina el grafico
num_tick = 11; % numero de ticks
dias = linspace(0, dia_f, num_tick);
figure;
h = bar3(horas,z2(:,dia_i:dia_f));
zlim([0 1]);
ylim([0 25]);
ylabel('hora','fontsize',15);
xlabel('dia','fontsize',15);
set(gca, 'XTick', dias); %set(gca, 'XTick', [1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0])
zlabel('concentracion CO [ppm]','fontsize',15);
set(gca, 'fontsize', 15 );

end
