program Analizador_Lexico;
Uses crt;
var


begin
     Function EsCadena(Cadena:String): Boolean;
        Const
         q0=0;
         F=[0];
        Type
         Q=0..3;
         Sigma=(Comilla, Caracter, Otro);
         TipoDelta=Array[Q, Sigma] of Q;
         Var
          Control:Integer
          EstadoActual:Q;
          Delta:TipoDelta;
            Begin
              Delta[0,Comilla]:=1;
              Delta[0,Caracter]:=3;
              Delta[0,Otro]:=3;
              Delta[1,Comilla]:=2;
              Delta[1,Caracter]:=1;
              Delta[1,Otro]:=3;
              Delta[2,Comilla]:=3;
              Delta[2,Caracter]:=3;
              Delta[2,Otro]:=3;
              Delta[3,Comilla]:=3;
              Delta[3,Caracter]:=3;
              Delta[3,otro]:=3;
              EstadoActual:=q0;
                For Control:=1 to Length(Cadena) do
                  EstadoActual:=Delta[EstadoActual, CarASimb(Cadena[Control])];
                  EsCadena:=EstadoActual in F;
            end;

    Function CarASimb(car:Char):Sigma;
       Begin
         Case Car of
           'a'..'Z', 'A'..'Z': CarASimb:=Caracter;
           '0'..'9': CarSimb:=Caracter;
           '"': CarASimb:=Comillas;
         else
          CarASimb:=Otro;
       end;



  Function EsConstanteEntera(Cadena:String): Boolean;
        Const
         q0=0;
         F=[0];
        Type
         Q=0..3;
         Sigma=(Signo, Digito, Otro);
         TipoDelta=Array[Q, Sigma] of Q;
         Var
          Control:Integer
          EstadoActual:Q;
          Delta:TipoDelta;
            Begin
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

              EstadoActual:=q0;
                For Control:=1 to Length(Cadena) do
                  EstadoActual:=Delta[EstadoActual, CarASimb01(Cadena[Control])];
                  EsCadena:=EstadoActual in F;
            end;

    Function CarASimb01(car:Char):Sigma;
       Begin
         Case Car of
           '+','-','*','/','^','root': CarASimb01:=Signo;
           '0'..'9': CarSimb01:=Digito;
         else
          CarASimb:=Otro;
       end;

         Function EsOperadorRelacional(Cadena:String): Boolean;
                 Const
                  q0=0;
                  F=[0];
                 Type
                  Q=0..4;
                  Sigma=(Mayor, Menor,Igual, Otro);
                  TipoDelta=Array[Q, Sigma] of Q;
                  Var
                   Control:Integer
                   EstadoActual:Q;
                   Delta:TipoDelta;
                     Begin
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
                       Delta[4,Mayor]:=5;
                       Delta[4,Menor]:=5;
                       Delta[4,Igual]:=2;
                       Delta[4,Otro]:=5;
                       Delta[5,Mayor]:=5;
                       Delta[5,Menor]:=5;
                       Delta[5,Igual]:=5;
                       Delta[5,Otro]:=5;
                       EstadoActual:=q0;
                         For Control:=1 to Length(Cadena) do
                           EstadoActual:=Delta[EstadoActual, CarASimb02(Cadena[Control])];
                           EsCadena:=EstadoActual in F;
                     end;

             Function CarASimb02(car:Char):Sigma;
                Begin
                  Case Car of
                    '<': CarASimb02:=Mayor;
                    '>': CarSimb02:=Menor;
                    '=': CarSimb02:=Igual;
                  else
                   CarASimb:=Otro;
                end;

 Function EsConstanteReal(Cadena:String): Boolean;
                 Const
                  q0=0;
                  F=[0];
                 Type
                  Q=0..5;
                  Sigma=(Exponente, digito,Signo, Punto, Otro);
                  TipoDelta=Array[Q, Sigma] of Q;
                  Var
                   Control:Integer
                   EstadoActual:Q;
                   Delta:TipoDelta;
                     Begin
                       Delta[0,Exponente]:=1;
                       Delta[0,Digito]:=2;
                       Delta[0,Signo]:=3;
                       Delta[0,Punto]:=4;
                       Delta[0,Otro]:=5;
                       EstadoActual:=q0;
                         For Control:=1 to Length(Cadena) do
                           EstadoActual:=Delta[EstadoActual, CarASimb03(Cadena[Control])];
                           EsCadena:=EstadoActual in F;
                     end;

             Function CarASimb03(car:Char):Sigma;
                Begin
                  Case Car of
                    '^': CarASimb02:=Exponente;
                    '0'..'9': CarSimb02:=Digito;
                    '+','-','*','/','^','root': CarSimb02:=Signo;
                    '.': CarSimb02:=Punto;
                  else
                   CarASimb:=Otro;
                end;

end.

