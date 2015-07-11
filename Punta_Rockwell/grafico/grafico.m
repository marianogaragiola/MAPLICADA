close all
clear all

dist = load('distancias.dat', '-ascii');

sigma_med = 0.0002;

I1 = (abs(dist(:,6))<sigma_med); % esto va a ir con color azul
I2 = and(abs(dist(:,6))>sigma_med, abs(dist(:,6))<2*sigma_med); % con color verde
I3 = and(abs(dist(:,6))>2*sigma_med, abs(dist(:,6))<3*sigma_med); % con color amarillo
I4 = (abs(dist(:,6))>3*sigma_med);
% creo el vector c con los distintos colores
% c(I1,1) = 0; c(I1,2) = 1; c(I1,3) = 1; % [0 0 1] color cyan
% c(I2,1) = 0; c(I2,2) = 1; c(I2,3) = 0; % [0 1 0] color verde
% c(I3,1) = 0.93; c(I3,2) = 0.33; c(I3,3) = 0; % [1 1 0] color amarillo
% c(I4,1) = 1; c(I4,2) = 0; c(I4,3) = 1; % [1 0 0] color magenta

% c(I1,1) = 0.38; c(I1,2) = 0.51; c(I1,3) = 0.71; % [0 0 1] color azul
% c(I2,1) = 0; c(I2,2) = 0.66; c(I2,3) = 0.47; % [0 1 0] color verde
% c(I3,1) = 0.93; c(I3,2) = 0.57; c(I3,3) = 0.13; % [1 1 0] color amarillo
% c(I4,1) = 0.83; c(I4,2) = 0; c(I4,3) = 0; %

c(I1) = 1*sigma_med;
c(I2) = 2*sigma_med;
c(I3) = 3*sigma_med;
c(I4) = 4*sigma_med;

Min = 0.;
Max = 4*sigma_med;

set (0, 'defaultaxesfontname', 'Arial')
set (0, 'defaulttextfontname', 'Arial')

figure; hold on;
set(gca, 'linewidth', 4, 'fontsize', 20); % grosor de la lineas de los ejes y el tamaño de la letra
set(gca,'ticklength', 2.5*get(gca,'ticklength')) %largo de los ticksmarks
xlim([0 0.51]);
graphics_toolkit gnuplot
%plot(1:2);
title('\alpha')
xlabel('\theta/\pi','fontsize',20);
ylabel('distancias','fontsize',20);
h = colorbar;
set(gca, 'clim', [Min, Max]);
scatter(dist(:,2)/pi,dist(:,6),10,c,'filled'); colorbar('ytick', [0,sigma_med, 2*sigma_med, 3*sigma_med, 4*sigma_med],...
                                                        'yticklabel', {'0', '\sigma', '2\sigma', '3\sigma', '4\sigma'})
print -depsc out.eps


% % paleta de eloisa
% c(I1,1) = 0.38; c(I1,2) = 0.51; c(I1,3) = 0.71; % [0 0 1] color azul
% c(I2,1) = 0; c(I2,2) = 0.66; c(I2,3) = 0.47; % [0 1 0] color verde
% c(I3,1) = 0.93; c(I3,2) = 0.57; c(I3,3) = 0.13; % [1 1 0] color amarillo
% c(I4,1) = 0.83; c(I4,2) = 0; c(I4,3) = 0; %

% otra paleta
