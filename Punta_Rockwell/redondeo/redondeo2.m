% Carlos Daniel Jiménez Sosa
% cjimen23@eafit.edu.co / danieljimenez94@gmail.com
% Procésos Numéricos

x = input('Ingrese su número :');
decimales = input('Ingrese el número de decimales :');
metodo = input('Ingrese el método de redondeo :', 's');
comas = 10^decimales;
num = x*comas;

if (strcmpi(metodo, 'corte'))
 rd = floor(num);
 resultado = rd/comas;
 printf('Este es su número redondeado por el método de redondeo por corte : %f \n',resultado);

else
 if (strcmpi(metodo, 'exceso'))
 rd = ceil(num);
 resultado = rd/comas;
 printf('Este es su número redondeado por el método de redondeo por exceso : %f \n',resultado);

 else

 if (strcmpi(metodo, 'estadistico'))
 rd = round(num);
 resultado = rd/comas;
 printf('Este es su número redondeado por el método de redondeo simétrico estadístico : %f \n',resultado);

 else

 if (strcmpi(metodo, 'distancia'))
 rd = roundb(num);
 resultado = rd/comas;
 printf('Este es su número redondeado por el método de redondeo simétrico a distancia : %f \n',resultado);

 endif

 endif

 endif
endif
