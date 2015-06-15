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
% decimales = 3;
format long;
r_medio = [] ;
ang_medio = [] ;
theta_medio = [] ;

[r, rsim] = punta3(L, R, R2, alpha, sigma, NUM_PUNTOS);

resultado = [];

for decimales = 1: 7

  rsim2 = redondeo(rsim, decimales);

  [popt, d, dist, theta_umbral] = cuad_ort_punta(L, R, R2, alpha, sigma, rsim2);

  resultado = [resultado; decimales popt(6) popt(7) popt(1)];

end
save('redondeo.dat', '-ascii', 'resultado')
figure
plot(resultado(:,1),resultado(:,2))
figure
plot(resultado(:,1),resultado(:,3))
figure
plot(resultado(:,1),resultado(:,4))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:20
  [r, rsim] = punta3(L, R, R2, alpha, sigma, NUM_PUNTOS);

  resultado = [];

  for decimales = 1: 7

    rsim2 = redondeo(rsim, decimales);

    [popt, d, dist, theta_umbral] = cuad_ort_punta(L, R, R2, alpha, sigma, rsim2);

    resultado = [resultado; decimales popt(6) popt(7) popt(1)];

  endfor
endfor
