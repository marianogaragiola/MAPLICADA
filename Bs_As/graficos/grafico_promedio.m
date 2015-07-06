function h = grafico_promedio(estacion, z);

estacion = estacion + 3;

num_dias = size(z(:,1),1)/24;
dias = 1:1:num_dias;
dias = dias(:);

z2 = [ ];
for i = 1:num_dias
  z2 = [z2, z((i-1)*24+1:i*24,estacion)];
end

z3 = mean(z2);

z3 = [dias, z3(:)];
figure;
h = plot(z3(:,1), z3(:,2), '.');
xlabel('dias', 'fontsize', 15);
ylabel('concentracion [ppm]', 'fontsize', 15);
set(gca,'ticklength', 2.5*get(gca,'ticklength'));
set(gca, 'linewidth', 2, 'fontsize', 15);

end
