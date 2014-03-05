program proBingWallpapers;

uses
  FMX.Forms,
  Main in 'Main.pas' {frmMain},
  XSuperJSON in 'XSuperJSON.pas',
  XSuperObject in 'XSuperObject.pas',
  uConst in 'uConst.pas',
  uBing in 'uBing.pas',
  ubingImgSource in 'ubingImgSource.pas',
  uBingConfig in 'uBingConfig.pas',
  AnonThread in 'AnonThread.pas',
  uUIAdapter in 'uUIAdapter.pas',
  uWallpaper in 'uWallpaper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
