unit TabSimb_Aplicacion;

{$mode objfpc}{$H+}

interface

uses
  TabSimb,crt;


procedure baja(var L:T_lista);
procedure Chequear_lista(var L:T_lista);
procedure InstalarEnTS(Lexema:string;var TS:T_lista;CompLex:TSimbGramatical);



implementation

procedure baja(var L:T_lista);
var
  buscado:String[10];
  E:T_dato;
  begin
    write('Nombre a borrar: ');
    readln(buscado);
    Eliminar(L,buscado,E);
  end;

procedure listar(L:T_lista);
var
  E:T_dato;
  begin
    Primero(L);
    while (not fin(L)) do
     begin
       Recuperar(L,E);
       write(E.CompLex, ' ');
       writeln(E.Lexema);
       Siguiente(L);
     end;
  end;

procedure Chequear_lista(var L:T_lista);
  begin
    if not lista_vacia(L) then listar(L) else write('Lista vacia');

  end;


procedure InstalarEnTS(Lexema:string;var TS:T_lista;CompLex:TSimbGramatical);
var
  R:T_dato;
  complex01:string;
 begin
   complex01:=complex;
   R.Lexema:=Lexema;
   R.CompLex:=CompLex01;
   cargar(TS,R);
 end;
end.

