unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Gestures, System.Actions, FMX.ActnList, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,FMX.Platform, FMX.Layouts, FMX.ExtCtrls,
  FMX.Effects, FMX.Filter.Effects, FMX.Ani, FMX.ListView.Types, FMX.ListView;

type
             //启动    //等待     //主    //bing详细 //选择国家 //关于
  TUIStyle = (TUIFirst,TUIWaiting,TUIMain,TUIDetail,TUICountry,TUIAbout);
  TfrmMain = class(TForm)
    imgMain: TImage;
    GestureManagerMain: TGestureManager;
    ActionListMain: TActionList;
    ActionBack: TAction;
    ActionForawrd: TAction;
    txt1Title: TText;
    lyImageInfo: TLayout;
    txt: TText;
    shdwfct2: TShadowEffect;
    lyDetail: TLayout;
    shdwfct1: TShadowEffect;
    InvertEffect1: TInvertEffect;
    bottomShadow: TRectangle;
    FloatAnimation: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
    procedure lyImageInfoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure lyImageInfoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure lyImageInfoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCurrentUIStyle:TUIStyle;
    ISmouseDown:Boolean;
    procedure SetCurrentUIStyle(const Value:TUIStyle);
    procedure ComponentEnter(const Value: TUIStyle);
    procedure ComponentQuit(const Value: TUIStyle);
  public
    { Public declarations }
    property CurrentUIStyle:TUIStyle read FCurrentUIStyle write SetCurrentUIStyle;
  end;

var
  frmMain: TfrmMain;

const
  ABSPOSITIONYIMAGEINFO = 120;

implementation
{$R *.fmx}

{ TfrmMain }

procedure TfrmMain.ComponentEnter(const Value: TUIStyle);
begin
  case Value of
     TUIFirst:
      begin
      end;
     TUIWaiting:
      begin
      end;
     TUIMain:
      begin
        lyImageInfo.Visible := True;
        lyImageInfo.Position.Y := Self.Height;
        FloatAnimation.PropertyName := 'Position.Y';
        FloatAnimation.Duration := 1;
        FloatAnimation.Delay := 0.5;
        FloatAnimation.Interpolation := TInterpolationType.itLinear;
        FloatAnimation.StartValue := Self.Height;
        FloatAnimation.StopValue := Self.Height -ABSPOSITIONYIMAGEINFO;
        FloatAnimation.Parent :=  lyImageInfo;
        FloatAnimation.Start;
      end;
     TUIDetail:
      begin
      end;
     TUICountry:
      begin
      end;
     TUIAbout:
      begin
      end;
  end;
end;

procedure TfrmMain.ComponentQuit(const Value: TUIStyle);
begin
  case Value of
     TUIFirst:
      begin
      end;
     TUIWaiting:
      begin
      end;
     TUIMain:
      begin
        lyImageInfo.Visible := True;
        lyImageInfo.Position.Y := Self.Height;
        FloatAnimation.PropertyName := 'Position.Y';
        FloatAnimation.Duration := 1;
        FloatAnimation.Interpolation := TInterpolationType.itLinear;
        FloatAnimation.StartValue := lyImageInfo.Position.Y + ABSPOSITIONYIMAGEINFO;
        FloatAnimation.StopValue := Self.Height;
        FloatAnimation.Parent :=  lyImageInfo;
        FloatAnimation.Start;
      end;
     TUIDetail:
      begin
      end;
     TUICountry:
      begin
      end;
     TUIAbout:
      begin
      end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FCurrentUIStyle := TUIFirst;
  ISmouseDown := False;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
  CurrentUIStyle := TUIMain;
end;

procedure TfrmMain.lyImageInfoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbLeft then
    ISmouseDown:= True;
end;

procedure TfrmMain.lyImageInfoMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  if ISmouseDown then
    lyImageInfo.Height := lyImageInfo.Height + (FMouseDownPoint.Y-y);
end;

procedure TfrmMain.lyImageInfoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ISmouseDown := False;
  //should show detail
  if lyImageInfo.Position.Y < ABSPOSITIONYIMAGEINFO then
  begin
    CurrentUIStyle := TUIDetail;
  end
  //hideDetail
  else
  begin
  end;
end;

procedure TfrmMain.SetCurrentUIStyle(const Value: TUIStyle);
begin
  if FCurrentUIStyle<>Value then
  begin
    ComponentQuit(FCurrentUIStyle);
    ComponentEnter(Value);
    FCurrentUIStyle := Value;
  end;
end;


end.
