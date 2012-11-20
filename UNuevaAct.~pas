unit UNuevaAct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, UActualizador, ExtCtrls, ShellApi, ShellCtrls, jpeg;

type
  TFNuevaAct = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNuevaAct: TFNuevaAct;

implementation

{$R *.dfm}

procedure TFNuevaAct.BitBtn1Click(Sender: TObject);

 begin

FNuevaAct.Close;

end;

procedure TFNuevaAct.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FActualizador.Timer4.Enabled:= True;
Action:= Cafree;
end;

procedure TFNuevaAct.BitBtn2Click(Sender: TObject);
begin
Memo1.Visible:= True;
BitBtn2.Visible:= False;
Label3.Visible:= False;
FNuevaAct.Top:= Screen.WorkAreaHeight -191;
FNuevaAct.Left:= Screen.WorkAreaWidth -517;
//Form1.Top:= Screen.WorkAreaHeight +187;
//Form1.Left:= Screen.WorkAreaWidth +597;
end;

end.
