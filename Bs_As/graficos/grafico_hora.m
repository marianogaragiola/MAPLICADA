function h = grafico_hora(hora, estacion, z);

estacion = estacion + 3;
hora = hora + 1;

num_dias = size(z(:,1),1)/24; % numero de dias

z2 = [z(hora:24:size(z(:,1),1),2) z(hora:24:size(z(:,1),1),estacion)];
c = z2(:,2);

figure
%h = plot(z2(:,1), z2(:,2),'.');
h = scatter(z2(:,1), z2(:,2), 20, c, 'filled');
xlabel('dias', 'fontsize', 15);
ylabel('concentracion [ppm]', 'fontsize', 15);
set(gca,'ticklength', 2.5*get(gca,'ticklength'));
set(gca, 'linewidth', 2, 'fontsize', 15);

end
