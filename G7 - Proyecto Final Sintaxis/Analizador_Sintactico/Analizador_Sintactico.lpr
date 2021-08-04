program Analizador_Sintactico;
Uses
 crt,Classes,SysUtils,Pila,Arbol,Matriz,TAS_Matriz,Identificadores,Archivo,TabSimb,TabSimb_Aplicacion;
const
  ruta2='E:\Pascal versions\Proyecto Final Sintaxis\Proyecto Final Sintaxis Crakens\Analizador_Sintactico\Arbol.txt';
var
  Exito,Error:boolean;
  Control:integer;
  X:TSimbGramatical;
  Fuente:t_arch;
  Lexema:string;
  complex:TSimbGramatical;
  T_S:T_lista;
  Salir:boolean;
  Punt:Tarbol;
  ComplexHijo:TSimbGramatical;
  LexemaHijo:String;
  i:byte;
  hijo:Tarbol;
  P:TPila;
  texto:text;

begin
  abrir_archivo(Fuente);
  Incializar_TS (T_S);
  CrearPila(P);
  Inicializar_TAS(TAS);
  //crear_arbol(Punt);
  Cargarpalresev(T_S);
  Cargar_TAS(TAS);
  Crear_arbol(Raiz);
  //Complex:=pesos;
  //Lexema:='';
  //Apilar(P,TAS[VPrograma,TllaveI],Punt);
  Complex:=VPrograma;
  Lexema:='Programa';
  agregar_arbol(Raiz,CompLex,Lexema);
  Apilar(P,TAS[VPrograma,TllaveI],Punt);
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
          Error:=True
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
           ObtenerSiguienteCompLex(Fuente,control,complex,lexema,T_S)
         end
        else
         begin
          writeln('se esperaba: ',X);
          writeln('ERROR');
         Error:=True;
         end;
       end;
      if (complex=pesos) and (X=pesos) then
       Exito:=True;
    end;
  Assign(texto,ruta2);
  rewrite(texto);
  Mostrar_arbol(Raiz,0,texto);
  close(texto);
  readkey;
  Close(Fuente);
end.

