%clear all; close all;

function ajustes(parameters)
  %ans = input ("Seleccionar opción");
  %argumentos=argv ();
  %display(parameters);
  switch(parameters)
    case "-o"
      ajustes_optimizacion;
    case "-g"
      ajustes_grafico;
    case "-r"
      ajustes_redondeo;
    case "-e"
      ajustes_errores;
    
    otherwise
      display("Los parámetros posibles son: -o, -g, -r , -e");
    
    endswitch
end;