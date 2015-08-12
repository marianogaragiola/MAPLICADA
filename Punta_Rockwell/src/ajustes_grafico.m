% clear
% close all

L = 0.4; % en mm
R = 0.2; % en mm
R2 = 0.25; % en mm
alpha = pi/3; % en radianes
sigma = 0.0002;
NUM_PUNTOS = 320;
format long;

%Acá leo los archivos que  estan en la carpeta entrada y después los paramétros por input
directory=dir("../entrada");
for i=1:size(directory,1)
	display([num2str(i) ") " directory(i).name]);
end
ans = input ("Seleccione archivo de entrada: ");
filename=["../entrada/" directory(ans).name];
L=input ("Ingrese L(en mm)[default 0.4]: ");
R=input ("Ingrese R(en mm)[default 0.2]: ");
R2=input ("Ingrese R2(en mm): ");

if isempty(L)
	L=0.4;
end
if isempty(R)
	R=0.2;
end

% Primero hacemos los ajustes con los datos de Clemar para calcular los parametros y la desviacion
% estandar que vamos a usar para simular las mediciones.
rmed = load(filename, '-ascii');

[popt, d, dist, theta_umbral, zce] = cuad_ort_punta(L, R, R2, alpha, sigma, rmed);

% desviacion estandar con los datos medidos
sigma_med = std(dist(:,4));
sigma = sigma_med;

% Esto que sigue son cosas para hacer los distintos graficos
theta_angulo_solido = acos((rmed(:,3)-zce)./sqrt(rmed(:,1).^2+rmed(:,2).^2+(rmed(:,3)-zce).^2));
phi_angulo_solido = (1-sign(rmed(:,2)))/2*pi + acos(rmed(:,1)./sqrt(rmed(:,1).^2+rmed(:,2).^2));

datos_graficar = [phi_angulo_solido theta_angulo_solido dist];

save('-ascii', '../salida/distancias_grafico.dat', 'datos_graficar');

% en lo que sigue aca abajo sirve para hacer un terrible grafico
% eligo tres regiones para los distintos colores
I1 = (abs(datos_graficar(:,6))<sigma_med); % esto va a ir con color azul
I2 = and(abs(datos_graficar(:,6))>sigma_med, abs(datos_graficar(:,6))<2*sigma_med); % con color verde
I3 = and(abs(datos_graficar(:,6))>2*sigma_med, abs(datos_graficar(:,6))<3*sigma_med); % con color amarillo
I4 = (abs(datos_graficar(:,6))>3*sigma_med);

% creo el vector c con los distintos colores
% c(I1) = 1*sigma_med;
% c(I2) = 2*sigma_med;
% c(I3) = 3*sigma_med;
% c(I4) = 4*sigma_med;
c(I1) = 0;
c(I2) = 1*sigma_med;
c(I3) = 2*sigma_med;
c(I4) = 3*sigma_med;
% c(I1,1:3) = repmat([0 0 1], [sum(I1) 1]);
% c(I2,1:3) = repmat([0 1 0], [sum(I2) 1]);
% c(I3,1:3) = repmat([1 1 0], [sum(I3) 1]);
% c(I4,1:3) = repmat([1 0 0], [sum(I4) 1]);


set (0, 'defaultaxesfontname', 'Arial')
set (0, 'defaulttextfontname', 'Arial')

f = figure('visible', 'off'); hold on;
set(get(gca,'ylabel'),'rotation',0) % esto es para rotar el label
set(gca, 'linewidth', 4, 'fontsize', 20); % grosor de la lineas de los ejes y el tamaño de la letra
set(gca,'ticklength', 2.5*get(gca,'ticklength')) %largo de los ticksmarks
graphics_toolkit gnuplot
xlim([min(datos_graficar(:,3)) max(datos_graficar(:,3))]);
xlabel('X','fontsize',20);
ylim([min(datos_graficar(:,3)) max(datos_graficar(:,3))]);
ylabel('Y','fontsize',20);
scatter(datos_graficar(:,3),datos_graficar(:,4),10,c,'filled'); colorbar('ytick', [0,sigma_med, 2*sigma_med, 3*sigma_med, 4*sigma_med],...
                                                        'yticklabel', {'0', '\sigma', '2\sigma', '3\sigma', '4\sigma'}, 'interpreter', 'tex')
print -depsc ../salida/distancia_XY.eps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Min = 0.;
Max = 4*sigma_med;
f = figure('visible', 'off'); hold on;
set(gca, 'linewidth', 4, 'fontsize', 20); % grosor de la lineas de los ejes y el tamaño de la letra
set(gca,'ticklength', 2.5*get(gca,'ticklength')) %largo de los ticksmarks
xlim([0 2]);
graphics_toolkit gnuplot
xlabel('\theta/\theta_u','fontsize',20);
ylabel('distancias','fontsize',20);
h = colorbar;
set(gca, 'clim', [Min, Max]);
scatter(datos_graficar(:,2)/theta_umbral,datos_graficar(:,6),10,c,'filled'); %colorbar('ytick', [0,sigma_med, 2*sigma_med, 3*sigma_med, 4*sigma_med],...
                                                        %'yticklabel', {'0', '\sigma', '2\sigma', '3\sigma', '4\sigma'}, 'interpreter', 'tex')

caxis([0 4.*sigma_med])
colormap(jet(4))
hcb = colorbar('ytick', [0, sigma_med, 2*sigma_med, 3*sigma_med, 4*sigma_med],...
               'yticklabel', {'0', '\sigma', '2\sigma', '3\sigma', '4\sigma'}, 'interpreter', 'tex');

%set(hcb,'YTickMode','manual');
print -depsc ../salida/distancia_vs_theta.eps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f = figure('visible', 'off'); hold on;
set(get(gca,'ylabel'),'rotation',0)
set(gca, 'linewidth', 4, 'fontsize', 20); % grosor de la lineas de los ejes y el tamaño de la letra
set(gca,'ticklength', 2.5*get(gca,'ticklength')) %largo de los ticksmarks
graphics_toolkit gnuplot
xlim([-0.2 2.2]);
xlabel('\phi/\pi','fontsize',20);
ylim([-0.05 2]);
ylabel('\theta/\theta_u','fontsize',20);
scatter(datos_graficar(:,1)/pi,datos_graficar(:,2)/theta_umbral,10,c,'filled');  colorbar('ytick', [0,sigma_med, 2*sigma_med, 3*sigma_med, 4*sigma_med],...
                                                        'yticklabel', {'0', '\sigma', '2\sigma', '3\sigma', '4\sigma'}, 'interpreter', 'tex');
print -depsc ../salida/distancia_vs_theta_phi.eps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f = figure('visible', 'off'); hold on;
set(get(gca,'ylabel'),'rotation',0)
set(gca, 'linewidth', 4, 'fontsize', 20); % grosor de la lineas de los ejes y el tamaño de la letra
set(gca,'ticklength', 2.5*get(gca,'ticklength')) %largo de los ticksmarks
graphics_toolkit gnuplot
xlabel('\phi/\pi','fontsize',20);
xlim([-0.2 2.2]);
ylabel('\theta/\theta_u','fontsize',20);
ylim([-0.05 2]);
scatter(datos_graficar(:,1)/pi,datos_graficar(:,2)/theta_umbral,10,datos_graficar(:,6),'filled'); colorbar;
print -depsc ../salida/distancia_vs_theta_phi2.eps
