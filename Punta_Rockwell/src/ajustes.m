% clear; close all;

function ajustes(p1, p2, p3, p4, p5)

  switch nargin
    case 0
      parameters = ["-p"];
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
    param = parameters(i,:);
    param
    switch(param)
      case "-o"
        ajustes_optimizacion;
      case "-g"
        ajustes_grafico;
      case "-r"
        ajustes_redondeo;
      case "-e"
        ajustes_errores;
      case "-p"
        ajustes_parametros;

      otherwise
        display("Los parámetros posibles son: -o, -g, -r , -e, -p");

    endswitch
  end;
end;
