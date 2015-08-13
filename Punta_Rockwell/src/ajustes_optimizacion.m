clear all; close all;

L = 0.4; % en mm
R = 0.2; % en mm
R2 = 0.25; % en mm
alpha = pi/3; % en radianes
sigma = 1e-4; % es el equivalente a 0.35 micrometros
vec_N = 5:5:100;
NUM_PUNTOS = 320;
format long;
r_medio = [] ;
ang_medio = [] ;
theta_medio = [] ;

radio = [];
angulo = [];
theta = [];

file = fopen('../salida/estabilizacion.txt', 'w');
fprintf(file, '# sigma   1/N   R   error_R   phi   error_phi   theta   error_theta \n');
fclose(file);

for N = vec_N

  for i = 1: N

    [r, rsim] = punta(L, R, R2, alpha, sigma, NUM_PUNTOS);

    [popt, d, dist] = cuad_ort_punta(L, R, R2, alpha, sigma, rsim);

    radio = [radio; popt(6)];
    angulo = [angulo; popt(7)];
    theta = [theta; popt(1)];
  end


  r_medio = [mean(radio) std(radio)] ;
  ang_medio = [mean(angulo) std(angulo)] ;
  theta_medio = [mean(theta) std(theta)] ;


  vec_salida = [sigma 1./N r_medio ang_medio theta_medio];
  save('-append', '-ascii', '../salida/estabilizacion.txt', 'vec_salida' )
end
