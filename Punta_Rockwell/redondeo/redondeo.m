function xred = redondeo(x,n);

  comas = 10^n;
  num = x*comas;

  rd = round(num);
  xred = rd/comas;

end
