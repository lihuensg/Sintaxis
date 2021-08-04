unit Evaluador;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Arbol,TabSimb_Aplicacion,TabSimb,Math;
const
  MaxElemList=4000000;

type
  TipoListaReal= record
    Elemento:array[1..MaxElemList] of Real;
    cant:integer;
  end;
  PunteroListaReal=^TipoListaReal;    // verificar si es necesario crearlo en memoria con "new()"

  TipoValor = record          // resultado
    R:Real;
    L:PunteroListaReal;        // en los precedimientos de lista pasar 'PunteroListaReal' como varbles
    Tipo:TSimbGramatical;
  end;
  {TipoElementoEstado = record
    NombreVar:string;
    Valor: TipoValor;
  end; }

 t_puntero2=^t_nodo2;
  t_nodo2 = record
       variable:string;
       valor:TipoValor;
       sig:t_puntero2;
  end;
  t_lista2 = record
       cab,act:t_puntero2;
       tam:integer;
  end;

 procedure evalPrograma(arb:Tarbol; estado:t_lista2);
 procedure evalVariables(arb:Tarbol; var estado:t_lista2);
 Procedure evalIdVar(arb:Tarbol; estado:t_lista2);
 procedure evaltipo(arb:Tarbol; var Tipodevar:TSimbGramatical);
 Procedure evalCuerpo(arb:Tarbol;estado:t_lista2);
 procedure evalSent(arb:Tarbol;estado:t_lista2);
 procedure evalU(arb:Tarbol;estado:t_lista2;var resultado:TipoValor);
 procedure evalL(arb:Tarbol;estado:t_lista2; var resultado:TipoValor);
 procedure evalT(arb:Tarbol;estado:t_lista2; var resultado:TipoValor);
 procedure evalCondiciones(arb:Tarbol; estado:t_lista2;var resultado:boolean);
 procedure evalW(arb:Tarbol;estado:t_lista2;operando1:boolean;var resultado:boolean);
 procedure evalZ(arb:Tarbol;estado:t_lista2;operando1:boolean; var resultado:boolean);
 procedure evalCond(arb:Tarbol; estado:t_lista2; var resultado:boolean);
 procedure evalSino(arb:Tarbol; estado:t_lista2);
 procedure evalExpArit(arb:Tarbol; estado:t_lista2; var resultado:TipoValor);
 procedure evalB(arb:Tarbol; estado:t_lista2; operando1:TipoValor; var resultado:TipoValor);
 procedure evalA(arb:Tarbol; estado:t_lista2; var resultado:TipoValor);
 procedure evalD(arb:Tarbol; estado:t_lista2; operando1:TipoValor; var resultado:TipoValor);
 procedure evalC(arb:Tarbol; estado:t_lista2; var resultado:TipoValor);
 procedure evalE(arb:Tarbol; estado:t_lista2;operando1:TipoValor; var resultado:TipoValor);
 procedure evalF(arb:Tarbol; estado:t_lista2; var resultado:TipoValor);
 procedure agregarvariable( var estado:T_lista2;cadena:string;tipodevar:TSimbGramatical);
 procedure agregar_lista (var estado:T_lista2;cadena:string; variable:TSimbGramatical);
 function esta_en_lista(var L:T_lista2; buscado:string):boolean;
 function Fin2(L:T_lista2):boolean;
 procedure Siguiente2(var L:T_lista2);
 procedure asignarEstado(var L:T_lista2; variable:string; resultado:TipoValor);
 procedure agregarLista(var L:PunteroListaReal; resultado2:tipoValor);
 procedure obtenerValorId(variable:string; L:T_lista2; var resultado:TipoValor);
 procedure pasarEntero(cadena:string; var resultado:TipoValor);
 function obtenerElemento(L:PunteroListaReal;pos:integer):real;
 procedure crearLista(var resultado:TipoValor);
 function cantidadElementos(resultado1:TipoValor):integer;
 Procedure IncializarLista2(var L:T_lista2);
 procedure EliminarElementoLista(var L:PunteroListaReal;resultado:TipoValor);
 procedure ReemplazarElemLista(var L:PunteroListaReal;Pos:TipoValor;Elemento:TipoValor);

implementation

 procedure evalPrograma(arb:Tarbol; estado:t_lista2);
      begin
        evalVariables(arb^.hijos[2], estado);
        evalCuerpo(arb^.hijos[4], estado);
      end;
 procedure evalVariables(arb:Tarbol; var estado:t_lista2);
 var
   tipodevar:TSimbGramatical;
      begin
        evalTipo(arb^.hijos[3], tipodevar);
        agregarvariable(estado, arb^.hijos[1]^.lexema, tipodevar);
        evalIdVar(arb^.hijos[4],estado);
      end;

 Procedure evalIdVar(arb:Tarbol; estado:t_lista2);
   var
   tipodevar:TSimbGramatical;
   begin
     If  not (arb^.cant_hijos = 0) then
         begin
              evalTipo(arb^.Hijos[4], tipodevar);
              agregarvariable(estado, arb^.Hijos[2]^.lexema, tipodevar);
              evalIdVar(arb^.hijos[5],estado);
          end;
   end;

 procedure evaltipo(arb:Tarbol; var Tipodevar:TSimbGramatical);
   var
     prod:TsimbGramatical;
     begin
       prod:=arb^.hijos[1]^.simb;
          If prod=TReal then
             begin
             tipodevar:=Treal;
             end;
          If prod=TListaReal then
             begin
             tipodevar:=TListaReal;
             end;

     end;

 Procedure evalCuerpo(arb:Tarbol;estado:t_lista2);
    begin
      If  not (arb^.cant_hijos = 0) then
         begin
           evalSent(arb^.hijos[1], estado);
           evalCuerpo(arb^.hijos[3], estado);
         end;
    end;

 procedure evalSent(arb:Tarbol;estado:t_lista2);
 var
  prod:TsimbGramatical;
  resultado,resultado1,resultado2:TipoValor;
  resultCondiciones:boolean;
    begin
      prod:=arb^.hijos[1]^.simb;
      If prod = Tidentificador then
         begin
           evalU(arb^.hijos[3], estado, resultado);
           asignarEstado(estado, arb^.hijos[1]^.lexema, resultado);
         end;
      If prod = TLeer then
            begin
              resultado.tipo:=Treal;
              write(arb^.hijos[3]^.lexema);
              read(resultado.R);
              asignarEstado(estado, arb^.hijos[5]^.lexema, resultado);
            end;
       If prod = TEscribir then
          begin
            evalExpArit(arb^.hijos[5], estado, resultado);
            writeln(arb^.hijos[3]^.lexema,'', resultado.R);
          end;
       If prod = TSi then
          begin
             evalCondiciones(arb^.hijos[2], estado, resultCondiciones);
            If resultCondiciones then
              begin
               evalCuerpo(arb^.Hijos[4], estado);
              end
            else
              begin
                evalSino(arb^.hijos[6], estado);
              end;
          end;
       If prod = TMientras then
          begin
            evalCondiciones(arb^.hijos[2], estado, resultCondiciones);
               while resultCondiciones do
                  begin
                     evalCuerpo(arb^.hijos[4], estado);
                     evalCondiciones(arb^.hijos[2], estado, resultCondiciones);
                  end;
          end;
       If prod= Tagregar then
          begin
            obtenerValorId(arb^.hijos[3]^.lexema,estado,resultado);
            evalExpArit(arb^.hijos[5],estado,resultado1);
            agregarLista(resultado.L,resultado1);
          end;
       If prod= Teliminar then
          begin
            obtenerValorId(arb^.hijos[3]^.lexema,estado,resultado);
            evalExpArit(arb^.hijos[5],estado,resultado1);
            EliminarElementoLista(resultado.L,resultado1);
          end;
       If prod= Treemplazar then
          begin
            obtenerValorId(arb^.hijos[3]^.lexema,estado,resultado);
            evalExpArit(arb^.hijos[5],estado,resultado1);
            evalExpArit(arb^.hijos[7],estado,resultado2);
            ReemplazarElemLista(resultado.L,resultado1,resultado2);
          end;
    end;

 procedure evalU(arb:Tarbol;estado:t_lista2; var resultado:TipoValor);
 var
   prod:TsimbGramatical;
     begin
       prod:=arb^.hijos[1]^.simb;
       If prod = VExpArit then
         begin
          evalExpArit(arb^.hijos[1], estado, resultado);
         end;
       If prod = TcorchI then
         begin
           crearLista(resultado);
           evalL(arb^.hijos[2], estado, resultado);
         end;
    end;

 procedure evalL(arb:Tarbol;estado:t_lista2; var resultado:TipoValor);
  var
    resultado2:TipoValor;
     begin
       If  not (arb^.cant_hijos = 0) then
         begin
           evalExpArit(arb^.hijos[1], estado, resultado2);
           agregarLista(resultado.L, resultado2);
           evalT(arb^.hijos[2], estado, resultado);
         end;
     end;

  procedure evalT(arb:Tarbol;estado:t_lista2;var resultado:TipoValor);
  var
    resultado2:TipoValor;
     begin
       If  not (arb^.cant_hijos = 0) then
         begin
           evalExpArit(arb^.hijos[2], estado, resultado2);
           agregarLista(resultado.L, resultado2);
           evalT(arb^.hijos[3], estado, resultado);
         end;
     end;

  procedure evalCondiciones(arb:Tarbol; estado:t_lista2; var resultado:boolean);
   var
     operando1,resultadoAND:Boolean;
     begin
      evalCond(arb^.hijos[1], estado, operando1);
      evalZ(arb^.hijos[2], estado,operando1, resultadoAND);
      evalW(arb^.hijos[3], estado, resultadoAND, resultado);
    end;

procedure evalW(arb:Tarbol;estado:t_lista2;operando1:boolean; var resultado:Boolean);
 var
   operando2:boolean;
   begin
      If  not (arb^.cant_hijos = 0) then
        begin
           evalCondiciones(arb^.hijos[2], estado, operando2);
           resultado:= operando1 or operando2;
        end
      else
        begin
          resultado:= operando1;
        end;
   end;

 procedure evalZ(arb:Tarbol;estado:t_lista2;operando1:boolean; var resultado:Boolean);
 var
   operando2,aux:boolean;
   begin
      If  not (arb^.cant_hijos = 0) then
        begin
           evalCond(arb^.hijos[2], estado, operando2);
           aux:=operando1 and operando2;
           evalZ(arb^.hijos[3], estado, aux, resultado);
        end
      else
        begin
          resultado:=operando1;
        end;
   end;

 procedure evalCond(arb:Tarbol; estado:t_lista2; var resultado:boolean);
 var
   resultado1,resultado2:TipoValor;
   prod:TsimbGramatical;
   OpRel:string;
     begin
       prod:=arb^.hijos[1]^.simb;
       OpRel:=arb^.hijos[2]^.lexema;
      If prod= Tnot then
        begin
          evalCond(arb^.hijos[2], estado, resultado);
          resultado:= not(resultado);
        end;
      If prod=TcorchI  then
        begin
            evalCondiciones(arb^.hijos[2], estado, resultado);
        end;
      If prod= VExpArit then
        begin
           evalExpArit(arb^.hijos[1], estado, resultado1);
           evalExpArit(arb^.hijos[3], estado, resultado2);
         If OpRel = '<' then
            begin
               resultado:= resultado1.R < resultado2.R;
            end;
        If OpRel = '<='  then
            begin
               resultado:= resultado1.R <= resultado2.R;
            end;
        If OpRel = '>'  then
            begin
               resultado:= resultado1.R > resultado2.R;
            end;
        If OpRel = '>=' then
            begin
               resultado:= resultado1.R >= resultado2.R;
            end;
        If OpRel = '<>' then
            begin
               resultado:= resultado1.R <> resultado2.R;
            end;
        If OpRel = '='  then
            begin
               resultado:= resultado1.R = resultado2.R;
            end;
        end;
   end;

 procedure evalSino(arb:Tarbol; estado:t_lista2);
     begin
        If  not (arb^.cant_hijos = 0) then
          begin
            evalCuerpo(arb^.hijos[3], estado);
          end;
     end;

 procedure evalExpArit(arb:Tarbol; estado:t_lista2; var resultado:TipoValor);
  var
    resultadoA:TipoValor;
    begin
       evalA(arb^.hijos[1], estado, resultadoA);
       evalB(arb^.hijos[2], estado, resultadoA, resultado);
    end;

 procedure evalB(arb:Tarbol; estado:t_lista2; operando1:TipoValor; var resultado:TipoValor);
 var
   resultadoA,suma,resta:TipoValor;
  prod:string;
     begin
        suma.tipo:=Treal;
        resta.tipo:=Treal;
        If (arb^.cant_hijos = 0) then
        begin
          resultado:= operando1;
        end
     else
       begin
       prod:=arb^.hijos[1]^.lexema;
    If prod = '+' then
        begin
           evalA(arb^.hijos[2], estado, resultadoA);
           suma.R:= operando1.R + resultadoA.R;
           evalB(arb^.hijos[3], estado, suma, resultado);
        end;
     If prod = '-' then
        begin
           evalA(arb^.hijos[2], estado, resultadoA);
           resta.R:= operando1.R - resultadoA.R;
           evalB(arb^.hijos[3], estado, resta, resultado);
        end;
       end;
     end;

  procedure evalA(arb:Tarbol; estado:t_lista2; var resultado:TipoValor);
  var
    resultadoC:TipoValor;
    begin
       evalC(arb^.hijos[1], estado, resultadoC);
       evalD(arb^.hijos[2], estado, resultadoC, resultado);
    end;

 procedure evalD(arb:Tarbol; estado:t_lista2; operando1:TipoValor; var resultado:TipoValor);
 var
   resultadoC,por,divs:TipoValor;
  prod:string;
     begin
     por.tipo:=Treal;
     divs.tipo:=Treal;
   If (arb^.cant_hijos = 0) then
        begin
          resultado:= operando1;
        end
   else
     begin
     prod:=arb^.hijos[1]^.lexema;
    If prod = '*' then
        begin
           evalC(arb^.hijos[2], estado, resultadoC);
           por.R:= operando1.R * resultadoC.R;
           evalD(arb^.hijos[3], estado, por, resultado);
        end;
     If prod = '/' then
        begin
           evalC(arb^.hijos[2], estado, resultadoC);
           divs.R:= operando1.R / resultadoC.R;
           evalD(arb^.hijos[3], estado, divs, resultado);
        end;
     end;
  end;

procedure evalC(arb:Tarbol; estado:t_lista2; var resultado:TipoValor);
 var
   resultado1,resultado2,aux:TipoValor;
    prod:TsimbGramatical;
     begin
     aux.tipo:=Treal;
       prod:=arb^.hijos[1]^.simb;
       If prod= Troot then
          begin
            evalExpArit(arb^.hijos[3],estado,resultado1);
             aux.R:= sqrt(resultado1.R);
             evalE(arb^.hijos[5], estado, aux, resultado);
          end;
       If prod= VF then
           begin
              evalF(arb^.hijos[1], estado, resultado1);
              evalE(arb^.hijos[2], estado, resultado1, resultado);
           end;
    end;

  procedure evalE(arb:Tarbol; estado:t_lista2;operando1:TipoValor; var resultado:TipoValor);
   var
     operando2,aux:TipoValor;
      begin
        aux.tipo:=Treal;
        If  not (arb^.cant_hijos = 0) then
           begin
              evalF(arb^.hijos[2], estado, operando2);
              aux.R:= power(operando1.R,operando2.R);
              evalE(arb^.hijos[3], estado, aux, resultado);
           end
        else
         begin
           resultado:= operando1;
         end;
    end;

 procedure evalF(arb:Tarbol; estado:t_lista2; var resultado:TipoValor);
  var
    prod:TsimbGramatical;
    resultado1,resultado2:TipoValor;
     begin
       prod:=arb^.hijos[1]^.simb;
        If prod = Tidentificador  then
           begin
             obtenerValorId(arb^.hijos[1]^.lexema, estado, resultado);
           end;
        If prod = Tconst  then
           begin
               pasarEntero(arb^.hijos[1]^.Lexema, resultado);
           end;
        If prod = TparI  then
           begin
              evalExpArit(arb^.hijos[2], estado, resultado);
           end;
        If prod = Tmenos  then
           begin
              evalF(arb^.hijos[2], estado, resultado);
              resultado.R:= resultado.R*-1;
           end;
        If prod = Tcantidad  then
           begin
              obtenerValorId(arb^.hijos[3]^.lexema, estado, resultado1);
              resultado.R:= cantidadElementos(resultado1);
           end;
        If prod = Telemento  then
           begin
             evalExpArit(arb^.hijos[5], estado, resultado1);
            obtenerValorId(arb^.hijos[3]^.lexema, estado, resultado2);
            resultado.R:= obtenerElemento(resultado2.L,trunc(resultado1.R));
           end;
      end;

procedure agregarvariable(var estado:T_lista2;cadena:string;tipodevar:TSimbGramatical);
  begin
    If not(esta_en_lista(estado,cadena)) then           //definir luego
       begin
           agregar_lista(estado,cadena,tipodevar);
       end;
  end;

procedure agregar_lista (var estado:T_lista2;cadena:string; variable:TSimbGramatical);
  var
   Dir,ant:t_puntero2;
   E:TipoValor;
  begin
   E.R:=0;
   If variable=TListaReal then
   begin
   new(E.L);
   E.L^.cant:=0;
   end;
   E.tipo:=variable;
    new(Dir);
    Dir^.valor:=E;
    Dir^.variable:=cadena;
     If (estado.Cab=NIL) then
       begin
         Dir^.Sig:=estado.cab;
         estado.Cab:=Dir;
       end
     else
      begin
        Ant:=estado.Cab;
        estado.Act:=estado.Cab^.Sig;
         while (estado.Act<>NIL) do
          begin
            Ant:=estado.Act;
            estado.Act:=estado.Act^.Sig;
          end;
         Ant^.Sig:=Dir;
         Dir^.Sig:=estado.Act;
      end;
      inc(estado.tam);
  end;

 function esta_en_lista(var L:T_lista2; buscado:string):boolean;
 begin
   L.act:=L.cab;
   while (not fin2(L)) do
    begin
        if (upcase(L.act^.variable)=upcase(buscado)) then
          begin
           esta_en_lista:=true;
          end;
    siguiente2(L);
   end;
   esta_en_lista:=false;
 end;
procedure Siguiente2(var L:T_lista2);
  begin
   L.Act:=L.Act^.Sig;
  end;
function Fin2(L:T_lista2):boolean;
  begin
   Fin2:=L.Act=NIL;
  end;
 procedure asignarEstado(var L:T_lista2; variable:string; resultado:TipoValor);
  begin
   L.act:=L.cab;
   while (not fin2(L)) do
    begin
        if (upcase(L.act^.variable)=upcase(variable)) then
          begin
            L.act^.valor:= resultado;
          end;
    siguiente2(L);
   end;
  end;

 procedure agregarLista(var L:PunteroListaReal; resultado2:tipoValor);
  begin
    inc(L^.cant);
    L^.Elemento[L^.cant]:=resultado2.R;
  end;

 procedure obtenerValorId(variable:string; L:T_lista2; var resultado:TipoValor);
   begin
   L.act:=L.cab;
   while (not fin2(L)) do
    begin
        if (upcase(L.act^.variable)=upcase(variable)) then
          begin
            resultado:=L.act^.valor;
          end;
    siguiente2(L);
   end;
   //writeln('La variable no existe', variable);
   end;


 procedure pasarEntero(cadena:string; var resultado:TipoValor);
 var
  posicionerror:integer;
   begin
   val(cadena,resultado.R,posicionerror);
   resultado.tipo:=TReal;
 end;


 procedure crearLista(var resultado:TipoValor);
  begin
    //resultado.L^.Elemento:=;
    resultado.L^.cant:=0;
   end;

 function obtenerElemento(L:PunteroListaReal;pos:integer):real;
 begin
   obtenerElemento:=L^.Elemento[pos];
 end;

 function cantidadElementos(resultado1:TipoValor):integer;
  begin
  cantidadElementos:=resultado1.L^.cant;
  end;
Procedure IncializarLista2(var L:T_lista2);
begin
  L.tam:=0;
  L.act:=Nil;
  L.Cab:=Nil;
end;


 procedure EliminarElementoLista(var L:PunteroListaReal;resultado:TipoValor);
 var
  i:integer;
  begin
   i:=round(resultado.R);
     while  i<L^.Cant do
      begin
        L^.Elemento[i]:=L^.Elemento[i+1];
      end;
     dec(L^.Cant);
   end;

 procedure ReemplazarElemLista(var L:PunteroListaReal;Pos:TipoValor;Elemento:TipoValor);
 begin
    If L^.Cant >= Pos.R  then
      begin
         L^.Elemento[round(Pos.R)]:=Elemento.R;
      end;
 end;






















end.

