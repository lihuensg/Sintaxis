unit Identificadores;

{$mode objfpc}{$H+}


interface

uses
  Classes, SysUtils, Archivo, TabSimb_Aplicacion, TabSimb;
type
  TComplex=(Identificador1,ConstanteEntera,ConstanteReal,OperadorRelacional);

Function EsIdentificador(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
Function EsConstanteEntera(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
Function EsConstanteReal(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
Function EsOperadorRelacional(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
Function EsOpArit(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
Function EsCadena(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
Procedure ObtenerSiguienteCompLex(Var Fuente:t_arch;Var Control:Longint; Var CompLex:TSimbGramatical;Var Lexema:String;var TS:T_lista);
Function EsSimbGramatical(var Fuente:t_arch;var Control:Longint;var Lexema:string; var CompLex:TSimbGramatical):boolean;

implementation

Function EsIdentificador(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
  Const
    q0=0;
    F=[3];
  Type
    Q=0..3;
    Sigma=(Letra, Digito, Otro);
    TDelta=Array[Q,Sigma] of Q;
  Var
    EstadoActual:Q;
    Delta:TDelta;
    caracter:char;
    nuevo_control:integer;

  Function CarASimb(Car:Char):Sigma;
Begin
  Case Car of
    'a'..'z', 'A'..'Z':CarASimb:=Letra;
    '0'..'9'	     :CarASimb:=Digito;
     //'$',':',';',',','{','}','(',')','[',']','=','+','-','/','*','^':CarASimb:=Especial;
  else
   CarASimb:=Otro
  End;
End;

  begin
    Lexema:='';
    nuevo_control:=control;
    //Cargar Tabla;
    Delta[0,Letra]:=1;
    Delta[0,Digito]:=2;
    //Delta[0,Especial]:=2;
    Delta[0,Otro]:=2;
    Delta[1,Letra]:=1;
    Delta[1,Digito]:=1;
    //Delta[1,Especial]:=1;
    Delta[1,Otro]:=3;
    //Delta[2,Letra]:=2;
    //Delta[2,Digito]:=2;
    //Delta[2,Especial]:=2;
    //Delta[2,Otro]:=2;
    //Recorrer la cadena
    EstadoActual:=q0;
    while not (EstadoActual in [2,3]) do      //el estado 3 se establece para reconocer que el identificador que se esta leyendo ya no pertenece a la cadena que se esta evaluando
      begin
        leercaracter(fuente, nuevo_control,caracter);
        EstadoActual:=Delta[EstadoActual,CarASimb(caracter)];
        if EstadoActual=1 then
        begin
        Lexema:=Lexema+caracter;
        end;
        inc(nuevo_control);       //usar variable auxiliar para luego asignarla si lo reconoce
      end;
    if (EstadoActual in F) then
    control:=nuevo_control-1;
    EsIdentificador:=EstadoActual in F;
  end;

Function EsConstanteEntera(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
  Const
    q0=0;
    F=[2];
  Type
    Q=0..3;
    Sigma=(Signo, Digito, Otro);
    TDelta=Array[Q,Sigma] of Q;
  Var
    EstadoActual:Q;
    Delta:TDelta;
    caracter:char;
    nuevo_control:integer;
    nuevo_lexema:string;
    aux:Q;                  //el 'aux' sirve para guardar el ultimo estado "EstadoActual" valido

Function CarASimb(Car:Char):Sigma;
  Begin
    Case Car of
      '+','-':CarASimb:=Signo;
      '0'..'9'	     :CarASimb:=Digito;
    else
     CarASimb:=Otro
    End;
  End;

  begin
    nuevo_lexema:='';
    nuevo_control:=control;
    //Cargar Tabla;
    Delta[0,Signo]:=1;
    Delta[0,Digito]:=2;
    Delta[0,Otro]:=3;
    Delta[1,Signo]:=3;
    Delta[1,Digito]:=2;
    Delta[1,Otro]:=3;
    Delta[2,Signo]:=3;
    Delta[2,Digito]:=2;
    Delta[2,Otro]:=3;
    Delta[3,Signo]:=3;
    Delta[3,Digito]:=3;
    Delta[3,Otro]:=3;
    //Recorrer la cadena
    EstadoActual:=q0;
    while not (EstadoActual in [3]) do
      begin
        leercaracter(fuente, nuevo_control,caracter);
        EstadoActual:=Delta[EstadoActual,CarASimb(caracter)];
        if EstadoActual in F then
        begin
        nuevo_lexema:=nuevo_lexema+caracter;
        aux:=EstadoActual;
        end;
        inc(nuevo_control);     //usar variable auxiliar para luego asignarla si lo reconoce
      end;
    if aux in F then
      begin
        control:=nuevo_control-1;
        Lexema:=nuevo_lexema;
      end;
    EsConstanteEntera:=aux in F;
  end;

Function EsConstanteReal(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
  Const
    q0=0;
    F=[8];
  Type
    Q=0..9;
    Sigma=(Exponente,Signo, Digito, Punto, Otro);
    TDelta=Array[Q,Sigma] of Q;
  Var
    EstadoActual:Q;
    Delta:TDelta;
    caracter:char;
    nuevo_control:integer;
    nuevo_lexema:string;

Function CarASimb(Car:Char):Sigma;
  Begin
    Case Car of
      'a'..'z', 'A'..'Z','-','+','*','/':CarASimb:=Signo;
      '^':CarASimb:=Exponente;
      '0'..'9':CarASimb:=Digito;
      '.' :CarASimb:=Punto;
    else
     CarASimb:=Otro
    End;
  End;

  begin
    nuevo_lexema:='';
    nuevo_control:=control;
    //Cargar Tabla;
    Delta[0,Exponente]:=7;
    Delta[0,Digito]:=2;
    Delta[0,Signo]:=1;
    Delta[0,Punto]:=7;
    Delta[0,Otro]:=9;
    Delta[1,Exponente]:=7;
    Delta[1,Digito]:=2;
    Delta[1,Signo]:=7;
    Delta[1,Punto]:=7;
    Delta[1,Otro]:=9;
    Delta[2,Exponente]:=5;
    Delta[2,Digito]:=2;
    Delta[2,Signo]:=7;
    Delta[2,Punto]:=3;
    Delta[2,Otro]:=9;
    Delta[3,Exponente]:=5;
    Delta[3,Digito]:=4;
    Delta[3,Signo]:=7;
    Delta[3,Punto]:=7;
    Delta[3,Otro]:=9;
    Delta[4,Exponente]:=5;
    Delta[4,Digito]:=4;
    Delta[4,Signo]:=7;
    Delta[4,Punto]:=7;
    Delta[4,Otro]:=9;
    Delta[5,Exponente]:=7;
    Delta[5,Digito]:=8;
    Delta[5,Signo]:=7;
    Delta[5,Punto]:=7;
    Delta[5,Otro]:=9;
    Delta[6,Exponente]:=7;
    Delta[6,Digito]:=8;
    Delta[6,Signo]:=7;
    Delta[6,Punto]:=7;
    Delta[6,Otro]:=9;
    Delta[7,Exponente]:=7;
    Delta[7,Digito]:=7;
    Delta[7,Signo]:=7;
    Delta[7,Punto]:=7;
    Delta[7,Otro]:=9;
    Delta[8,Exponente]:=7;
    Delta[8,Digito]:=8;
    Delta[8,Signo]:=7;
    Delta[8,Punto]:=7;
    Delta[8,Otro]:=9;
    //Recorrer la cadena
    EstadoActual:=q0;
    while not (EstadoActual in [7,9]) do
      begin
        leercaracter(fuente, nuevo_control,caracter);
        EstadoActual:=Delta[EstadoActual,CarASimb(caracter)];
        if (EstadoActual=1) or (EstadoActual=2) or (EstadoActual=3) or (EstadoActual=4) or (EstadoActual=5) or (EstadoActual=6) then
        begin
        nuevo_lexema:=nuevo_lexema+caracter;
        end;
        inc(nuevo_control);     //usar variable auxiliar para luego asignarla si lo reconoce
      end;
    if EstadoActual in F then
      begin
        control:=nuevo_control-1;
        Lexema:=nuevo_lexema;
        EsConstanteReal:=EstadoActual in F;
      end;
  end;

Function EsOperadorRelacional(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
  Const
    q0=0;
    F=[1,2,4];
  Type
    Q=0..5;
    Sigma=(Menor, Mayor, Distinto, Igual, Otro);
    TDelta=Array[Q,Sigma] of Q;
  Var
    EstadoActual:Q;
    Delta:TDelta;
    caracter1:char;
    nuevo_control:integer;
    pos:integer;
    aux:Q;

Function CarASimb(Car1:Char):Sigma;
  Begin
    //if (car1='<') and (car2='>') then
     //CarASimb:=Distinto
    //else
      //if (car1='<') and (car2='=') then
       //CarASimb:=MenorIgual
    //else
      //if (car1='>') and (car2='=') then
       //CarASimb:=MayorIgual;
    Case Car1 of
      '<':CarASimb:=Menor;
      '>':CarASimb:=Mayor;
      '=' :CarASimb:=Igual;
    else
     CarASimb:=Otro
    End;
  End;

  begin
    //nuevo_lexema:='';
    nuevo_control:=control;
    //Cargar Tabla;
    Delta[0,Mayor]:=1;
    Delta[0,Menor]:=4;
    Delta[0,Igual]:=3;
    Delta[0,Otro]:=5;
    Delta[1,Mayor]:=5;
    Delta[1,Menor]:=2;
    Delta[1,Igual]:=2;
    Delta[1,Otro]:=5;
    Delta[2,Mayor]:=5;
    Delta[2,Menor]:=5;
    Delta[2,Igual]:=5;
    Delta[2,Otro]:=5;
    Delta[3,Mayor]:=5;
    Delta[3,Menor]:=5;
    Delta[3,Igual]:=2;
    Delta[3,Otro]:=5;
    Delta[4,Mayor]:=2;
    Delta[4,Menor]:=5;
    Delta[4,Igual]:=2;
    Delta[4,Otro]:=5;
    Delta[5,Mayor]:=5;
    Delta[5,Menor]:=5;
    Delta[5,Igual]:=5;
    Delta[5,Otro]:=5;
    //Recorrer la cadena
    EstadoActual:=q0;
    while not (EstadoActual in [5]) do
     begin
        leercaracter(Fuente,nuevo_control,caracter1);
        EstadoActual:=Delta[EstadoActual,CarASimb(caracter1)];
        if EstadoActual in F then
        begin
        Lexema:=Lexema+caracter1;
        aux:=EstadoActual;
        end;
        inc(nuevo_control);     //usar variable auxiliar para luego asignarla si lo reconoce
      end;
    if aux in F then
      begin
        control:=nuevo_control-1;
      end;
    EsOperadorRelacional:=aux in F;
  end;

Function EsOpArit(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
  Const
    q0=0;
    F=[3];
  Type
    Q=0..4;
    Sigma=(Mas, Menos, Por, Dividido, Otro);
    TDelta=Array[Q,Sigma] of Q;
  Var
    EstadoActual:Q;
    Delta:TDelta;
    caracter:char;
    nuevo_control:integer;

  Function CarASimb(Car:Char):Sigma;
Begin
  Case Car of
    '+':CarASimb:=Mas;
    '-':CarASimb:=Menos;
    '*':CarASimb:=Por;
    '/':CarASimb:=Dividido;
  else
   CarASimb:=Otro
  End;
End;

  begin
    Lexema:='';
    nuevo_control:=control;
    //Cargar Tabla;
    Delta[0,Mas]:=1;
    Delta[0,Menos]:=1;
    Delta[0,Por]:=1;
    Delta[0,Dividido]:=1;
    Delta[0,Otro]:=2;
    Delta[1,Mas]:=3;
    Delta[1,Menos]:=3;
    Delta[1,Por]:=3;
    Delta[1,Dividido]:=3;
    Delta[1,Otro]:=4;
    Delta[2,Mas]:=2;
    Delta[2,Menos]:=2;
    Delta[2,Por]:=2;
    Delta[2,Dividido]:=2;
    Delta[2,Otro]:=4;
    Delta[3,Mas]:=3;
    Delta[3,Menos]:=3;
    Delta[3,Por]:=3;
    Delta[3,Dividido]:=3;
    Delta[3,Otro]:=4;
    //Recorrer la cadena
    EstadoActual:=q0;
    while not (EstadoActual in [2,4]) do
      begin
        leercaracter(Fuente,nuevo_control,caracter);
        EstadoActual:=Delta[EstadoActual,CarASimb(caracter)];
        if EstadoActual=1 then
        begin
        Lexema:=Lexema+caracter;
        end;
        inc(nuevo_control);     //usar variable auxiliar para luego asignarla si lo reconoce
      end;
    if (EstadoActual in F) then
    control:=nuevo_control-1;
    EsOpArit:=EstadoActual in F;
  end;

Function EsCadena(var Fuente:t_arch;var Control:Longint;var Lexema:string): Boolean;
  Const
    q0=0;
    F=[2];
  Type
    Q=0..4;
    Sigma=(Comilla,Caracter, Otro);
    TDelta=Array[Q,Sigma] of Q;
  Var
    EstadoActual:Q;
    Delta:TDelta;
    carac:char;
    nuevo_control:integer;
    aux:Q;

  Function CarASimb(Car:Char):Sigma;
Begin
  if Car='"' then
    CarASimb:=Comilla
  else
   CarASimb:=Caracter;
  End;

  begin
    Lexema:='';
    nuevo_control:=control;
    //Cargar Tabla;
    Delta[0,Comilla]:=1;
    Delta[0,Caracter]:=3;
    Delta[0,Otro]:=3;
    Delta[1,Comilla]:=2;
    Delta[1,Caracter]:=1;
    Delta[1,Otro]:=4;
    Delta[2,Comilla]:=3;
    Delta[2,Caracter]:=3;
    Delta[2,Otro]:=4;
    Delta[3,Comilla]:=3;
    Delta[3,Caracter]:=3;
    Delta[3,otro]:=4;
    //Recorrer la cadena
    EstadoActual:=q0;
    while not (EstadoActual in [3,4]) do
      begin
        leercaracter(Fuente,nuevo_control,carac);
        EstadoActual:=Delta[EstadoActual,CarASimb(carac)];
        if (EstadoActual=1) or (EstadoActual=2) then
        begin
        Lexema:=Lexema+carac;
        aux:=EstadoActual;
        end;
        inc(nuevo_control);     //usar variable auxiliar para luego asignarla si lo reconoce
      end;
    if aux in F then
    begin
       control:=nuevo_control-1;
    end;
    EsCadena:=aux in F;
  end;


//es simbolo gramatical, hacer funcion
Function EsSimbGramatical(var Fuente:t_arch;var Control:Longint;var Lexema:string; var CompLex:TSimbGramatical):boolean;
var
  carac:char;
  begin
   leercaracter(Fuente,control,carac);
   case carac of
     '+':
       begin
        CompLex:= Tmas;
        Lexema:= '+';
        EsSimbGramatical:=True;
        inc(Control);
       end;
     '-':
       begin
        CompLex:= Tmenos;
        Lexema:= '-';
        EsSimbGramatical:=True;
        inc(Control);
       end;
     '*':
       begin
        CompLex:= Tpor;
        Lexema:= '*';
        EsSimbGramatical:=True;
        inc(Control);
       end;
     '/':
       begin
        CompLex:= Tdiv;
        Lexema:= '/';
        EsSimbGramatical:=True;
        inc(Control);
       end;
     '^':
       begin
        CompLex:= Telev;
        Lexema:= '^';
        EsSimbGramatical:=True;
        inc(Control);
       end;
      '=':
       begin
        CompLex:= TIgual;
        Lexema:= '=';
        EsSimbGramatical:=True;
        inc(Control);
       end;
     '(':
       begin
        CompLex:= TParI;
        Lexema:= '(';
        EsSimbGramatical:=True;
        inc(Control);
       end;
     ')':
       begin
        CompLex:= TParD;
        Lexema:= ')';
        EsSimbGramatical:=True;
        inc(Control);
       end;
     ',':
       begin
        CompLex:= TComa;
        Lexema:= ',';
        EsSimbGramatical:=True;
        inc(Control);
       end;
     ';':
       begin
        CompLex:= TPuntoyComa;
        Lexema:= ';';
        EsSimbGramatical:=True;
        inc(Control);
       end;
     ':':
       begin
        CompLex:= Tdospuntos;
        Lexema:= ':';
        EsSimbGramatical:=True;
        inc(Control);
       end;
      '{':
       begin
        CompLex:= TllaveI;
        Lexema:= '{';
       EsSimbGramatical:=True;
        inc(Control);
       end;
      '}':
       begin
        CompLex:= TllaveD;
        Lexema:= '}';
        EsSimbGramatical:=True;
        inc(Control);
       end;
      '[':
       begin
        CompLex:= TCorchI;
        Lexema:= '[';
        EsSimbGramatical:=True;
        inc(Control);
       end;
      ']':
       begin
        CompLex:= TCorchD;
        Lexema:= ']';
        EsSimbGramatical:=True;
        inc(Control);
       end;
   else
    begin
     CompLex:=ErrorLexico;
     EsSimbGramatical:=False;
    end;
  end;
  end;


Procedure ObtenerSiguienteCompLex(Var Fuente:t_arch;Var Control:Longint; Var CompLex:TSimbGramatical;Var Lexema:String;var TS:T_lista);
 var
   carac:char;
   //CompLex01:string;
begin
    leercaracter(Fuente,control,carac);
    while carac in [#1..#32] do                //saltea todos los cacateres de control
      begin
        inc(control);
        leercaracter(Fuente,control,carac);
      end;
    If carac=finarch then CompLex:=pesos
    else
     begin
      If EsIdentificador(Fuente,Control,Lexema) then
                  begin
                  CompLex:=TIdentificador;
                  //CompLex01:='Identificador';
                  InstalarEnTS(Lexema,TS,CompLex)
                  end
    else If EsConstanteReal(Fuente,Control,Lexema) then
		  begin
                  CompLex:=TConstReal;
                  //CompLex01:='ConstReal';
                  InstalarEnTS(Lexema,TS,CompLex)
                  end
    else If EsConstanteEntera(Fuente,Control,Lexema) then
		  begin
                  CompLex:=TConstEntera;
                  //CompLex01:='ConstEntera';
                  InstalarEnTS(Lexema,TS,CompLex)
                  end
    else if EsOperadorRelacional(Fuente,Control,Lexema) then
                  begin
                  CompLex:=TOpRel;
                  //CompLex01:='OpRel';
                  InstalarEnTS(Lexema,TS,CompLex)
                  end
    else if EsOpArit(Fuente,Control,Lexema) then
                  begin
                  CompLex:=TOpArit;
                  //CompLex01:='OpArit';
                  InstalarEnTS(Lexema,TS,CompLex)
                  end
    else if EsSimbGramatical(Fuente,Control,Lexema,CompLex) then
                  begin
                  //CompLex:=TEsSimbGramatical;
                  //CompLex01:='Cadena';
                  InstalarEnTS(Lexema,TS,CompLex)
                  end
    else if EsCadena(Fuente,Control,Lexema) then
                  begin
                  CompLex:=TCadena;
                  //CompLex01:='Cadena';
                  InstalarEnTS(Lexema,TS,CompLex)
                  end
    else if Not EsCadena(Fuente,Control,Lexema) then
                  begin
                  CompLex:=ErrorLexico;
                  //CompLex01:='ErrorLexico';
                  end;
     end;
end;

end.
