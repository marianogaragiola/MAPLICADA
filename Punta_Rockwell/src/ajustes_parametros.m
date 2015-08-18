% close all;
% clear all;

L = 0.4; % en mm
R = 0.2; % en mm
R2 = 0.25; % en mm
alpha = pi/3; % en radianes
sigma = 0.0002;
NUM_PUNTOS = 320;
Nsim = 10;
format long;

% Acá leo los archivos que  estan en la carpeta entrada y después los paramétros por input
directory = dir('../entrada');
for i=1:size(directory,1)
	display([num2str(i) ') ' directory(i).name]);
end
ans = input ('Seleccione archivo de entrada: ');
filename=['../entrada/' directory(ans).name];
L=input ('Ingrese L(en mm)[default 0.4]: ');
R=input ('Ingrese R(en mm)[default 0.2]: ');
R2=input ('Ingrese R2(en mm): ');

if isempty(L)
	L=0.4;
end
if isempty(R)
	R=0.2;
end

% Primero hacemos los ajustes con los datos de Clemar para calcular los parametros y la desviacion
% estandar que vamos a usar para simular las mediciones.
rmed = load(filename, '-ascii');

[popt, d, dist, theta_umbral, zce, errores] = cuad_ort_punta(L, R, R2, alpha, sigma, rmed);

save('-ascii', '../salida/distancia.txt', 'dist');

% desviacion estandar con los datos medidos
sigma_med = std(dist(:,4));
sigma = sigma_med;

% Ahora creamos los datos simulados y calcular el error en los parametros.

radio = [];
angulo = [];
theta = [];

for i = 1: Nsim
  [r, rsim] = punta(L, R, R2, alpha, sigma, NUM_PUNTOS);

  [popt2, d2, dist2, theta_umbral2] = cuad_ort_punta(L, R, R2, alpha, sigma, rsim);

  radio = [radio; popt2(6)];
  angulo = [angulo; popt2(7)];
  theta = [theta; popt2(1)];
end

r_medido = [popt(6) std(radio)] ;
angulo_medido = [popt(7) std(angulo)] ;
theta_medido = [popt(1) std(theta)] ;

disp('Radio de la esfera palpadora')
r_medido

disp('Ángulo de abertura del cono')
angulo_medido

disp('Ángulo entre el eje z y el eje del cono')
theta_medido

errores
