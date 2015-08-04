% clear; close all;

function ajustes(p1, p2, p3, p4, p5)

  switch nargin
    case 0
      parameters = ["p"];
    case 1
      parameters = [p1];
    case 2
      parameters = [p1; p2];
    case 3
      parameters = [p1; p2; p3];
    case 4
      parameters = [p1; p2; p3; p4];
    case 5
      parameters = [p1; p2; p3; p4; p5];
  endswitch

  for i = 1:length(parameters);
    param = parameters(i,1);
    % param
    switch(param)
      case "o"
        disp("Optimizacion")
        ajustes_optimizacion;
      case "g"
        disp("Graficos")
        ajustes_grafico;
      case "r"
        disp("Redondeo")
        ajustes_redondeo;
      case "e"
        disp("Errores")
        ajustes_errores;
      case "p"
        disp("Parametros")
        ajustes_parametros;

      otherwise
        display("Los parámetros posibles son: o, g, r , e, p");

    endswitch
  end;

end;
