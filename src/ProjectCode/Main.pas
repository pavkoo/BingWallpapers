unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Gestures, System.Actions, FMX.ActnList, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, FMX.Platform, FMX.Layouts, FMX.ExtCtrls,
  FMX.Effects, FMX.Filter.Effects, FMX.Ani, FMX.ListView.Types, FMX.ListView;

type
  // 启动    //等待     //主    //bing详细 //选择国家 //关于
  TUIStyle = (TUIFirst, TUIWaiting, TUIMain, TUIDetail, TUICountry, TUIAbout);

  TfrmMain = class(TForm)
    imgMain: TImage;
    GestureManagerMain: TGestureManager;
    ActionListMain: TActionList;
    ActionBack: TAction;
    ActionForawrd: TAction;
    txt1Title: TText;
    lyImageInfo: TLayout;
    txt: TText;
    lyDetail: TLayout;
    shdwfct1: TShadowEffect;
    InvertEffect1: TInvertEffect;
    bottomShadow: TRectangle;
    FloatAnimationEnter: TFloatAnimation;
    GaussianBlurEffect: TGaussianBlurEffect;
    ActionUp: TAction;
    ActionDown: TAction;
    FloatAnimationExit: TFloatAnimation;
    Desc1: TText;
    Query1: TText;
    Desc3: TText;
    Query2: TText;
    Desc2: TText;
    Query3: TText;
    Desc4: TText;
    Query4: TText;
    RectangleDetail: TRectangle;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    ShadowEffect6: TShadowEffect;
    ShadowEffect7: TShadowEffect;
    ShadowEffect8: TShadowEffect;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle4: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure lyImageInfoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure lyImageInfoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure lyImageInfoMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Single);
    procedure FormShow(Sender: TObject);
    procedure ActionUpExecute(Sender: TObject);
    procedure ActionDownExecute(Sender: TObject);
  private
    { Private declarations }
    FCurrentUIStyle: TUIStyle;
    ISmouseDown: Boolean;
    FMouseDownPoint: TPointf;
    procedure SetCurrentUIStyle(const Value: TUIStyle);
    procedure GoToCurrentUI(const LastUI, CurrentUI: TUIStyle);
  public
    { Public declarations }
    property CurrentUIStyle: TUIStyle read FCurrentUIStyle
      write SetCurrentUIStyle;
  end;

var
  frmMain: TfrmMain;

const
  ABSPOSITIONYIMAGEINFO = 80;
  AniDuiation = 0.5;

implementation

{$R *.fmx}
{ TfrmMain }

procedure TfrmMain.ActionDownExecute(Sender: TObject);
begin
  CurrentUIStyle := TUIMain;
  ISmouseDown := False;
end;

procedure TfrmMain.ActionUpExecute(Sender: TObject);
begin
  CurrentUIStyle := TUIDetail;
  ISmouseDown := False;
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

procedure TfrmMain.GoToCurrentUI(const LastUI, CurrentUI: TUIStyle);
begin
  case CurrentUI of
    TUIMain:
      begin
        GaussianBlurEffect.Enabled := False;
        bottomShadow.Opacity := 0.7;
        if LastUI = TUIFirst then
        begin
          if assigned(FloatAnimationEnter) then
            FloatAnimationEnter.Free;
          FloatAnimationEnter := TFloatAnimation.Create(nil);
          FloatAnimationEnter.Parent := lyImageInfo;
          lyImageInfo.Position.Y := Self.Height;
          FloatAnimationEnter.PropertyName := 'Position.Y';
          FloatAnimationEnter.Duration := AniDuiation;
          FloatAnimationEnter.Delay := AniDuiation;
          FloatAnimationEnter.Interpolation := TInterpolationType.itLinear;
          FloatAnimationEnter.StartValue := Self.Height;
          FloatAnimationEnter.StopValue := Self.Height -
            ABSPOSITIONYIMAGEINFO - 40;
          FloatAnimationEnter.Start;
        end
        else if LastUI = TUIDetail then
        begin
          if assigned(FloatAnimationExit) then
            FloatAnimationExit.Free;
          FloatAnimationExit := TFloatAnimation.Create(nil);
          FloatAnimationExit.Parent := lyImageInfo;
          FloatAnimationExit.PropertyName := 'Height';
          FloatAnimationExit.Duration := AniDuiation;
          FloatAnimationExit.Interpolation := TInterpolationType.itLinear;
          FloatAnimationExit.StartFromCurrent := True;
          FloatAnimationExit.StopValue := ABSPOSITIONYIMAGEINFO;
          FloatAnimationExit.Start;
        end;
      end;
    TUIDetail:
      begin
        GaussianBlurEffect.Enabled := True;
        GaussianBlurEffect.BlurAmount := 1;
        bottomShadow.Opacity := 0.4;
        if LastUI = TUIMain then
        begin
          if assigned(FloatAnimationEnter) then FloatAnimationEnter.Free;
          FloatAnimationEnter := TFloatAnimation.Create(nil);
          FloatAnimationEnter.Parent := lyImageInfo;
          FloatAnimationEnter.PropertyName := 'Height';
          FloatAnimationEnter.Duration := AniDuiation;
          FloatAnimationEnter.Interpolation := TInterpolationType.itLinear;
          FloatAnimationEnter.StartFromCurrent := True;
          FloatAnimationEnter.StopValue := Self.Height - ABSPOSITIONYIMAGEINFO;
          FloatAnimationEnter.Start;
        end;
      end;
  end;
end;

procedure TfrmMain.lyImageInfoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbLeft then
  begin
    ISmouseDown := True;
    FMouseDownPoint.X := X;
    FMouseDownPoint.Y := Y;
  end;
end;

procedure TfrmMain.lyImageInfoMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
begin
  if ISmouseDown then
  begin
    lyImageInfo.Height := lyImageInfo.Height + (FMouseDownPoint.Y - Y);
    GaussianBlurEffect.BlurAmount := 0.01 +
      (Self.Height - lyImageInfo.Position.Y) / Self.Height;
  end;
end;

procedure TfrmMain.lyImageInfoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ISmouseDown := False;
end;

procedure TfrmMain.SetCurrentUIStyle(const Value: TUIStyle);
begin
  if FCurrentUIStyle <> Value then
  begin
    GoToCurrentUI(FCurrentUIStyle, Value);
    FCurrentUIStyle := Value;
  end;
end;

end.
