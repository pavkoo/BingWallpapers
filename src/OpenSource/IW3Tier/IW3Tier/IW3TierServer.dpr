program IW3TierServer;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  ServerUnit1 in 'ServerUnit1.pas' {IWForm2: TIWAppForm},
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  superobject in 'CommonFiles\superobject.pas',
  ADOToXML in 'CommonFiles\ADOToXML.pas';

{$R *.res}

begin
  TIWStart.Execute(True);
end.
