program Analizador_Lexico;
uses Identificadores,crt,Archivo,TabSimb_Aplicacion, TabSimb;
var
  Fuente:t_arch;
  control:integer;
  lexema:string;
  Complex:TSimbGramatical;
  Condicion:char;
  T_S:T_lista;


begin
    control:=0;
    Condicion:=' ';
    Incializar_TS (T_S);
    abrir_archivo(Fuente);
    ObtenerSiguienteCompLex(Fuente,control,Complex,lexema,T_S);
    while (Complex<>pesos) and (CompLex<>ErrorLexico) do
      begin
        Writeln(CompLex);
        Writeln(lexema);
        Readln;
        ObtenerSiguienteCompLex(Fuente,control,Complex,lexema,T_S);
      end;
    //Writeln();
    close(Fuente);
    Readln;
    //clrscr;
end.

