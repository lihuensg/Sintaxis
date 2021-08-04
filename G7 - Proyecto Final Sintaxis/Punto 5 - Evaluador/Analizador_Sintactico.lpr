program Interprete;
Uses
 crt, Classes, SysUtils, Pila, Arbol, Matriz, TAS_Matriz, Identificadores,
 Archivo, TabSimb, TabSimb_Aplicacion, AnalizadorSintactico, Evaluador;
const
  ruta2='E:\Pascal versions\Proyecto Final Sintaxis\Proyecto Final Sintaxis Crakens\Evaluador\Arbol.txt';
var
  Fuente:t_arch;
  T_S:T_lista;
  P:TPila;
  texto:text;
  raiz:Tarbol;
  TAS:TTAS;
  estado:T_lista2;
  exito:boolean;

begin
  exito:=false;
  abrir_archivo(Fuente);
  Incializar_TS (T_S);
  IncializarLista2(estado);
  CrearPila(P);
  Inicializar_TAS(TAS);
  Cargarpalresev(T_S);
  Cargar_TAS(TAS);
  Crear_arbol(Raiz);
  ObtenerArboldeDerivacion(raiz,TAS,Fuente,T_S,exito);
  If exito then
  begin
  evalPrograma(raiz,estado);
  end;
  Assign(texto,ruta2);
  rewrite(texto);
  Mostrar_arbol(Raiz,0,texto);
  close(texto);
  Close(Fuente);
  readkey;
end.

