unit Arbol;

{$mode objfpc}{$H+}

interface

uses
  Classes,SysUtils,crt,TabSimb,Matriz;

Type

  Tarbol=^Tnodo;

   Tnodo=record
              simb:TSimbGramatical;
              Lexema:string;
              hijos:array[1..Emax] of Tarbol;
              cant_hijos:0..Emax;
              end;
  T_hijos=array[1..Emax] of Tarbol;

 var
   Raiz:Tarbol;
   Hijos:T_hijos;

Procedure crear_arbol(var raiz:Tarbol);
Procedure agregar_arbol(var raiz:Tarbol;CompLex:TSimbGramatical;Lexema:String);
Procedure agregar_hijo(var raiz,hijo:Tarbol);
Procedure Mostrar_arbol (var arbol:Tarbol; desplazamiento:byte;var archArb:text);

implementation

Procedure crear_arbol(var raiz:Tarbol);
  begin
    raiz:=nil;
  end;

Procedure agregar_arbol(var raiz:Tarbol;CompLex:TSimbGramatical ;Lexema:String);
var
  i:integer;
  aux:Tarbol;
 begin
   new(aux);
   aux^.simb:=CompLex;
   aux^.Lexema:=lexema;
   aux^.cant_hijos:=0;
   for i:=1 to Emax do
   begin
   aux^.hijos[i]:=nil;
   end;
   raiz:=aux;
 end;

Procedure agregar_hijo(var raiz,hijo:Tarbol);
begin
  If raiz^.cant_hijos<Emax then
  begin
   inc(raiz^.cant_hijos);
   raiz^.hijos[raiz^.cant_hijos]:=hijo;
 end;
end;

Procedure Mostrar_arbol (var arbol:Tarbol; desplazamiento:byte;var archArb:text);

var i:integer;
begin
   writeln(archArb,'':desplazamiento,arbol^.simb,' - ',arbol^.lexema);
 for i:=1 to arbol^.cant_hijos do
   begin
      Mostrar_arbol(arbol^.hijos[i],desplazamiento+2,archArb);
   end;
end;
end.
