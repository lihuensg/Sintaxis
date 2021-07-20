program Analizador_Lexico;
uses Identificadores,crt,Archivo,TabSimb_Aplicacion, TabSimb;
var
  Fuente:t_arch;
  control:integer;
  lexema:string;
  Complex:TSimbGramatical;
  Condicion:char;
  T_S:T_lista;
  //Salir:boolean;

begin
    control:=0;
    Condicion:=' ';
    //Salir:=false;
    abrir_archivo(Fuente);
    ObtenerSiguienteCompLex(Fuente,control,Complex,lexema,T_S);
    while (Complex<>pesos) and (CompLex<>ErrorLexico) do
      begin
        Writeln('probando');
        Writeln(lexema);
        Readln;
        ObtenerSiguienteCompLex(Fuente,control,Complex,lexema,T_S);
      end;
    Writeln('probando01');
    close(Fuente);

    //Chequear_lista(T_S);
    Readln;
    //clrscr;
end.

