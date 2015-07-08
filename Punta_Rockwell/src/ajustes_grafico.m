clear
close all

L = 0.4; % en mm
R = 0.2; % en mm
R2 = 0.25; % en mm
alpha = pi/3; % en radianes
%sigma = 0.35e-3; % es el equivalente a 0.35 micrometros
sigma = 0.0002;
NUM_PUNTOS = 320;
format long;
r_medio = [] ;
ang_medio = [] ;
theta_medio = [] ;

radio = [];
angulo = [];
theta = [];

for i = 1: 1

  [r, rsim] = punta3(L, R, R2, alpha, sigma, NUM_PUNTOS);

  [popt, d, dist, theta_umbral] = cuad_ort_punta(L, R, R2, alpha, sigma, rsim);

%theta_umbral

  radio = [radio; popt(6)];
  angulo = [angulo; popt(7)];
  theta = [theta; popt(1)];
end

r_medio = [ r_medio; R2 mean(radio) std(radio)] ;
ang_medio = [ ang_medio; R2 mean(angulo) std(angulo)] ;
theta_medio = [ theta_medio; R2 mean(theta) std(theta)] ;
% r_medio
% ang_medio
% theta_medio

% aca hago el ajuste con los datos medidos por clemar

filename='../entrada/Datos_XYZ_Punta_SN_5620-R2=025mm.TXT';

rmed = load(filename, '-ascii');
%rmed = rsim;

%figure
%plot3(r(:,1),r(:,2),r(:,3),'.',rsim(:,1),rsim(:,2),rsim(:,3)+min(rmed(:,3)),'.',rmed(:,1),rmed(:,2),rmed(:,3),'.')
%figure
%plot3(r(:,1),r(:,2),r(:,3),'.',rsim(:,1),rsim(:,2),rsim(:,3)-min(rsim(:,3)),'.',rmed(:,1),rmed(:,2),rmed(:,3),'.')%-min(rsim(:,3)) me parece que no hace falta,(min(rsim(:,3))=0)

%plot3(r(:,1),r(:,2),r(:,3),'.')

[popt, d, dist, theta_umbral] = cuad_ort_punta(L, R, R2, alpha, sigma, rmed);

%theta_umbral

theta_angulo_solido = acos(rmed(:,3)./sqrt(rmed(:,1).^2+rmed(:,2).^2+rmed(:,3).^2));
phi_angulo_solido = (1-sign(rmed(:,2)))/2*pi + acos(rmed(:,1)./sqrt(rmed(:,1).^2+rmed(:,2).^2));

%int = (rmed(:,2)>=0.);
%int = int(:);
%phi_angulo_solido(int) = acos(rmed(int,1)./sqrt(rmed(int,1).^2+rmed(int,2).^2));

%phi_angulo_solido(~int) = pi + acos(rmed(~int,1)./sqrt(rmed(~int,1).^2+rmed(~int,2).^2));

%phi_angulo_solido = phi_angulo_solido(:);

dist = [phi_angulo_solido theta_angulo_solido dist];

% desviacion estandar con los datos medidos
sigma_med = std(dist(:,6));
%sigma_med

save('-ascii', 'distancias.dat', 'dist');

% en lo que sigue aca abajo sirve para hacer un terrible grafico
% eligo tres regiones para los distintos colores
I1 = (abs(dist(:,6))<sigma_med); % esto va a ir con color azul
I2 = and(abs(dist(:,6))>sigma_med, abs(dist(:,6))<2*sigma_med); % con color verde
I3 = and(abs(dist(:,6))>2*sigma_med, abs(dist(:,6))<3*sigma_med); % con color amarillo
I4 = (abs(dist(:,6))>3*sigma_med);
% creo el vector c con los distintos colores
% c(I1,1) = 0; c(I1,2) = 0; c(I1,3) = 0.8; % [0 0 1] color azul
% c(I2,1) = 0; c(I2,2) = 0.7; c(I2,3) = 0; % [0 1 0] color verde
% c(I3,1) = 1; c(I3,2) = 0.75; c(I3,3) = 0; % [1 1 0] color amarillo
% c(I4,1) = 0.7; c(I4,2) = 0; c(I4,3) = 0; % [1 0 0] color rojo

% c(I1,1) = 55./255.; c(I1,2) = 126./255.; c(I1,3) = 184./255.; % [0 0 1] color azul
% c(I2,1) = 77./255.; c(I2,2) = 175./255.; c(I2,3) = 74./255.; % [0 1 0] color verde
% c(I3,1) = 152./255.; c(I3,2) = 78./255.; c(I3,3) = 163./255.; % [1 1 0] color amarillo
% c(I4,1) = 228./255.; c(I4,2) = 26./255.; c(I4,3) = 28./255.; % [1 0 0] color rojo

c(I1) = 1*sigma_med;
c(I2) = 2*sigma_med;
c(I3) = 3*sigma_med;
c(I4) = 4*sigma_med;

set (0, 'defaultaxesfontname', 'Arial')
set (0, 'defaulttextfontname', 'Arial')

figure; hold on;
set(get(gca,'ylabel'),'rotation',0) % esto es para rotar el label
set(gca, 'linewidth', 4, 'fontsize', 20); % grosor de la lineas de los ejes y el tamaño de la letra
set(gca,'ticklength', 2.5*get(gca,'ticklength')) %largo de los ticksmarks
graphics_toolkit gnuplot
xlim([min(dist(:,3)) max(dist(:,3))]);
xlabel('X','fontsize',20);
ylim([min(dist(:,3)) max(dist(:,3))]);
ylabel('Y','fontsize',20);
scatter(dist(:,3),dist(:,4),10,c,'filled'); colorbar('ytick', [0,sigma_med, 2*sigma_med, 3*sigma_med, 4*sigma_med],...
                                                        'yticklabel', {'0', '\sigma', '2\sigma', '3\sigma', '4\sigma'})
print -depsc distancia_XY.eps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Min = 0.;
Max = 4*sigma_med;
figure; hold on;
set(gca, 'linewidth', 4, 'fontsize', 20); % grosor de la lineas de los ejes y el tamaño de la letra
set(gca,'ticklength', 2.5*get(gca,'ticklength')) %largo de los ticksmarks
xlim([0 2]);
graphics_toolkit gnuplot
xlabel('\theta/\theta_u','fontsize',20);
ylabel('distancias','fontsize',20);
h = colorbar;
set(gca, 'clim', [Min, Max]);
scatter(dist(:,2)/theta_umbral,dist(:,6),10,c,'filled'); colorbar('ytick', [0,sigma_med, 2*sigma_med, 3*sigma_med, 4*sigma_med],...
                                                        'yticklabel', {'0', '\sigma', '2\sigma', '3\sigma', '4\sigma'})

print -depsc distancia_vs_theta.eps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure; hold on;
set(get(gca,'ylabel'),'rotation',0)
set(gca, 'linewidth', 4, 'fontsize', 20); % grosor de la lineas de los ejes y el tamaño de la letra
set(gca,'ticklength', 2.5*get(gca,'ticklength')) %largo de los ticksmarks
graphics_toolkit gnuplot
xlim([-0.2 2.2]);
xlabel('\phi/\pi','fontsize',20);
ylim([-0.05 2]);
ylabel('\theta/\theta_u','fontsize',20);
scatter(dist(:,1)/pi,dist(:,2)/theta_umbral,10,c,'filled');  colorbar('ytick', [0,sigma_med, 2*sigma_med, 3*sigma_med, 4*sigma_med],...
                                                        'yticklabel', {'0', '\sigma', '2\sigma', '3\sigma', '4\sigma'});
print -depsc distancia_vs_theta_phi.eps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure; hold on;
set(get(gca,'ylabel'),'rotation',0)
set(gca, 'linewidth', 4, 'fontsize', 20); % grosor de la lineas de los ejes y el tamaño de la letra
set(gca,'ticklength', 2.5*get(gca,'ticklength')) %largo de los ticksmarks
graphics_toolkit gnuplot
xlabel('\phi/\pi','fontsize',20);
xlim([-0.2 2.2]);
ylabel('\theta/\theta_u','fontsize',20);
ylim([-0.05 2]);
scatter(dist(:,1)/pi,dist(:,2)/theta_umbral,10,dist(:,6),'filled'); colorbar;
print -depsc distancia_vs_theta_phi2.eps


r_medido = [popt(6) std(radio)] ;
angulo_medido = [popt(7) std(angulo)] ;
theta_medido = [popt(1) std(angulo)] ;

%mean(dist)
%figure
%plot(dist(:),'.')
