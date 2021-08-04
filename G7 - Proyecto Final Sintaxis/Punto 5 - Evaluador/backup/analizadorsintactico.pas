unit AnalizadorSintactico;

{$mode objfpc}{$H+}

interface
Uses
 crt, Classes, SysUtils, Pila, Arbol, Matriz, TAS_Matriz, Identificadores,
 Archivo, TabSimb, TabSimb_Aplicacion;



 procedure ObtenerArboldeDerivacion(var raiz:Tarbol;TAS:TTAS; var Fuente:t_arch;T_S:T_lista;var exito:boolean);

implementation

procedure ObtenerArboldeDerivacion(var raiz:Tarbol;TAS:TTAS;var Fuente:t_arch;T_S:T_lista;var exito:boolean);
var
  Error:boolean;
  Control:integer;
  X:TSimbGramatical;
  Lexema:string;
  complex:TSimbGramatical;
  Salir:boolean;
  Punt:Tarbol;
  ComplexHijo:TSimbGramatical;
  LexemaHijo:String;
  i:byte;
  hijo:Tarbol;
  P:TPila;
  texto:text;
begin
  Complex:=VPrograma;
  Lexema:='Programa';
  agregar_arbol(Raiz,CompLex,Lexema);
  Apilar(P,TAS[VPrograma,Tvar],raiz);
  Exito:=false;
  Error:=false;
 ObtenerSiguienteCompLex(Fuente,control,complex,lexema,T_S);
  While not (Exito) and not (Error) do
    begin
     //writeln(Lexema,CompLex);
      Desapilar(P,X,Punt);
      If EsVariable(X) then
      begin
         //BuscarLexExiste(T_S,Lexema,Complex,error);
         If TAS[X,complex]=NIL then
         begin
          Error:=True;
          writeln('error para variable: ', x,' para el compLex:  ', compLex, ' lexema: ', lexema, ' control: ', control);
         end
         else
          begin                 //al nodo x le agegamos sus hijos
            for i:= 1 to TAS[X,complex]^.cant do
              begin
                ComplexHijo:= TAS[X,complex]^.elementos[i];
                LexemaHijo:='';
                agregar_arbol(hijo,ComplexHijo,LexemaHijo);
                Agregar_Hijo(Punt,hijo);
              end;
            Apilar(P,TAS[X,complex],Punt);   //Cuando se apila se apunta a su respectivo nodo (Hijo)
          end;
       end
      else
       begin
        if X=complex then
         begin
           //Guardar lexmena en el nodo que le corresponde a x
           if X<>Pesos then
            Punt^.Lexema:=Lexema;
           ObtenerSiguienteCompLex(Fuente,control,complex,lexema,T_S);
           writeln(lexema);
         end
        else
         begin
          writeln('se esperaba: ',X, ' Se obtuvo: ', CompLex);
          writeln('ERROR');
         Error:=True;
         end;
       end;
      if (complex=pesos) and (X=pesos) then
       Exito:=True;
    end;
  end;
end.

