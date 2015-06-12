clear all
close all

L = 0.4; % en mm
R = 0.2; % en mm
R2 = 0.25; % en mm
alpha = pi/3; % en radianes
%sigma = 0.35e-3; % es el equivalente a 0.35 micrometros
sigma = 0.0002;
NUM_PUNTOS = 320;

% NOTA PARA ELEGIR EL NUMERO DE DECIMALES:
% 4 decimales seria redondear a la decima de micrometro.
% 5 decimales seria redondear a la centena de micrometro.
decimales = 3;
format long;
r_medio = [] ;
ang_medio = [] ;
theta_medio = [] ;

for decimales = 1: 7
  radio = [];
  angulo = [];
  theta = [];

  for i = 1: 10

    [r, rsim] = punta3(L, R, R2, alpha, sigma, NUM_PUNTOS);

    rsim = redondeo(rsim, decimales);

    [popt, d, dist, theta_umbral] = cuad_ort_punta(L, R, R2, alpha, sigma, rsim);

    radio = [radio; popt(6)];
    angulo = [angulo; popt(7)];
    theta = [theta; popt(1)];
  end

  r_medio = [ r_medio; decimales mean(radio) std(radio)] ;
  ang_medio = [ ang_medio; decimales mean(angulo) std(angulo)] ;
  theta_medio = [ theta_medio; decimales mean(theta) std(theta)] ;
% aca hago el ajuste con los datos medidos por clemar
end

% filename='Datos_XYZ_Punta_SN_5620-R2=025mm.TXT';
%
% rmed = load(filename, '-ascii');
% rmed = redondeo(rmed, decimales);
%
% [popt, d, dist, theta_umbral] = cuad_ort_punta(L, R, R2, alpha, sigma, rmed);
%
% theta_angulo_solido = acos(rmed(:,3)./sqrt(rmed(:,1).^2+rmed(:,2).^2+rmed(:,3).^2));
% phi_angulo_solido = (1-sign(rmed(:,2)))/2*pi + acos(rmed(:,1)./sqrt(rmed(:,1).^2+rmed(:,2).^2));
% dist = [phi_angulo_solido theta_angulo_solido dist];
%
% % desviacion estandar con los datos medidos
% sigma_med = std(dist(:,6));
%
% save('-ascii', 'distancias.dat', 'dist');
%
% r_medido = [popt(6) std(radio)] ;
% angulo_medido = [popt(7) std(angulo)] ;
% theta_medido = [popt(1) std(angulo)] ;
