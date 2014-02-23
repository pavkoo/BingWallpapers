program proBingWallpapers;

uses
  FMX.Forms,
  Main in 'Main.pas' {frmMain},
  XSuperJSON in 'XSuperJSON.pas',
  XSuperObject in 'XSuperObject.pas',
  uConst in 'uConst.pas',
  uBing in 'uBing.pas',
  uUIAdapter in 'uUIAdapter.pas',
  uWebUtils in 'uWebUtils.pas',
  uBingConfig in 'uBingConfig.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
