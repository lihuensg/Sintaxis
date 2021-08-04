unit Archivo;

{$mode objfpc}{$H+}

interface
uses
  crt,Sysutils;
const
  finarch=#0;
  ruta='E:\Pascal versions\Proyecto Final Sintaxis\Proyecto Final Sintaxis Crakens\Analizador_Sintactico\ArchAS.txt';

type
  t_arch=file of char;

procedure abrir_archivo(var archivo:t_arch);
procedure leercaracter(var archivo:t_arch; var pos:integer;var caracter:char);
implementation
procedure abrir_archivo(var archivo:t_arch);
     begin
       Assign(archivo,ruta);
       if not FileExists(ruta) then
       begin
           Rewrite(archivo);
           Close(archivo);
       end;
       reset(archivo)
       //CloseFile(archivo);
     end;

procedure leercaracter(var archivo:t_arch; var pos:integer;var caracter:char);
   //var
     //archivo:t_arch;
   begin
     //abrir_archivo(archivo);
     if pos<filesize(archivo) then
       begin
         seek(archivo,pos);
         read(archivo,caracter);
       end
     else caracter:=finarch;
     //close(archivo);
   end;
end.

