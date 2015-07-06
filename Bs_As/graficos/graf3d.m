clear all;
close all;

horas = 1:1:24;
horas = horas(:);

z = load('./Datos/datos_para_graficar.dat', '-ascii');

num_dias = size(z(:,1),1)/24; % numero de dias

%%%% Lo que sigue aca es para hacer un grafico de barras 3D
z2 = [];
for i = 1:num_dias
  z2 = [z2, z((i-1)*24+1:i*24,6)];
end

%hago el grafico de barras
dia_i = 1; % dia inicial a partir de donde mostrar
dia_f = 20;% dia final donde termina el grafico
dias = dia_i:dia_f;
bar3(horas,z2(:,dia_i:dia_f))
zlim([0 1]);
ylim([0 25]);
ylabel('hora','fontsize',15);
xlabel('dia','fontsize',15);
zlabel('concentracion CO [ppm]','fontsize',15);
set(gca, 'fontsize', 15 );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
