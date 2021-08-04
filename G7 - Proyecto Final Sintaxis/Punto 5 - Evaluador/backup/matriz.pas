unit Matriz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, crt, TabSimb;

const
  Emax=8;

type

  Tcelda =  record
                 elementos: array[1..Emax] of TSimbGramatical;
                 cant: byte;
                 end;
  TpunteroCelda = ^Tcelda;
  TTAS = array[VPrograma..VF,TConstEntera..pesos] of TpunteroCelda;      //inicializar en nil  y cargar

implementation

end.

