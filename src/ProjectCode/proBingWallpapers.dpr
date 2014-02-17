program proBingWallpapers;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {frmMain},
  uBingImageInfo in 'uBingImageInfo.pas',
  XSuperJSON in 'XSuperJSON.pas',
  XSuperObject in 'XSuperObject.pas',
  uConst in 'uConst.pas',
  uWebUtils in 'uWebUtils.pas',
  uUrlParam in 'uUrlParam.pas',
  uDataFetcher in 'uDataFetcher.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
