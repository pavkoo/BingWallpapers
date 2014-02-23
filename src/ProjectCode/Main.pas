unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Gestures, System.Actions, FMX.ActnList, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,FMX.Platform, FMX.Layouts, FMX.ExtCtrls,
  FMX.Effects, FMX.Filter.Effects;

type
  TfrmMain = class(TForm)
    imgMain: TImage;
    GestureManagerMain: TGestureManager;
    ActionListMain: TActionList;
    ActionBack: TAction;
    ActionForawrd: TAction;
    rctngleffect: TRectangle;
    txt1Title: TText;
    lytButtom: TLayout;
    txt: TText;
    shdwfct1: TShadowEffect;
    shdwfct2: TShadowEffect;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.FormResize(Sender: TObject);
begin
  rctngleffect.Width := Self.Width;
  rctngleffect.Position.Y := Self.Height - rctngleffect.Height;
end;

end.
