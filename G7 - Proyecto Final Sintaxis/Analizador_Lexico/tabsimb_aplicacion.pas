unit TabSimb_Aplicacion;

{$mode objfpc}{$H+}

interface

uses
  TabSimb,crt,Sysutils;


procedure baja(var L:T_lista);
procedure Chequear_lista(var L:T_lista);
procedure InstalarEnTS(Lexema:string;var TS:T_lista;var CompLex:TSimbGramatical);
procedure BuscarLexExiste(var TS:t_lista; Lexema:string; var CompLex:TSimbGramatical; var exito:boolean);
procedure recuperar (var TS:t_lista;var E:t_dato);
procedure siguiente (var TS:t_lista);
procedure primero (var TS:t_lista);
function fin (var TS:t_lista):boolean;

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


procedure InstalarEnTS(Lexema:string;var TS:T_lista; var CompLex:TSimbGramatical);
var
  R:T_dato;
  exito:boolean;
  compLex01:TSimbGramatical;
 begin
   // busqueda de lexema existenete en la tabla de simbolos
 BuscarLexExiste(TS,Lexema,CompLex01,exito);
      If exito = true then
       begin
        CompLex:=CompLex01;
       end
  else
   begin
   cargar(TS,lexema,TIdentificador);
   end;
end;

procedure BuscarLexExiste(var TS:t_lista; Lexema:string; var CompLex:TSimbGramatical; var exito:boolean);
 var  E:T_dato;
 begin
    exito:=false;
    primero(TS);
    while (not fin(TS) and not exito)  do
     begin
       recuperar(TS,E);
       If E.Lexema = UpperCase(Lexema) then
        begin
             exito:=true;
             CompLex:=E.CompLex;
        end
       else
       begin
         siguiente(TS);
       end;
     end;
 end;

{function lista_vacia(L:t_lista):boolean;
 begin
     lista_vacia:= L.tam=0;
 end;
 function lista_llena(L:t_lista):boolean;
 begin
     lista_llena:= getheapstatus.totalfree<sizeof(t_nodo);
 end; }

 procedure recuperar (var TS:t_lista;var E:t_dato);
 begin
   E:=TS.act^.info;
 end;
 procedure siguiente (var TS:t_lista);
 begin
   TS.act:=TS.act^.sig;
 end;
 procedure primero (var TS:t_lista);
 begin
   TS.act:=TS.cab;
 end;
function fin (var TS:t_lista):boolean;
  begin
    fin:=TS.act=nil;
  end;

end.

