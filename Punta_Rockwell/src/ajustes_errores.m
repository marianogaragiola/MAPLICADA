% -------------------------------------------------------------------------------%
% Este codigo toma varios valores de sigma (desviacion estandar en los datos     %
% simulados) y va haciendo la minimizacion por cudrados minimos. Para cada valor %
% de sigma, genera N conjuntos de puntos simulados y calcula los parametros de   %
% optimizacion R, theta y phi. Luego con los N valores de cada parametro calcula %
% la desviacion estandar y promedio de cada parametro para despues grabarlo en   %
% un archivo .dat.                                                               %
%--------------------------------------------------------------------------------%

clear all; close all;

L = 0.4; % en mm
R = 0.2; % en mm
R2 = 0.25; % en mm
alpha = pi/3; % en radianes
%sigma = 0.35e-3; % es el equivalente a 0.35 micrometros
vec_sigma = linspace(1e-4,1e-3,20);
NUM_PUNTOS = 320;
format long;
r_medio = [] ;
ang_medio = [] ;
theta_medio = [] ;

radio = [];
angulo = [];
theta = [];

titulo = '# sigma R error_R error_relativo_R phi error_phi error_relativo_phi theta error_theta error_relativo_theta';
save( '../salida/errores5.dat', 'titulo')



for sigma = vec_sigma

  for i = 1: 100

    [r, rsim] = punta(L, R, R2, alpha, sigma, NUM_PUNTOS);

    [popt, d, dist] = cuad_ort_punta(L, R, R2, alpha, sigma, rsim);

    radio = [radio; popt(6)];
    angulo = [angulo; popt(7)];
    theta = [theta; popt(1)];
  end

  r_medio = [mean(radio) std(radio) std(radio)/mean(radio)] ;
  ang_medio = [mean(angulo) std(angulo) std(angulo)/mean(angulo)] ;
  theta_medio = [mean(theta) std(theta) std(theta)/mean(theta)] ;


  vec_salida = [sigma r_medio ang_medio theta_medio];
  save('-append', '-ascii', '../salida/errores5.dat', 'vec_salida' )
end
