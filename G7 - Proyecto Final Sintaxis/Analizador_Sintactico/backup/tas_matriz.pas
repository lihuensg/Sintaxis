unit TAS_Matriz;

{$mode objfpc}{$H+}

interface

uses
 Matriz,TabSimb;

Var
  TAS:TTAS;
procedure Inicializar_TAS(var TAS: TTAS);
procedure Cargar_TAS(var TAS:TTAS);
//Function EsTerminal(X:TSimbGramatical):boolean;
//Function EsVariable(X:TSimbGramatical):boolean;
Function EsVariable(var X:TSimbGramatical):boolean;

implementation

procedure Inicializar_TAS(var TAS: TTAS);
var
  Y,X:TSimbGramatical;
 begin
  For Y:= VPrograma to VF do
     For X:= TConstEntera to pesos do
         TAS[Y,X]:= Nil;
 end;

procedure Cargar_TAS(var TAS:TTAS);
Begin
   new(TAS[VPrograma,Tvar]);
   TAS[Vprograma,Tvar]^.elementos[1]:=Tvar;
   TAS[Vprograma,Tvar]^.elementos[2]:=Vvariables;
   TAS[Vprograma,Tvar]^.elementos[3]:=TllaveI;
   TAS[Vprograma,Tvar]^.elementos[4]:=VCuerpo;
   TAS[Vprograma,Tvar]^.elementos[5]:=TllaveD;
   TAS[Vprograma,Tvar]^.cant:=5;

   new(TAS[Vvariables,TIdentificador]);
   TAS[Vvariables,TIdentificador]^.elementos[1]:=TIdentificador;
   TAS[Vvariables,TIdentificador]^.elementos[2]:=Tdospuntos;
   TAS[Vvariables,TIdentificador]^.elementos[3]:=VTipo;
   TAS[Vvariables,TIdentificador]^.elementos[4]:=VidVar;
   TAS[Vvariables,TIdentificador]^.cant:=4;

   new(TAS[VidVar,TComa]);
   TAS[VidVar,TComa]^.elementos[1]:=TComa;
   TAS[VidVar,TComa]^.elementos[2]:=TIdentificador;
   TAS[VidVar,TComa]^.elementos[3]:=Tdospuntos;
   TAS[VidVar,TComa]^.elementos[4]:=VTipo;
   TAS[VidVar,TComa]^.elementos[5]:=VidVar;
   TAS[VidVar,TComa]^.cant:=5;

   new(TAS[VidVar,TllaveI]);
   TAS[VidVar,TllaveI]^.cant:=0;

   new(TAS[VTipo,TReal]);
   TAS[VTipo,TReal]^.elementos[1]:=TReal;
   TAS[VTipo,TReal]^.cant:=1;

   new(TAS[VTipo,TlistaReal]);
   TAS[VTipo,TlistaReal]^.elementos[1]:=TlistaReal;
   TAS[VTipo,TlistaReal]^.cant:=1;

   new(TAS[VCuerpo,TIdentificador]);
   TAS[VCuerpo,TIdentificador]^.elementos[1]:=VSent;
   TAS[VCuerpo,TIdentificador]^.elementos[2]:=TPuntoyComa;
   TAS[VCuerpo,TIdentificador]^.elementos[3]:=VCuerpo;
   TAS[VCuerpo,TIdentificador]^.cant:=3;

   new(TAS[VCuerpo,TLeer]);
   TAS[VCuerpo,TLeer]^.elementos[1]:=VSent;
   TAS[VCuerpo,TLeer]^.elementos[2]:=TPuntoyComa;
   TAS[VCuerpo,TLeer]^.elementos[3]:=VCuerpo;
   TAS[VCuerpo,TLeer]^.cant:=3;

   new(TAS[VCuerpo,TEscribir]);
   TAS[VCuerpo,TEscribir]^.elementos[1]:=VSent;
   TAS[VCuerpo,TEscribir]^.elementos[2]:=TPuntoyComa;
   TAS[VCuerpo,TEscribir]^.elementos[3]:=VCuerpo;
   TAS[VCuerpo,TEscribir]^.cant:=3;

   new(TAS[VCuerpo,TMientras]);
   TAS[VCuerpo,TMientras]^.elementos[1]:=VSent;
   TAS[VCuerpo,TMientras]^.elementos[2]:=TPuntoyComa;
   TAS[VCuerpo,TMientras]^.elementos[3]:=VCuerpo;
   TAS[VCuerpo,TMientras]^.cant:=3;

   new(TAS[VCuerpo,TSi]);
   TAS[VCuerpo,TSi]^.elementos[1]:=VSent;
   TAS[VCuerpo,TSi]^.elementos[2]:=TPuntoyComa;
   TAS[VCuerpo,TSi]^.elementos[3]:=VCuerpo;
   TAS[VCuerpo,TSi]^.cant:=3;

   new(TAS[VCuerpo,TAgregar]);
   TAS[VCuerpo,TAgregar]^.elementos[1]:=VSent;
   TAS[VCuerpo,TAgregar]^.elementos[2]:=TPuntoyComa;
   TAS[VCuerpo,TAgregar]^.elementos[3]:=VCuerpo;
   TAS[VCuerpo,TAgregar]^.cant:=3;

   new(TAS[VCuerpo,TEliminar]);
   TAS[VCuerpo,TEliminar]^.elementos[1]:=VSent;
   TAS[VCuerpo,TEliminar]^.elementos[2]:=TPuntoyComa;
   TAS[VCuerpo,TEliminar]^.elementos[3]:=VCuerpo;
   TAS[VCuerpo,TEliminar]^.cant:=3;

   new(TAS[VCuerpo,TReemplazar]);
   TAS[VCuerpo,TReemplazar]^.elementos[1]:=VSent;
   TAS[VCuerpo,TReemplazar]^.elementos[2]:=TPuntoyComa;
   TAS[VCuerpo,TReemplazar]^.elementos[3]:=VCuerpo;
   TAS[VCuerpo,TReemplazar]^.cant:=3;

   new(TAS[VCuerpo,TllaveD]);
   TAS[VCuerpo,TllaveD]^.cant:=0;

   new(TAS[VSent,TIdentificador]);
   TAS[VSent,TIdentificador]^.elementos[1]:=TIdentificador;
   TAS[VSent,TIdentificador]^.elementos[2]:=TIgual;
   TAS[VSent,TIdentificador]^.elementos[3]:=VU;
   TAS[VSent,TIdentificador]^.cant:=3;

   new(TAS[VSent,TLeer]);
   TAS[VSent,TLeer]^.elementos[1]:=TLeer;
   TAS[VSent,TLeer]^.elementos[2]:=TParI;
   TAS[VSent,TLeer]^.elementos[3]:=TCadena;
   TAS[VSent,TLeer]^.elementos[4]:=TComa;
   TAS[VSent,TLeer]^.elementos[5]:=TIdentificador;
   TAS[VSent,TLeer]^.elementos[6]:=TParD;
   TAS[VSent,TLeer]^.cant:=6;

   new(TAS[VSent,TEscribir]);
   TAS[VSent,TEscribir]^.elementos[1]:=TEscribir;
   TAS[VSent,TEscribir]^.elementos[2]:=TParI;
   TAS[VSent,TEscribir]^.elementos[3]:=TCadena;
   TAS[VSent,TEscribir]^.elementos[4]:=TComa;
   TAS[VSent,TEscribir]^.elementos[5]:=VExpArit;
   TAS[VSent,TEscribir]^.elementos[6]:=TParD;
   TAS[VSent,TEscribir]^.cant:=6;

   new(TAS[VSent,TMientras]);
   TAS[VSent,TMientras]^.elementos[1]:=TMientras;
   TAS[VSent,TMientras]^.elementos[2]:=VCondiciones;
   TAS[VSent,TMientras]^.elementos[3]:=TllaveI;
   TAS[VSent,TMientras]^.elementos[4]:=VCuerpo;
   TAS[VSent,TMientras]^.elementos[5]:=TllaveD;
   TAS[VSent,TMientras]^.cant:=5;

   new(TAS[VSent,TSi]);
   TAS[VSent,TSi]^.elementos[1]:=TSi;
   TAS[VSent,TSi]^.elementos[2]:=VCondiciones;
   TAS[VSent,TSi]^.elementos[3]:=TllaveI;
   TAS[VSent,TSi]^.elementos[4]:=VCuerpo;
   TAS[VSent,TSi]^.elementos[5]:=TllaveD;
   TAS[VSent,TSi]^.elementos[6]:=VSino;
   TAS[VSent,TSi]^.cant:=6;

   new(TAS[VSent,TAgregar]);
   TAS[VSent,TAgregar]^.elementos[1]:=TAgregar;
   TAS[VSent,TAgregar]^.elementos[2]:=TParI;
   TAS[VSent,TAgregar]^.elementos[3]:=TIdentificador;
   TAS[VSent,TAgregar]^.elementos[4]:=TComa;
   TAS[VSent,TAgregar]^.elementos[5]:=VExpArit;
   TAS[VSent,TAgregar]^.elementos[6]:=TParD;
   TAS[VSent,TAgregar]^.cant:=6;

   new(TAS[VSent,TEliminar]);
   TAS[VSent,TEliminar]^.elementos[1]:=TEliminar;
   TAS[VSent,TEliminar]^.elementos[2]:=TParI;
   TAS[VSent,TEliminar]^.elementos[3]:=TIdentificador;
   TAS[VSent,TEliminar]^.elementos[4]:=TComa;
   TAS[VSent,TEliminar]^.elementos[5]:=VExpArit;
   TAS[VSent,TEliminar]^.elementos[6]:=TParD;
   TAS[VSent,TEliminar]^.cant:=6;

   new(TAS[VSent,TReemplazar]);
   TAS[VSent,TReemplazar]^.elementos[1]:=TReemplazar;
   TAS[VSent,TReemplazar]^.elementos[2]:=TParI;
   TAS[VSent,TReemplazar]^.elementos[3]:=Tid;
   TAS[VSent,TReemplazar]^.elementos[4]:=TComa;
   TAS[VSent,TReemplazar]^.elementos[5]:=VExpArit;
   TAS[VSent,TReemplazar]^.elementos[6]:=TComa;
   TAS[VSent,TReemplazar]^.elementos[7]:=VExpArit;
   TAS[VSent,TReemplazar]^.elementos[8]:=TParD;
   TAS[VSent,TReemplazar]^.cant:=8;

   new(TAS[VU,Troot]);
   TAS[VU,Troot]^.elementos[1]:=VExpArit;
   TAS[VU,Troot]^.cant:=1;

   new(TAS[VU,TIdentificador]);
   TAS[VU,TIdentificador]^.elementos[1]:=VExpArit;
   TAS[VU,TIdentificador]^.cant:=1;

   new(TAS[VU,Tconst]);
   TAS[VU,Tconst]^.elementos[1]:=VExpArit;
   TAS[VU,Tconst]^.cant:=1;

   new(TAS[VU,TParI]);
   TAS[VU,TParI]^.elementos[1]:=VExpArit;
   TAS[VU,TParI]^.cant:=1;

   new(TAS[VU,Tmenos]);
   TAS[VU,Tmenos]^.elementos[1]:=VExpArit;
   TAS[VU,Tmenos]^.cant:=1;

   new(TAS[VU,TCantidad]);
   TAS[VU,TCantidad]^.elementos[1]:=VExpArit;
   TAS[VU,TCantidad]^.cant:=1;

   new(TAS[VU,Telemento]);
   TAS[VU,Telemento]^.elementos[1]:=VExpArit;
   TAS[VU,Telemento]^.cant:=1;

   new(TAS[VU,TCorchI]);
   TAS[VU,TCorchI]^.elementos[1]:=TCorchI;
   TAS[VU,TCorchI]^.elementos[2]:=VL;
   TAS[VU,TCorchI]^.elementos[3]:=TCorchD;
   TAS[VU,TCorchI]^.cant:=3;

   new(TAS[VL,Troot]);
   TAS[VL,Troot]^.elementos[1]:=VExpArit;
   TAS[VL,Troot]^.elementos[2]:=VT;
   TAS[VL,Troot]^.cant:=2;

   new(TAS[VL,TIdentificador]);
   TAS[VL,TIdentificador]^.elementos[1]:=VExpArit;
   TAS[VL,TIdentificador]^.elementos[2]:=VT;
   TAS[VL,TIdentificador]^.cant:=2;

   new(TAS[VL,Tconst]);
   TAS[VL,Tconst]^.elementos[1]:=VExpArit;
   TAS[VL,Tconst]^.elementos[2]:=VT;
   TAS[VL,Tconst]^.cant:=2;

   new(TAS[VL,TParI]);
   TAS[VL,TParI]^.elementos[1]:=VExpArit;
   TAS[VL,TParI]^.elementos[2]:=VT;
   TAS[VL,TParI]^.cant:=2;

   new(TAS[VL,TCantidad]);
   TAS[VL,TCantidad]^.elementos[1]:=VExpArit;
   TAS[VL,TCantidad]^.elementos[2]:=VT;
   TAS[VL,TCantidad]^.cant:=2;

   new(TAS[VL,Telemento]);
   TAS[VL,Telemento]^.elementos[1]:=VExpArit;
   TAS[VL,Telemento]^.elementos[2]:=VT;
   TAS[VL,Telemento]^.cant:=2;

   new(TAS[VL,TCorchD]);
   TAS[VL,TCorchD]^.cant:=0;

   new(TAS[VT,TComa]);
   TAS[VT,TComa]^.elementos[1]:=TComa;
   TAS[VT,TComa]^.elementos[2]:=VExpArit;
   TAS[VT,TComa]^.elementos[3]:=VT;
   TAS[VT,TComa]^.cant:=3;

   new(TAS[VT,TCorchD]);
   TAS[VT,TCorchD]^.cant:=0;

   new(TAS[VCondiciones,Tnot]);
   TAS[VCondiciones,Tnot]^.elementos[1]:=VCond;
   TAS[VCondiciones,Tnot]^.elementos[2]:=VZ;
   TAS[VCondiciones,Tnot]^.elementos[3]:=VW;
   TAS[VCondiciones,Tnot]^.cant:=3;

   new(TAS[VCondiciones,TCorchI]);
   TAS[VCondiciones,TCorchI]^.elementos[1]:=VCond;
   TAS[VCondiciones,TCorchI]^.elementos[2]:=VZ;
   TAS[VCondiciones,TCorchI]^.elementos[3]:=VW;
   TAS[VCondiciones,TCorchI]^.cant:=3;

   new(TAS[VCondiciones,Troot]);
   TAS[VCondiciones,Troot]^.elementos[1]:=VCond;
   TAS[VCondiciones,Troot]^.elementos[2]:=VZ;
   TAS[VCondiciones,Troot]^.elementos[3]:=VW;
   TAS[VCondiciones,Troot]^.cant:=3;

   new(TAS[VCondiciones,TIdentificador]);
   TAS[VCondiciones,TIdentificador]^.elementos[1]:=VCond;
   TAS[VCondiciones,TIdentificador]^.elementos[2]:=VZ;
   TAS[VCondiciones,TIdentificador]^.elementos[3]:=VW;
   TAS[VCondiciones,TIdentificador]^.cant:=3;

   new(TAS[VCondiciones,Tconst]);
   TAS[VCondiciones,Tconst]^.elementos[1]:=VCond;
   TAS[VCondiciones,Tconst]^.elementos[2]:=VZ;
   TAS[VCondiciones,Tconst]^.elementos[3]:=VW;
   TAS[VCondiciones,Tconst]^.cant:=3;

   new(TAS[VCondiciones,TParI]);
   TAS[VCondiciones,TParI]^.elementos[1]:=VCond;
   TAS[VCondiciones,TParI]^.elementos[2]:=VZ;
   TAS[VCondiciones,TParI]^.elementos[3]:=VW;
   TAS[VCondiciones,TParI]^.cant:=3;

   new(TAS[VCondiciones,Tmenos]);
   TAS[VCondiciones,Tmenos]^.elementos[1]:=VCond;
   TAS[VCondiciones,Tmenos]^.elementos[2]:=VZ;
   TAS[VCondiciones,Tmenos]^.elementos[3]:=VW;
   TAS[VCondiciones,Tmenos]^.cant:=3;

   new(TAS[VCondiciones,TCantidad]);
   TAS[VCondiciones,TCantidad]^.elementos[1]:=VCond;
   TAS[VCondiciones,TCantidad]^.elementos[2]:=VZ;
   TAS[VCondiciones,TCantidad]^.elementos[3]:=VW;
   TAS[VCondiciones,TCantidad]^.cant:=3;

   new(TAS[VCondiciones,Telemento]);
   TAS[VCondiciones,Telemento]^.elementos[1]:=VCond;
   TAS[VCondiciones,Telemento]^.elementos[2]:=VZ;
   TAS[VCondiciones,Telemento]^.elementos[3]:=VW;
   TAS[VCondiciones,Telemento]^.cant:=3;

   new(TAS[VW,Tor]);
   TAS[VW,Tor]^.elementos[1]:=Tor;
   TAS[VW,Tor]^.elementos[2]:=VCondiciones;
   TAS[VW,Tor]^.cant:=2;

   new(TAS[VW,TllaveI]);
   TAS[VW,TllaveI]^.cant:=0;

   new(TAS[VW,TCorchD]);
   TAS[VW,TCorchD]^.cant:=0;

   new(TAS[VZ,Tand]);
   TAS[VZ,Tand]^.elementos[1]:=Tand;
   TAS[VZ,Tand]^.elementos[2]:=VCond;
   TAS[VZ,Tand]^.elementos[3]:=VZ;
   TAS[VZ,Tand]^.cant:=3;

   new(TAS[VZ,TllaveI]);
   TAS[VZ,TllaveI]^.cant:=0;

   new(TAS[VW,TCorchD]);
   TAS[VW,TCorchD]^.cant:=0;

   new(TAS[VW,Tor]);
   TAS[VW,Tor]^.cant:=0;

   new(TAS[VCond,Tnot]);
   TAS[VCond,Tnot]^.elementos[1]:=Tnot;
   TAS[VCond,Tnot]^.elementos[2]:=VCond;
   TAS[VCond,Tnot]^.cant:=2;

   new(TAS[VCond,TCorchI]);
   TAS[VCond,TCorchI]^.elementos[1]:=TCorchI;
   TAS[VCond,TCorchI]^.elementos[2]:=VCondiciones;
   TAS[VCond,TCorchI]^.elementos[3]:=TCorchD;
   TAS[VCond,TCorchI]^.cant:=3;

   new(TAS[VCond,Troot]);
   TAS[VCond,Troot]^.elementos[1]:=VExpArit;
   TAS[VCond,Troot]^.elementos[2]:=TOpRel;
   TAS[VCond,Troot]^.elementos[3]:=VExpArit;
   TAS[VCond,Troot]^.cant:=3;

   new(TAS[VCond,TIdentificador]);
   TAS[VCond,TIdentificador]^.elementos[1]:=VExpArit;
   TAS[VCond,TIdentificador]^.elementos[2]:=TOpRel;
   TAS[VCond,TIdentificador]^.elementos[3]:=VExpArit;
   TAS[VCond,TIdentificador]^.cant:=3;

   new(TAS[VCond,Tconst]);
   TAS[VCond,Tconst]^.elementos[1]:=VExpArit;
   TAS[VCond,Tconst]^.elementos[2]:=TOpRel;
   TAS[VCond,Tconst]^.elementos[3]:=VExpArit;
   TAS[VCond,Tconst]^.cant:=3;

   new(TAS[VCond,TParI]);
   TAS[VCond,TParI]^.elementos[1]:=VExpArit;
   TAS[VCond,TParI]^.elementos[2]:=TOpRel;
   TAS[VCond,TParI]^.elementos[3]:=VExpArit;
   TAS[VCond,TParI]^.cant:=3;

   new(TAS[VCond,Tmenos]);
   TAS[VCond,Tmenos]^.elementos[1]:=VExpArit;
   TAS[VCond,Tmenos]^.elementos[2]:=TOpRel;
   TAS[VCond,Tmenos]^.elementos[3]:=VExpArit;
   TAS[VCond,Tmenos]^.cant:=3;

   new(TAS[VCond,TCantidad]);
   TAS[VCond,TCantidad]^.elementos[1]:=VExpArit;
   TAS[VCond,TCantidad]^.elementos[2]:=TOpRel;
   TAS[VCond,TCantidad]^.elementos[3]:=VExpArit;
   TAS[VCond,TCantidad]^.cant:=3;

   new(TAS[VCond,Telemento]);
   TAS[VCond,Telemento]^.elementos[1]:=VExpArit;
   TAS[VCond,Telemento]^.elementos[2]:=TOpRel;
   TAS[VCond,Telemento]^.elementos[3]:=VExpArit;
   TAS[VCond,Telemento]^.cant:=3;

   new(TAS[VSino,TSino]);
   TAS[VSino,TSino]^.elementos[1]:=VSino;
   TAS[VSino,TSino]^.elementos[2]:=TllaveI;
   TAS[VSino,TSino]^.elementos[3]:=VCuerpo;
   TAS[VSino,TSino]^.elementos[4]:=TllaveD;
   TAS[VSino,TSino]^.cant:=4;

   new(TAS[VSino,TPuntoyComa]);
   TAS[VSino,TPuntoyComa]^.cant:=0;

   new(TAS[VExpArit,Troot]);
   TAS[VExpArit,Troot]^.elementos[1]:=VA;
   TAS[VExpArit,Troot]^.elementos[2]:=VB;
   TAS[VExpArit,Troot]^.cant:=2;

   new(TAS[VExpArit,TIdentificador]);
   TAS[VExpArit,TIdentificador]^.elementos[1]:=VA;
   TAS[VExpArit,TIdentificador]^.elementos[2]:=VB;
   TAS[VExpArit,TIdentificador]^.cant:=2;

   new(TAS[VExpArit,Tconst]);
   TAS[VExpArit,Tconst]^.elementos[1]:=VA;
   TAS[VExpArit,Tconst]^.elementos[2]:=VB;
   TAS[VExpArit,Tconst]^.cant:=2;

   new(TAS[VExpArit,TParI]);
   TAS[VExpArit,TParI]^.elementos[1]:=VA;
   TAS[VExpArit,TParI]^.elementos[2]:=VB;
   TAS[VExpArit,TParI]^.cant:=2;

   new(TAS[VExpArit,Tmenos]);
   TAS[VExpArit,Tmenos]^.elementos[1]:=VA;
   TAS[VExpArit,Tmenos]^.elementos[2]:=VB;
   TAS[VExpArit,Tmenos]^.cant:=2;

   new(TAS[VExpArit,TCantidad]);
   TAS[VExpArit,TCantidad]^.elementos[1]:=VA;
   TAS[VExpArit,TCantidad]^.elementos[2]:=VB;
   TAS[VExpArit,TCantidad]^.cant:=2;

   new(TAS[VExpArit,Telemento]);
   TAS[VExpArit,Telemento]^.elementos[1]:=VA;
   TAS[VExpArit,Telemento]^.elementos[2]:=VB;
   TAS[VExpArit,Telemento]^.cant:=2;

   new(TAS[VB,Tmas]);
   TAS[VB,Tmas]^.elementos[1]:=Tmas;
   TAS[VB,Tmas]^.elementos[2]:=VA;
   TAS[VB,Tmas]^.elementos[3]:=VB;
   TAS[VB,Tmas]^.cant:=3;

   new(TAS[VB,Tmenos]);
   TAS[VB,Tmenos]^.elementos[1]:=Tmas;
   TAS[VB,Tmenos]^.elementos[2]:=VA;
   TAS[VB,Tmenos]^.elementos[3]:=VB;
   TAS[VB,Tmenos]^.cant:=3;

   new(TAS[VB,TPuntoyComa]);
   TAS[VB,TPuntoyComa]^.cant:=0;

   new(TAS[VB,TParD]);
   TAS[VB,TParD]^.cant:=0;

   new(TAS[VB,TOpRel]);
   TAS[VB,TOpRel]^.cant:=0;

   new(TAS[VB,TllaveI]);
   TAS[VB,TllaveI]^.cant:=0;

   new(TAS[VB,TCorchD]);
   TAS[VB,TCorchD]^.cant:=0;

   new(TAS[VB,Tor]);
   TAS[VB,Tor]^.cant:=0;

   new(TAS[VB,Tand]);
   TAS[VB,Tand]^.cant:=0;

   new(TAS[VB,TComa]);
   TAS[VB,TComa]^.cant:=0;

   new(TAS[VA,Troot]);
   TAS[VA,Troot]^.elementos[1]:=VC;
   TAS[VA,Troot]^.elementos[2]:=VD;
   TAS[VA,Troot]^.cant:=2;

   new(TAS[VA,TIdentificador]);
   TAS[VA,TIdentificador]^.elementos[1]:=VC;
   TAS[VA,TIdentificador]^.elementos[2]:=VD;
   TAS[VA,TIdentificador]^.cant:=2;

   new(TAS[VA,TConst]);
   TAS[VA,TConst]^.elementos[1]:=VC;
   TAS[VA,TConst]^.elementos[2]:=VD;
   TAS[VA,TConst]^.cant:=2;

   new(TAS[VA,TParI]);
   TAS[VA,TParI]^.elementos[1]:=VC;
   TAS[VA,TParI]^.elementos[2]:=VD;
   TAS[VA,TParI]^.cant:=2;

   new(TAS[VA,Tmenos]);
   TAS[VA,Tmenos]^.elementos[1]:=VC;
   TAS[VA,Tmenos]^.elementos[2]:=VD;
   TAS[VA,Tmenos]^.cant:=2;

   new(TAS[VA,TCantidad]);
   TAS[VA,TCantidad]^.elementos[1]:=VC;
   TAS[VA,TCantidad]^.elementos[2]:=VD;
   TAS[VA,TCantidad]^.cant:=2;

   new(TAS[VA,Telemento]);
   TAS[VA,Telemento]^.elementos[1]:=VC;
   TAS[VA,Telemento]^.elementos[2]:=VD;
   TAS[VA,Telemento]^.cant:=2;

   new(TAS[VD,Tpor]);
   TAS[VD,Tpor]^.elementos[1]:=Tpor;
   TAS[VD,Tpor]^.elementos[2]:=VC;
   TAS[VD,Tpor]^.elementos[3]:=VD;
   TAS[VD,Tpor]^.cant:=3;

   new(TAS[VD,Tdiv]);
   TAS[VD,Tdiv]^.elementos[1]:=Tdiv;
   TAS[VD,Tdiv]^.elementos[2]:=VC;
   TAS[VD,Tdiv]^.elementos[3]:=VD;
   TAS[VD,Tdiv]^.cant:=3;

   new(TAS[VD,Tmas]);
   TAS[VD,Tmas]^.cant:=0;

   new(TAS[VD,Tmenos]);
   TAS[VD,Tmenos]^.cant:=0;

   new(TAS[VD,TParD]);
   TAS[VD,TParD]^.cant:=0;

   new(TAS[VD,TOpRel]);
   TAS[VD,TOpRel]^.cant:=0;

   new(TAS[VD,TComa]);
   TAS[VD,TComa]^.cant:=0;

   new(TAS[VD,TCorchD]);
   TAS[VD,TCorchD]^.cant:=0;

   new(TAS[VD,TPuntoyComa]);
   TAS[VD,TPuntoyComa]^.cant:=0;

    new(TAS[VC,Troot]);
   TAS[VC,Troot]^.elementos[1]:=Troot;
   TAS[VC,Troot]^.elementos[2]:=TParI;
   TAS[VC,Troot]^.elementos[3]:=VExpArit;
   TAS[VC,Troot]^.elementos[4]:=TParD;
   TAS[VC,Troot]^.elementos[5]:=VE;
   TAS[VC,Troot]^.cant:=5;

   new(TAS[VC,TIdentificador]);
   TAS[VC,TIdentificador]^.elementos[1]:=VF;
   TAS[VC,TIdentificador]^.elementos[2]:=VE;
   TAS[VC,TIdentificador]^.cant:=2;

   new(TAS[VC,Tconst]);
   TAS[VC,Tconst]^.elementos[1]:=VF;
   TAS[VC,Tconst]^.elementos[2]:=VE;
   TAS[VC,Tconst]^.cant:=2;

   new(TAS[VC,TParI]);
   TAS[VC,TParI]^.elementos[1]:=VF;
   TAS[VC,TParI]^.elementos[2]:=VE;
   TAS[VC,TParI]^.cant:=2;

   new(TAS[VC,Tmenos]);
   TAS[VC,Tmenos]^.elementos[1]:=VF;
   TAS[VC,Tmenos]^.elementos[2]:=VE;
   TAS[VC,Tmenos]^.cant:=2;

   new(TAS[VC,TCantidad]);
   TAS[VC,TCantidad]^.elementos[1]:=VF;
   TAS[VC,TCantidad]^.elementos[2]:=VE;
   TAS[VC,TCantidad]^.cant:=2;

   new(TAS[VC,Telemento]);
   TAS[VC,Telemento]^.elementos[1]:=VF;
   TAS[VC,Telemento]^.elementos[2]:=VE;
   TAS[VC,Telemento]^.cant:=2;

   new(TAS[VE,Telev]);
   TAS[VE,Telev]^.elementos[1]:=Telev;
   TAS[VE,Telev]^.elementos[2]:=VF;
   TAS[VE,Telev]^.elementos[3]:=VE;
   TAS[VE,Telev]^.cant:=3;

   new(TAS[VE,Tpor]);
   TAS[VE,Tpor]^.cant:=0;

   new(TAS[VE,Tdiv]);
   TAS[VE,Tdiv]^.cant:=0;

   new(TAS[VE,Tmas]);
   TAS[VE,Tmas]^.cant:=0;

   new(TAS[VE,Tmenos]);
   TAS[VE,Tmenos]^.cant:=0;

   new(TAS[VE,TPuntoyComa]);
   TAS[VE,TPuntoyComa]^.cant:=0;

   new(TAS[VE,TParD]);
   TAS[VE,TParD]^.cant:=0;

   new(TAS[VE,TOpRel]);
   TAS[VE,TOpRel]^.cant:=0;

   new(TAS[VE,TllaveI]);
   TAS[VE,TllaveI]^.cant:=0;

   new(TAS[VE,TCorchD]);
   TAS[VE,TCorchD]^.cant:=0;

   new(TAS[VE,Tor]);
   TAS[VE,Tor]^.cant:=0;

   new(TAS[VE,Tand]);
   TAS[VE,Tand]^.cant:=0;

   new(TAS[VE,TComa]);
   TAS[VE,TComa]^.cant:=0;

   new(TAS[VF,TIdentificador]);
   TAS[VF,TIdentificador]^.elementos[1]:=TIdentificador;
   TAS[VF,TIdentificador]^.cant:=1;

   new(TAS[VF,Tconst]);
   TAS[VF,Tconst]^.elementos[1]:=TIdentificador;
   TAS[VF,Tconst]^.cant:=1;

   new(TAS[VF,TParI]);
   TAS[VF,TParI]^.elementos[1]:=TParI;
   TAS[VF,TParI]^.elementos[2]:=VExpArit;
   TAS[VF,TParI]^.elementos[3]:=TParD;
   TAS[VF,TParI]^.cant:=3;

   new(TAS[VF,Tmenos]);
   TAS[VF,Tmenos]^.elementos[1]:=Tmenos;
   TAS[VF,Tmenos]^.elementos[2]:=VF;
   TAS[VF,Tmenos]^.cant:=2;

   new(TAS[VF,TCantidad]);
   TAS[VF,TCantidad]^.elementos[1]:=TCantidad;
   TAS[VF,TCantidad]^.elementos[2]:=TParI;
   TAS[VF,TCantidad]^.elementos[3]:=TIdentificador;
   TAS[VF,TCantidad]^.elementos[4]:=TParD;
   TAS[VF,TCantidad]^.cant:=4;

   new(TAS[VF,Telemento]);
   TAS[VF,Telemento]^.elementos[1]:=Telemento;
   TAS[VF,Telemento]^.elementos[2]:=TParI;
   TAS[VF,Telemento]^.elementos[3]:=TIdentificador;
   TAS[VF,Telemento]^.elementos[4]:=TComa;
   TAS[VF,Telemento]^.elementos[5]:=VExpArit;
   TAS[VF,Telemento]^.elementos[6]:=TParD;
   TAS[VF,Telemento]^.cant:=6;

end;

{Function EsTerminal(X:TSimbGramatical):boolean;
var
  i:TSimbGramatical;
  Error:boolean;
 begin
   i:=TIdentificador;
   Error:=False;
   EsTerminal:=False;
   While (not EsTerminal) and (not Error) do
      begin
        if i=X then
          EsTerminal:=True
        else
          begin
           EsTerminal:=False;
           inc(i);
            if (i=pesos) and (X<>i) then
             Error:= True;
          end;
      end
 end;  }

 Function EsVariable(var X:TSimbGramatical):boolean;
  const
    V=[Vprograma,VidVar,VTipo,VCuerpo,Vvariables,VSent,VU,VL,VT,VCond,VCondiciones,VW,VZ,VSino,VExpArit,VA,VB,VD,VC,VE,VF];
   begin
    If X in V then
     begin
       EsVariable:=True;
     end
    else
     begin
       EsVariable:=False;
     end;
  end;

{Function EsVariable(X:TSimbGramatical):boolean;
var
  i:TSimbGramatical;
  Error:Boolean;
 begin
   Error:=False;
   EsVariable:=False;
   i:=VPrograma;
   While (not EsVariable) and (not Error) do
    begin
      if i=X then                                                                     //VProgram to VCond
        EsVariable:=True
      else
        begin
         EsVariable:=False;
         inc(i);
         if i=TcorchI then
           Error:=True;
        end;
    end;
 end;   }

end.

