program proBingWallpapers;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {frmMain},
  uBingImageInfo in 'uBingImageInfo.pas',
  XSuperJSON in 'XSuperJSON.pas',
  XSuperObject in 'XSuperObject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
