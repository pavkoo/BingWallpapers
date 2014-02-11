program JsonTesting;

uses
  FMX.Forms,
  untMain in 'untMain.pas' {frmMain} ,
  SuperObject in 'SuperObject.pas',
  UnitChinaWeather in 'UnitChinaWeather.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
