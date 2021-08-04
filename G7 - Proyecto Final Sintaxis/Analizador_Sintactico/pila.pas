unit Pila;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,TabSimb,Arbol,Matriz;

type
    Tdato=TSimbGramatical;
    puntero=^nodo;
    nodo= record
        info:Tdato;
        Parbol:Tarbol;
        siguiente:puntero;
    end;
    Tpila= record
         tope:puntero;
         tam:cardinal;
    end;

procedure Apilar(var P:Tpila; var nuevoDato:TpunteroCelda; Punt:Tarbol);
procedure Desapilar (var P:Tpila; var E:TSimbGramatical; var Puntero:Tarbol);
procedure crearPila(var P:TPila);

implementation

procedure CrearPila(var P:TPila);
begin
   P.tope:=nil;
   P.tam:=0;
end;


procedure Apilar(var P:Tpila; var nuevoDato:TpunteroCelda; Punt:Tarbol);
var
    nuevoNodo: puntero;
    Elem_Vec: TSimbGramatical;
    i, Cantidad: Byte;

begin
    if P.tope=nil then
     begin
        new(nuevoNodo);
        nuevoNodo^.info:= pesos;
        nuevoNodo^.siguiente:=P.tope;
        P.tope:= nuevoNodo;
        P.tam:= P.tam + 1;
        new(nuevoNodo);
        nuevoNodo^.info:= VPrograma;
        nuevoNodo^.Parbol:=Raiz;
        nuevoNodo^.siguiente:=P.tope;
        P.tope:= nuevoNodo;
        P.tam:= P.tam + 1;
     end
    else
    begin
      Cantidad:=nuevoDato^.cant;
        For i:=Cantidad downto 1 do
          Begin
            Elem_Vec:= nuevoDato^.elementos[i];
            new(nuevoNodo);
            nuevoNodo^.info:= Elem_Vec;
            nuevoNodo^.Parbol:=Punt^.hijos[i];
            nuevoNodo^.siguiente:= P.tope;
            P.tope:= nuevoNodo;
            inc(P.tam);
          end;
    end;
end;

procedure Desapilar(var P:Tpila;var E:TSimbGramatical; var Puntero:Tarbol);
var
    nuevoTope:puntero;
begin
    E:=P.tope^.info;
    Puntero:=P.tope^.Parbol;
    nuevoTope:= P.tope^.siguiente;
    dispose(P.tope);
    P.tope := nuevoTope;
    dec(P.tam) ;
end;

end.
