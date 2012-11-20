unit Actualizador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, IdBaseComponent, IdComponent, IdRawBase, IdRawClient,
  IdIcmpClient, StdCtrls, DB, DBClient, SimpleDS, SqlExpr, Gauges, Buttons;

type
  TForm1 = class(TForm)
    Gauge1: TGauge;
    SQLConnection1: TSQLConnection;
    SimpleDataSet1: TSimpleDataSet;
    Label1: TLabel;
    IdIcmpClient1: TIdIcmpClient;
    BitBtn1: TBitBtn;
    procedure IdIcmpClient1Reply(ASender: TComponent;
      const AReplyStatus: TReplyStatus);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.IdIcmpClient1Reply(ASender: TComponent;
  const AReplyStatus: TReplyStatus);
begin
 if IdIcmpClient1.ReplyStatus.BytesReceived = 0 then
    begin
      Label1.Caption:= 'No Conectado';
    end else begin
      Label1.Caption:= 'Conectado al Servidor';
    end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
IdIcmpClient1.Ping;
end;

end.
