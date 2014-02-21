program Project3;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Overbyte.MessageHandling in 'FMX.Overbyte.MessageHandling.pas',
  FMX.Overbyte.Android.MessageHandling in 'FMX.Overbyte.Android.MessageHandling.pas',
  FMX.Overbyte.Windows.MessageHandling in 'FMX.Overbyte.Windows.MessageHandling.pas',
  FmxMultiplatformPostMessageDemoMain in 'FmxMultiplatformPostMessageDemoMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
