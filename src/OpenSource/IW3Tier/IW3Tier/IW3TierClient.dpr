program IW3TierClient;

uses
  Vcl.Forms,
  ClientUnit1 in 'ClientUnit1.pas' {Form3},
  superobject in 'CommonFiles\superobject.pas',
  ADOToXML in 'CommonFiles\ADOToXML.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
