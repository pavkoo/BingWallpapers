unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Gestures, System.Actions, FMX.ActnList, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, FMX.Platform, FMX.Layouts, FMX.ExtCtrls,
  FMX.Effects, FMX.Filter.Effects, FMX.Ani, FMX.ListView.Types, FMX.ListView,
  FMX.StdCtrls, FMX.Filter, FMX.Controls3D, FMX.Layers3D, FMX.Objects3D,
  FMX.Viewport3D, FMX.MaterialSources, FMX.Types3D, System.UIConsts, AnonThread,
  ubingImgSource, uConst, XsuperJSon, XSuperObject, System.IOUtils, uWallpaper;

type
               // 启动    //等待     //主    //bing详细 //选择国家 //关于
  TUIStyle = (TUIFirst, TUIWaiting, TUIMain, TUIDetail, TUICountry, TUIAbout);

  TfrmMain = class(TForm)
    imgMain: TImage;
    GestureManagerMain: TGestureManager;
    ActionListMain: TActionList;
    ActionBack: TAction;
    ActionForawrd: TAction;
    txtTitle: TText;
    lyImageInfo: TLayout;
    txtCopyright: TText;
    lyDetail: TLayout;
    shdwfct1: TShadowEffect;
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
    RippleEffect: TRippleEffect;
    RippleFloatAnimation: TFloatAnimation;
    FloatAnimationAmplitude: TFloatAnimation;
    imgTarget: TImage;
    imgSource: TImage;
    Viewport3D: TViewport3D;
    earth: TSphere;
    FloatAnimation1: TFloatAnimation;
    LightMaterialSource1: TLightMaterialSource;
    Light1: TLight;
    ShadowEffect9: TShadowEffect;
    LayoutSetting: TLayout;
    imgEarth: TImage;
    LayoutCountry: TLayout;
    Camera1: TCamera;
    ShadowEffect10: TShadowEffect;
    rectBK: TRectangle;
    txtJP: TText;
    ActionhideCountry: TAction;
    ActionCountryDown: TAction;
    txtCa: TText;
    txtDe: TText;
    txtUs: TText;
    txtEng: TText;
    txtNZ: TText;
    txtAU: TText;
    rectLine: TRectangle;
    Rectangle6: TRectangle;
    Rectangle9: TRectangle;
    Rectangle11: TRectangle;
    Rectangle12: TRectangle;
    LayoutList: TLayout;
    Rectangle3: TRectangle;
    Rectangle8: TRectangle;
    InnerGlowEffectMain: TInnerGlowEffect;
    Button1: TButton;
    ShadowEffect11: TShadowEffect;
    txtChina: TText;
    Rectangle7: TRectangle;
    Rectsettingbk: TRectangle;
    imgBackground: TImage;
    txtCountry: TText;
    txtPin: TText;
    rectConutry: TRectangle;
    rectPin: TRectangle;
    txtError: TText;
    Image1: TImage;
    FloatAnimation2: TFloatAnimation;
    Layout1: TLayout;
    Rectangle5: TRectangle;
    Rectangle10: TRectangle;
    actionLeft: TImage;
    actionRight: TImage;
    imgMail: TImage;
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
    procedure ActionBackExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ActionForawrdExecute(Sender: TObject);
    procedure ActionhideCountryExecute(Sender: TObject);
    procedure ActionCountryDownExecute(Sender: TObject);
    procedure imgEarthClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imgBackgroundClick(Sender: TObject);
    procedure txtAUClick(Sender: TObject);
    procedure Desc1Click(Sender: TObject);
    procedure imgMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Button2Click(Sender: TObject);
    procedure actionLeftClick(Sender: TObject);
    procedure actionRightClick(Sender: TObject);
    procedure imgMailClick(Sender: TObject);
  private
    { Private declarations }
    FCurrentUIStyle: TUIStyle;
    ISmouseDown: Boolean;
    Filter: TFilter;
    FMouseDownPoint: TPointf;
    TransitionAni: TFloatAnimation;
    FThread: TAnonymousThread<Boolean>;
    FBingImageSource: TBingSource;
    procedure SetCurrentUIStyle(const Value: TUIStyle);
    procedure GoToCurrentUI(const LastUI, CurrentUI: TUIStyle);
    procedure ShowTitleBar;
    procedure HideTitleBar;
    procedure TransitionAniOnProgress(Sender: TObject);
    procedure DisplayBingInfo;
    procedure RippleChangeImg;
    procedure ShowMessage(const ErrorMsg: String;LongMsg:Boolean=False);
  public
    { Public declarations }
    property CurrentUIStyle: TUIStyle read FCurrentUIStyle
      write SetCurrentUIStyle;
  end;

var
  frmMain: TfrmMain;

const
  ABSPOSITIONYIMAGEINFO = 90;
  AniDuiation = 0.3;
  ERRORMESSAGESHOWTIME = 3;

implementation

{$R *.fmx}


{ TfrmMain }

procedure TfrmMain.ActionhideCountryExecute(Sender: TObject);
begin
  CurrentUIStyle := TUIMain;
end;

procedure TfrmMain.ActionBackExecute(Sender: TObject);
begin
  CurrentUIStyle := TUIWaiting;
  FThread := TAnonymousThread<Boolean>.Create(
    // 线程函数
    function: Boolean
    begin
      Result := FBingImageSource.DownLoadPreviousBingInfo;
    end,
    procedure(AResult: Boolean)
    begin
      CurrentUIStyle := TUIMain;
      if not AResult then
        ShowMessage(ErrorString);
    end, nil);
end;

procedure TfrmMain.ActionCountryDownExecute(Sender: TObject);
begin
  CurrentUIStyle := TUICountry;
end;

procedure TfrmMain.ActionDownExecute(Sender: TObject);
begin
  CurrentUIStyle := TUIMain;
  ISmouseDown := False;
end;

procedure TfrmMain.ActionForawrdExecute(Sender: TObject);
begin
  CurrentUIStyle := TUIWaiting;
  FThread := TAnonymousThread<Boolean>.Create(
  // 线程函数
    function: Boolean
    begin
      Result := FBingImageSource.DownLoadNextBingInfo;
    end,
    procedure(AResult: Boolean)
    begin
      CurrentUIStyle := TUIMain;
      if not AResult then
        ShowMessage(ErrorString);
    end, nil);
end;

procedure TfrmMain.ActionUpExecute(Sender: TObject);
begin
  CurrentUIStyle := TUIDetail;
  ISmouseDown := False;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  CurrentUIStyle := TUIMain;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  ShowMessage('asdfasdfasdf');
end;

procedure TfrmMain.Desc1Click(Sender: TObject);
begin
  if Sender is TText then
    if FBingImageSource.CurrentBingImageInfo.DescLists.Count > TText(Sender).Tag
    then
      TWallpaper.urlOpen(FBingImageSource.CurrentBingImageInfo.DescLists
        [TText(Sender).Tag].DescLink);
end;

procedure TfrmMain.DisplayBingInfo;
begin
  imgSource.Bitmap.Assign(imgMain.Bitmap);
  imgTarget.Bitmap.Assign(FBingImageSource.CurrentBingImageInfo.Bitmap);
  Filter.ValuesAsBitmap['Input'] := imgSource.Bitmap;
  Filter.ValuesAsBitmap['Target'] := imgTarget.Bitmap;
  txtTitle.Text := FBingImageSource.CurrentBingImageInfo.ImageTitle;
  txtTitle.UpdateEffects;
  txtCopyright.Text := FBingImageSource.CurrentBingImageInfo.CopyRight;
  txtCopyright.UpdateEffects;
  //Shit Code Comming ^.^
  if FBingImageSource.CurrentBingImageInfo.DescLists.Count = 0 then
  begin
    Desc1.Text := '';
    Desc1.UpdateEffects;
    Query1.Text := '';
    Query1.UpdateEffects;

    Desc2.Text := '';
    Desc2.UpdateEffects;
    Query2.Text :='';
    Query2.UpdateEffects;

    Desc3.Text := '';
    Desc3.UpdateEffects;
    Query3.Text := '';
    Query3.UpdateEffects;

    Desc4.Text := '';
    Desc4.UpdateEffects;
    Query4.Text := '';
    Query4.UpdateEffects;
    exit;
  end;

  Desc1.Text := FBingImageSource.CurrentBingImageInfo.DescLists[0].Desc;
  Desc1.UpdateEffects;
  Query1.Text := FBingImageSource.CurrentBingImageInfo.DescLists[0].DescQuery;
  Query1.UpdateEffects;

  Desc2.Text := FBingImageSource.CurrentBingImageInfo.DescLists[1].Desc;
  Desc2.UpdateEffects;
  Query2.Text := FBingImageSource.CurrentBingImageInfo.DescLists[1].DescQuery;
  Query2.UpdateEffects;

  Desc3.Text := FBingImageSource.CurrentBingImageInfo.DescLists[2].Desc;
  Desc3.UpdateEffects;
  Query3.Text := FBingImageSource.CurrentBingImageInfo.DescLists[2].DescQuery;
  Query3.UpdateEffects;

  Desc4.Text := FBingImageSource.CurrentBingImageInfo.DescLists[3].Desc;
  Desc4.UpdateEffects;
  Query4.Text := FBingImageSource.CurrentBingImageInfo.DescLists[3].DescQuery;
  Query4.UpdateEffects;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FCurrentUIStyle := TUIFirst;
  ISmouseDown := False;
  Filter := TFilterManager.FilterByName('FadeTransition');
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Filter.Free;
  FBingImageSource.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  application.ProcessMessages;
  FBingImageSource := TBingSource.Create;
  FThread := TAnonymousThread<Boolean>.Create(
  // 线程函数
    function: Boolean
    begin
      Result := FBingImageSource.DownLoadBingInfo;
    end,
    procedure(AResult: Boolean)
    begin
      if AResult then
        CurrentUIStyle := TUIMain
      else
        ShowMessage(ErrorString);
    end, nil);
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
          DisplayBingInfo;

          imgMain.WrapMode := TImageWrapMode.iwOriginal;
          imgMain.Bitmap := imgTarget.Bitmap;

          lyImageInfo.Opacity := 0;
          lyImageInfo.Visible := True;
          lyImageInfo.Position.Y := Self.Height;
          lyImageInfo.Opacity := 1;

          ShowTitleBar;
        end
        else if LastUI = TUIDetail then
        begin
          lyImageInfo.AnimateFloat('Height', ABSPOSITIONYIMAGEINFO, AniDuiation,
            TAnimationType.atOut, TInterpolationType.itBack);
        end
        else if LastUI = TUIWaiting then
        begin
          DisplayBingInfo;

          RippleChangeImg;
          ShowTitleBar;
        end
        else if LastUI = TUICountry then
        begin
          DisplayBingInfo;
          RippleChangeImg;
          LayoutCountry.AnimateFloat('Opacity', 0, AniDuiation);
          LayoutCountry.AnimateFloatWait('Height', 0, AniDuiation);
          // 上面那个动画，会导致lyImageInfo控件去执行relaign方法，使得lyImageInfo的位置可见
          lyImageInfo.Opacity := 0;
          lyImageInfo.Visible := True;
          lyImageInfo.Position.Y := Self.Height;
          lyImageInfo.Opacity := 1;
          ShowTitleBar;
        end;
      end;
    TUIDetail:
      begin
        GaussianBlurEffect.Enabled := True;
        GaussianBlurEffect.AnimateFloat('BlurAmount', 1, AniDuiation);
        bottomShadow.Opacity := 0.4;
        if LastUI = TUIMain then
        begin
          lyImageInfo.AnimateFloat('Height',
            Self.Height - ABSPOSITIONYIMAGEINFO, AniDuiation,
            TAnimationType.atOut, TInterpolationType.itBack);
        end;
      end;
    TUIWaiting:
      begin
        if LastUI = TUIMain then
        begin
          GaussianBlurEffect.Enabled := False;
          HideTitleBar;
          RippleEffect.Enabled := True;

          FloatAnimationAmplitude.Inverse := False;
          FloatAnimationAmplitude.Enabled := True;
          FloatAnimationAmplitude.StartValue := 0;
          FloatAnimationAmplitude.StopValue := 0.12;
          FloatAnimationAmplitude.Duration := AniDuiation * 5;
          FloatAnimationAmplitude.Delay := AniDuiation;
          FloatAnimationAmplitude.Start;

          RippleFloatAnimation.Duration := AniDuiation * 5;
          RippleFloatAnimation.Enabled := True;
          RippleFloatAnimation.Loop := True;
          RippleFloatAnimation.Start;
        end;
      end;
    TUICountry:
      begin
        HideTitleBar;
        lyImageInfo.Visible := False;
        LayoutCountry.AnimateFloat('Opacity', 1, AniDuiation);
        LayoutCountry.AnimateFloatWait('Height',
          Self.Height - ABSPOSITIONYIMAGEINFO, AniDuiation,
          TAnimationType.atInOut, TInterpolationType.itBack);
      end;
  end;
end;

procedure TfrmMain.HideTitleBar;
begin
  LayoutSetting.AnimateFloatWait('Height', 0, 0.1);
  lyImageInfo.AnimateFloatWait('Position.Y', Self.Height, AniDuiation);
end;

procedure TfrmMain.actionLeftClick(Sender: TObject);
begin
  ActionBackExecute(ActionBack);
end;

procedure TfrmMain.actionRightClick(Sender: TObject);
begin
  ActionForawrdExecute(ActionForawrd);
end;

procedure TfrmMain.imgBackgroundClick(Sender: TObject);
begin
  RippleEffect.Enabled := False;
  InnerGlowEffectMain.Enabled := True;
  InnerGlowEffectMain.AnimateFloatWait('Softness', 9, AniDuiation * 2);
  TWallpaper.SetWallpaper(FBingImageSource.fileimagePath);
  InnerGlowEffectMain.AnimateFloatWait('Softness', 0, AniDuiation * 2);
  InnerGlowEffectMain.Enabled := False;
end;

procedure TfrmMain.imgEarthClick(Sender: TObject);
begin
  CurrentUIStyle := TUICountry;
end;

procedure TfrmMain.imgMailClick(Sender: TObject);
begin
  Showmessage('感谢您的支持！！！如果亲有什么建议,请与我联系(Pavkoo@live.com)  ^.^',True);
end;

procedure TfrmMain.imgMainMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Single);
begin
  if (CurrentUIStyle <> TUIMain) then
  begin
    if imgMain.PointInObject(X, Y) then
      CurrentUIStyle := TUIMain;
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
    Self.SetCaptured(TFmxObject(Sender).AsIControl);
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
    Self.ReleaseCapture;
  end;
end;

procedure TfrmMain.lyImageInfoMouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Single);
begin
  ISmouseDown := False;
end;

procedure TfrmMain.RippleChangeImg;
begin
  RippleFloatAnimation.Stop;
  RippleEffect.Phase := 0;
  FloatAnimationAmplitude.Delay := 0;
  FloatAnimationAmplitude.Duration := AniDuiation;
  FloatAnimationAmplitude.StopValue := 0;
  FloatAnimationAmplitude.StartFromCurrent := True;
  FloatAnimationAmplitude.Start;

  if (TransitionAni <> nil) then
    FreeAndNil(TransitionAni);
  TransitionAni := TFloatAnimation.Create(Button1);
  TransitionAni.OnProcess := TransitionAniOnProgress;
  TransitionAni.Parent := Button1;
  TransitionAni.StartValue := 0;
  TransitionAni.StopValue := 100;
  TransitionAni.PropertyName := 'Width';
  TransitionAni.Duration := AniDuiation * 3;
  TransitionAni.Enabled := True;
  TransitionAni.Start;
end;

procedure TfrmMain.SetCurrentUIStyle(const Value: TUIStyle);
begin
  if FCurrentUIStyle <> Value then
  begin
    GoToCurrentUI(FCurrentUIStyle, Value);
    FCurrentUIStyle := Value;
  end;
end;



procedure TfrmMain.ShowMessage(const ErrorMsg: String;LongMsg:Boolean=False);
var
  OrgColor: TAlphaColor;
begin
  OrgColor := Rectsettingbk.Fill.Color;
  rectPin.AnimateFloat('Opacity', 0, AniDuiation);
  rectConutry.AnimateFloatWait('Opacity', 0, AniDuiation);
  Rectsettingbk.AnimateColor('Fill.Color', TAlphaColorRec.Red, AniDuiation);
  txtError.Text := ErrorMsg;
  txtError.AnimateFloat('Width', Rectsettingbk.Width);

  if LongMsg then

  txtError.AnimateFloatWait('Opacity', 0.9, 2*ERRORMESSAGESHOWTIME,
    TAnimationType.atInOut, TInterpolationType.itCircular)
  else
  txtError.AnimateFloatWait('Opacity', 0.9, ERRORMESSAGESHOWTIME,
    TAnimationType.atInOut, TInterpolationType.itCircular);

  txtError.AnimateFloatWait('Width', 0, AniDuiation);
  txtError.Text := '';
  Rectsettingbk.AnimateColor('Fill.Color', OrgColor, AniDuiation);
  rectConutry.AnimateFloatWait('Opacity', 1, AniDuiation);
  rectPin.AnimateFloatWait('Opacity', 1, AniDuiation);
end;

procedure TfrmMain.ShowTitleBar;
begin
  lyImageInfo.Position.Y := Self.Height;
  lyImageInfo.AnimateFloat('Position.Y', Self.Height - ABSPOSITIONYIMAGEINFO -40, AniDuiation, TAnimationType.atInOut, TInterpolationType.itBack);
  LayoutSetting.AnimateFloatDelay('Height', 20, AniDuiation, 0.2,
    TAnimationType.atInOut, TInterpolationType.itBack);
  Rectsettingbk.AnimateColor('Fill.Color', Random(High(TColor)), AniDuiation);
end;

procedure TfrmMain.TransitionAniOnProgress(Sender: TObject);
begin
  Filter.ValuesAsFloat['Progress'] := Button1.Width;
  imgMain.Bitmap := Filter.ValuesAsBitmap['output'];
end;

procedure TfrmMain.txtAUClick(Sender: TObject);
begin
  FBingImageSource.SetCountry(TBingResquestMkt(TText(Sender).Tag));
  FThread := TAnonymousThread<Boolean>.Create(
  // 线程函数
    function: Boolean
    begin
      Result := FBingImageSource.DownLoadBingInfo;
    end,
    procedure(AResult: Boolean)
    begin
      CurrentUIStyle := TUIMain;
      if not AResult then
        ShowMessage(ErrorString);
    end, nil);
end;

end.
