unit UActualizador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, IdBaseComponent, IdComponent, IdRawBase, IdRawClient,
  IdIcmpClient, StdCtrls, DB, DBClient, SimpleDS, SqlExpr, Gauges, Buttons,
  Menus, IniFiles, Grids, DBGrids, ComCtrls, ShellApi, Registry, ExtCtrls,
  TrayIcon, jpeg, ShellCtrls, SHChangeNotify, IdTCPConnection, IdTCPClient,
  IdFTP, FileCtrl;

type
  TFActualizador = class(TForm)
    SQLConnection1: TSQLConnection;
    SimpleDataSet1: TSimpleDataSet;
    Label1: TLabel;
    IdIcmpClient1: TIdIcmpClient;
    BitBtn2: TBitBtn;
    SimpleDataSet1UPGRADE: TSmallintField;
    SimpleDataSet1ACTUAL: TSmallintField;
    SimpleDataSet1ADM_8: TSmallintField;
    SimpleDataSet1ADM_ALTA: TSmallintField;
    SimpleDataSet1ADM_GLENY: TSmallintField;
    SimpleDataSet1ADM_MIGUELITO: TSmallintField;
    SimpleDataSet1ADM_RAQUEL: TSmallintField;
    SimpleDataSet1ADM_ROBERTO: TSmallintField;
    SimpleDataSet1ADM_ROSSY: TSmallintField;
    SimpleDataSet1ADM_SOPORTE: TSmallintField;
    SimpleDataSet1ALCARRIZOS: TSmallintField;
    SimpleDataSet1ALMACEN: TSmallintField;
    SimpleDataSet1BOCA_CHICA: TSmallintField;
    SimpleDataSet1CAMBITA: TSmallintField;
    SimpleDataSet1ELECTROMUEBLES: TSmallintField;
    SimpleDataSet1ELIAS_PINA: TSmallintField;
    SimpleDataSet1EXTRA_1: TSmallintField;
    SimpleDataSet1EXTRA_2: TSmallintField;
    SimpleDataSet1EXTRA_3: TSmallintField;
    SimpleDataSet1HAINA_1: TSmallintField;
    SimpleDataSet1HAINA_2: TSmallintField;
    SimpleDataSet1HAINA_3: TSmallintField;
    SimpleDataSet1HATO_NUEVO: TSmallintField;
    SimpleDataSet1INDEPENDENCIA: TSmallintField;
    SimpleDataSet1KM_22: TSmallintField;
    SimpleDataSet1KM_25: TSmallintField;
    SimpleDataSet1LA_PARED: TSmallintField;
    SimpleDataSet1LAS_AMERICAS: TSmallintField;
    SimpleDataSet1LAS_PALMAS: TSmallintField;
    SimpleDataSet1LOS_FRAILES: TSmallintField;
    SimpleDataSet1NIGUA_1: TSmallintField;
    SimpleDataSet1NIGUA_2: TSmallintField;
    SimpleDataSet1NIZAO: TSmallintField;
    SimpleDataSet1PALENQUE: TSmallintField;
    SimpleDataSet1PANTOJA: TSmallintField;
    SimpleDataSet1QUITA_SUENO: TSmallintField;
    SimpleDataSet1SAN_CRISTOBAL: TSmallintField;
    SimpleDataSet1SAN_VICENTE: TSmallintField;
    SimpleDataSet1VILLA_MELLA: TSmallintField;
    Label2: TLabel;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    ActualizarAhora1: TMenuItem;
    CerrarActualizador1: TMenuItem;
    Image1: TImage;
    Timer2: TTimer;
    MostrarActualizador1: TMenuItem;
    OcultarActualizador1: TMenuItem;
    Timer4: TTimer;
    SHChangeNotify1: TSHChangeNotify;
    Timer5: TTimer;
    IdFTP1: TIdFTP;
    Gauge1: TGauge;
    ProgressBar1: TProgressBar;
    BitBtn1: TBitBtn;
    
      
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure SQLConnection1BeforeConnect(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ActualizarAhora1Click(Sender: TObject);
    procedure CerrarActualizador1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer2Timer(Sender: TObject);
    procedure MostrarActualizador1Click(Sender: TObject);
    procedure ShellChangeNotifier1Change;
    procedure Timer3Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OcultarActualizador1Click(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure SHChangeNotify1UpdateDir(Sender: TObject; Flags: Cardinal;
      Path1: String);
    procedure SHChangeNotify1Delete(Sender: TObject; Flags: Cardinal;
      Path1: String);
    procedure Timer5Timer(Sender: TObject);
    procedure IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);


  private
  Procedure Probar_Conexion;
  procedure PonerProgramaInicio;
  Procedure AutoAct;

  public
  Ruta: String;




  end;

var
  FActualizador: TFActualizador;
  Ini, Ini2  : TIniFile;
  Configurado, Terminal, Cad3, Sql, Ruta,Ruta_Winrar,Ruta_Act, IpServidor, Modo, Path1, Fecha1, Fecha2, CadBat, LetraDisco: String;
  Num1, Num2, Num_Act, Work_Count : Integer;
  lpFileOp: TSHFileOpStruct;
  Hora_Mod: TDateTime;
  Auto_Act: Boolean;
  //
  Afiles: TStringList;
  i,r,BarraProgreso: Integer;
  FTP: TIdFTP;
  ArcEnProc :String;
implementation

uses UnuevaAct, UListar;

{$R *.dfm}

function ExisteArchivo(Ruta:string):boolean;
begin
      if (FileExists(Ruta)) then
      begin
         //Existe
        Result:=true;
      end
     else
     begin
        //No Existe
        Result:=false;
     end;
end;
/////////////////////////////INICIAR CON WINDOWS: INICIO
procedure TFActualizador.PonerProgramaInicio;
var Registro: TRegistry;
begin

  Registro := TRegistry.Create;
  Registro.RootKey := HKEY_LOCAL_MACHINE;

  if Registro.OpenKey( 'Software\Microsoft\Windows\CurrentVersion\Run', FALSE ) then
  begin
    try
    Registro.WriteString( ExtractFileName( Application.ExeName ), Application.ExeName );
    Registro.CloseKey;
    except
       MessageDlg('No se pudo config. el auto-inicio, de la utilidad de actualizacion automatica de Easy System', mtWarning, [mbOK], 0);
  end;

  Registro.Free;
  end;
  end;
/////////////////////////////INICIAR CON WINDOWS: FIN

/////////////////////////////PROBANDO CONEXION: INICIO
Procedure TFActualizador.Probar_Conexion;
begin
if Modo = 'Local' then
    IpServidor:= '10.0.0.15';

    if Modo = 'Remoto' then
    IpServidor:= '25.108.175.106';

IdIcmpClient1.Host:= IpServidor;
IdIcmpClient1.Ping;

if IdIcmpClient1.ReplyStatus.BytesReceived = 0 then
    begin
      Label1.Caption:= 'No Conectado';
      
    end else begin
      Label1.Caption:= 'Conectado '+ IpServidor;
      SQLConnection1.Open;
      SimpleDataSet1.Open;
      Num2:= SimpleDataSet1UPGRADE.AsInteger;
      SimpleDataSet1.Close;

      
      end;

end;
///////////////////////////////PROBANDO CONEXION: FIN


procedure TFActualizador.BitBtn1Click(Sender: TObject);

begin
sql:= 'UPDATE ACTUALIZADOR s SET s.upgrade = s.upgrade + 1';
    SQLConnection1.Execute(sql, nil, nil)
end;



procedure TFActualizador.BitBtn2Click(Sender: TObject);
var
//FTP: TIdFTP;
Tam, Tam2, Tam3, FHandle, BytesEnviados, P, Barra: Integer;
Directorio: TStringList;
begin
  BitBtn2.Enabled:= False;
  Tam:= 0;
  Directorio := TStringList.Create;
  try
    Ulistar.FListar.Listar( 'D:\Archivos Rars\', Directorio );
    except
    raise Exception.Create('No se ha podido listar los archivos para subir.');
  end;
  //ShowMessage( Directorio.Text );
  //Directorio.Free;

  //ShowMessage(IntToStr(Tam));
  LetraDisco:= 'D:';
  FTP := TIdFTP.Create( nil );
  FTP.OnWork := IdFTP1Work;
  //FTP.EndWork(wmRead):= IdFTP1WorkEnd
  FTP.Username := 'isaelfeliciano_zxq';
  FTP.Password := 'Ri846161636';
  FTP.Host := 'isaelfeliciano.zxq.net';
  Barra:= 0;
  try
    FTP.Connect;
    except
    raise Exception.Create( 'No se ha podido conectar con el servidor. ');
  end;
  for P := 0 to Directorio.Count -1 do
  begin
    FHandle := FileOpen('D:\Archivos Rars\'+Directorio[P], 0);
    Tam := Tam + Getfilesize(FHandle,nil);
    FileClose(FHandle);
  end;
  FTP.ChangeDir( '/Prueba/' );
  //Afiles:= TStringList.Create;
  //Afiles.Add(AFiles, 'D:Actualizaciones\Easy*.rar', False);
  Gauge1.MinValue:= 0;
  Gauge1.MaxValue:= Tam;
  //ShowMessage(IntToStr(Tam));

  Gauge1.Progress:= 0;
  for i := 0 to Directorio.Count -1 do
    begin
      try
        //FTP.TransferType := ftBinary;
        ArcEnProc:=  Directorio[i];
        FHandle := FileOpen('D:\Archivos Rars\'+Directorio[i], 0);
        Tam2 :=  Getfilesize(FHandle,nil);
        FileClose(FHandle);
        ProgressBar1.Min:= 0;
        ProgressBar1.Max:= Tam2;
        Label2.Caption:= 'Subiendo: ' + ArcEnProc + ' / Tama�o del archivo: ' + IntToStr(Tam2 div 1024)+ ' Kb';
        Label1.Caption:= 'Total';
        Update;
        FTP.BeginWork(wmWrite);
        FTP.Put( 'D:\Archivos Rars\'+Directorio[i], Directorio[i], False);
        FTP.EndWork(wmWrite);
        Tam3:= Tam3 + Tam2;
        Gauge1.Progress:=  Tam3;
        //ShowMessage(IntToStr(Gauge1.Progress));
        //Gauge1.Progress:= Gauge1.Progress + 10;
        //Sleep(500);
        Except
        raise Exception.Create( 'No se ha podido iniciar la Subida. ');

    {BytesEnviados := ProgressBar1.Position;
                         If BytesEnviados < Tam then
                            ShowMessage('El Archivo no pudo ser Enviado')
                         Else
                             ShowMessage('El Archivo fue Enviado');}

      end;
 end;
  BitBtn2.Enabled:= True;
  BitBtn1.Enabled:= True;
 //ShowMessage('Terminado'+IntToStr(BarraProgreso));
 //FTP.EndWork(wmWrite);
 FTP.Disconnect;
 FTP.Free;
 if Gauge1.Progress =  Gauge1.MaxValue then begin

 //sql:= 'UPDATE ACTUALIZADOR s SET s.upgrade = s.upgrade + 1';
    //SQLConnection1.Execute(sql, nil, nil)
    end;
    end;




procedure TFActualizador.FormCreate(Sender: TObject);
begin
Work_Count:=0;
FActualizador.Top:= Screen.WorkAreaHeight -187;
FActualizador.Left:= Screen.WorkAreaWidth -597;
TrayIcon1.Show;
Timer1.Enabled:= True;
SQLConnection1.Close;
SimpleDataSet1.Connection:= SQLConnection1;
Cad3:='ADM_SOPORTE';
Ini2 := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );

    Configurado:= Ini2.ReadString( 'ComboBox1', 'Iniciado?', '' );
    Terminal:=    Ini2.ReadString( 'ComboBox1', 'Terminal', '' );
    Modo:=        Ini2.ReadString( 'ComboBox1', 'Modo', '' );
    Num1:=StrToInt(Ini2.ReadString('ComboBox1', 'Num_Act', ''));
    Ruta:=        Ini2.ReadString( 'ComboBox1', 'Rutas', '' );
    Ruta_Winrar:=Ini2.ReadString(  'ComboBox1', 'Ruta_Winrar', '' );
    Ruta_Act:=   Ini2.ReadString(  'ComboBox1', 'Ruta_Act', '' );
    LetraDisco:= Ini2.ReadString(  'ComboBox1', 'LetraDisco', '' );


   Timer2.Enabled:= True;
   Timer5.Enabled:= True;

end;


procedure TFActualizador.BitBtn3Click(Sender: TObject);
var lpFileOp: TSHFileOpStruct;
begin
Probar_Conexion;

 if Num1 < Num2 then
 begin
 //ShowMessage('Iniciando');

begin

    { Relleno de la estructura }
    {lpFileOp.Wnd := Self.Handle;
    lpFileOp.wFunc := FO_COPY;
    lpFileOp.pFrom := PChar('D:\Actualizaciones\*.*' + #0#0);
    lpFileOp.pTo := PChar('D:\Easy System S2010' + #0#0);
    lpFileOp.fFlags:= FOF_SIMPLEPROGRESS or FOF_FILESONLY;
    lpFileOp.fAnyOperationsAborted := FALSE;
    lpFileOp.hNameMappings := nil;
    lpFileOp.lpszProgressTitle := PChar('Trasladando archivos al disco D' + #0#0);
    ProgressBar1.Position:= 50;

    { Mover el archivo }
    //SHFileOperation(lpFileOp);

 //origen:= 'D:\Actualizaciones\*.*';
 //destino:= 'D:\Easy System S2010';

end;
end;
end;
procedure TFActualizador.BitBtn4Click(Sender: TObject);
begin
//
end;




procedure TFActualizador.SQLConnection1BeforeConnect(Sender: TObject);
begin
 with Sender as TSQLConnection do
  begin
    if LoginPrompt = False then
    begin
      if Modo = 'Local' then begin
      IpServidor:= '10.0.0.15';
      SQLConnection1.Params.Values['Database']:= '10.0.0.15:D:\Easy System News\DATA.FDB';
      end;
        if Modo = 'Remoto' then begin
        IpServidor:= '25.108.175.106';
        SQLConnection1.Params.Values['Database']:= '25.108.175.106:D:\Easy System News\DATA.FDB';
        end;
    end;
  end;
end;
procedure TFActualizador.Timer1Timer(Sender: TObject);
begin
Probar_Conexion;
end;

procedure TFActualizador.ActualizarAhora1Click(Sender: TObject);
begin
Label2.Caption:= 'Descargando archivos.';  
FActualizador.Top:= Screen.WorkAreaHeight -187;
FActualizador.Left:= Screen.WorkAreaWidth -597;

end;

procedure TFActualizador.CerrarActualizador1Click(Sender: TObject);
begin
FActualizador.Close;
end;

procedure TFActualizador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
TrayIcon1.Hide;

Action:= Cafree;
end;


procedure TFActualizador.Timer2Timer(Sender: TObject);
begin
FActualizador.Top:= Screen.WorkAreaHeight +187;
FActualizador.Left:= Screen.WorkAreaWidth +597;
Timer2.Enabled:= False;
end;

procedure TFActualizador.MostrarActualizador1Click(Sender: TObject);
begin
FActualizador.Top:= Screen.WorkAreaHeight -187;
FActualizador.Left:= Screen.WorkAreaWidth -597;
end;

procedure TFActualizador.ShellChangeNotifier1Change;
begin
//Timer3.Enabled:= True;
//ShowMessage('Modificado');
end;

Procedure TFActualizador.AutoAct;
var lpFileOp: TSHFileOpStruct; Ruta_AutoAct: String;
begin
//Timer3.Enabled:= False;
Ruta_AutoAct:= Ruta+'Actualizador\*.*';
    lpFileOp.Wnd := Self.Handle;
    lpFileOp.wFunc := FO_COPY;
    lpFileOp.pFrom := PChar(Ruta_AutoAct + #0#0);
    lpFileOp.pTo := PChar(Ruta + #0#0);
    lpFileOp.fFlags:= FOF_SIMPLEPROGRESS or FOF_FILESONLY or FOF_NOCONFIRMATION;
    lpFileOp.fAnyOperationsAborted := FALSE;
    lpFileOp.hNameMappings := nil;
    lpFileOp.lpszProgressTitle := PChar('Trasladando archivos al disco D' + #0#0);
    FActualizador.Close;

    { Mover el archivo }
    SHFileOperation(lpFileOp);
end;

procedure TFActualizador.Timer3Timer(Sender: TObject);
begin
AutoAct;
end;

procedure TFActualizador.FormShow(Sender: TObject);
begin
ShowWindow(application.Handle, SW_HIDE)
end;

procedure TFActualizador.OcultarActualizador1Click(Sender: TObject);
begin
FActualizador.Top:= Screen.WorkAreaHeight +187;
FActualizador.Left:= Screen.WorkAreaWidth +597;
end;

procedure TFActualizador.Timer4Timer(Sender: TObject);
begin
//
end;

procedure TFActualizador.SHChangeNotify1UpdateDir(Sender: TObject; Flags: Cardinal;
  Path1: String);
begin
//Update_Dir:= Path1;
if Path1 = Ruta+'Actualizador' then
begin


end;
end;

procedure TFActualizador.SHChangeNotify1Delete(Sender: TObject; Flags: Cardinal;
  Path1: String);
begin
ShowMessage(Path1);
end;


procedure TFActualizador.Timer5Timer(Sender: TObject);
begin
//
end;

procedure TFActualizador.IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
 BarraProgreso:= BarraProgreso + AWorkCount; //Trunc(AWorkCount / 5.4);
 //ShowMessage(IntToStr(BarraProgreso));
 //update;
// Gauge1.Progress :=  BarraProgreso;
  ProgressBar1.Position:= AWorkCount;
  
end;

end.
