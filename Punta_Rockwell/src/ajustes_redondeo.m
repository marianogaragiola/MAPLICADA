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
% r_medio = [] ;
% ang_medio = [] ;
% theta_medio = [] ;
%
% [r, rsim] = punta(L, R, R2, alpha, sigma, NUM_PUNTOS);
%
% resultado = [];
%
% for decimales = 1: 7
%
%   rsim2 = redondeo(rsim, decimales);
%
%   [popt, d, dist, theta_umbral] = cuad_ort_punta(L, R, R2, alpha, sigma, rsim2);
%
%   resultado = [resultado; decimales popt(6) popt(7) popt(1)];
%
% end
% save('../salida/redondeo.dat', '-ascii', 'resultado')
% figure
% plot(resultado(:,1),resultado(:,2))
% figure
% plot(resultado(:,1),resultado(:,3))
% figure
% plot(resultado(:,1),resultado(:,4))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% aca estaria bueno cambiar los nombres de las variables si no es un quilombo
resultado = [];

for i = 1:3
  [r, rsim] = punta(L, R, R2, alpha, sigma, NUM_PUNTOS);

  aux = [];
  for decimales = 1:7

    rsim2 = redondeo(rsim, decimales);

    [popt, d, dist, theta_umbral] = cuad_ort_punta(L, R, R2, alpha, sigma, rsim2);

    aux = [aux decimales popt(6) popt(7) popt(1)];

  end

  resultado = [resultado; aux];

end


for i = 1:28

  if(mod(i,4)==1)
    resuldato(i) = resultado(1,i);
  else
    resuldato(i) = std(resultado(:,i));
  endif

end

dev_std = [];
for i = 1:7
  dev_std = [dev_std; resuldato(4*(i-1)+1:4*i)];
end

save('../salida/desviaciones_estandar-vs-num_decimales.dat', '-ascii', 'dev_std')
