program Easy_Actualizador;

uses
  Forms, windows,
  UActualizador in 'UActualizador.pas' {FActualizador},
  UNuevaAct in 'UNuevaAct.pas' {FNuevaAct};

{$R *.res}

var 
Mutex :THandle;
PreviousHandle :THandle;
begin
 PreviousHandle:= FindWindow('TFActualizador', 'FActualizador');
 Mutex:= CreateMutex(nil, True, 'Actualizador_ES');
  if (Mutex = 0) OR (GetLastError = ERROR_ALREADY_EXISTS) then
  begin
   SetForeGroundWindow(PreviousHandle);
  end
 else
  begin
   Application.Initialize;
   Application.Title := 'ES Actualizador v1.1';
   Application.CreateForm(TFActualizador, FActualizador);
   Application.Run;
    if Mutex <> 0 then
    closeHandle(Mutex);
  end;
end.
