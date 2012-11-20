object Form1: TForm1
  Left = 424
  Top = 137
  Width = 545
  Height = 157
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 0
    Top = 40
    Width = 537
    Height = 28
    ForeColor = 16744448
    Progress = 10
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 4
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 168
    Top = 96
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'IBConnection'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=10.0.0.15:D:\Easy System News\DATA.FDB'
      'RoleName=RoleName'
      'User_Name=SYSDBA'
      'Password=juan173mateo69'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=True')
    VendorLib = 'gds32.dll'
    Connected = True
    Left = 392
    Top = 8
  end
  object SimpleDataSet1: TSimpleDataSet
    Aggregates = <>
    Connection = SQLConnection1
    DataSet.Active = True
    DataSet.CommandText = 'select * from ALEATORIO'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 432
    Top = 8
  end
  object IdIcmpClient1: TIdIcmpClient
    Host = '10.0.0.15'
    Port = 21
    OnReply = IdIcmpClient1Reply
    Left = 472
    Top = 8
  end
end
