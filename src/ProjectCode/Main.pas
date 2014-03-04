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
  FMX.Viewport3D, FMX.MaterialSources,FMX.Types3D,System.UIConsts,AnonThread,
  ubingImgSource,uConst,XsuperJSon,XSuperObject;

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
    FadeTransitionEffect: TFadeTransitionEffect;
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
    imgBackground: TImage;
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
    procedure imgBackgroundClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FCurrentUIStyle: TUIStyle;
    ISmouseDown: Boolean;
    Filter: TFilter;
    FMouseDownPoint: TPointf;
    TransitionAni: TFloatAnimation;
    FThread: TAnonymousThread<Boolean>;
    FBingImageSource:TBingSource;
    procedure SetCurrentUIStyle(const Value: TUIStyle);
    procedure GoToCurrentUI(const LastUI, CurrentUI: TUIStyle);
    procedure ShowTitleBar;
    procedure HideTitleBar;
    procedure TransitionAniOnProgress(Sender: TObject);
    procedure DisplayBingInfo;
  public
    { Public declarations }
    property CurrentUIStyle: TUIStyle read FCurrentUIStyle
      write SetCurrentUIStyle;
  end;

var
  frmMain: TfrmMain;

const
  ABSPOSITIONYIMAGEINFO = 100;
  AniDuiation = 0.5;

implementation

{$R *.fmx}
{ TfrmMain }

procedure TfrmMain.ActionhideCountryExecute(Sender: TObject);
begin
  CurrentUIStyle := TUIMain;
end;

procedure TfrmMain.ActionBackExecute(Sender: TObject);
begin
  // 创建线程
  CurrentUIStyle := TUIWaiting;
  CurrentUIStyle := TUIMain
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

procedure TfrmMain.DisplayBingInfo;
begin
  imgSource.Bitmap.Assign(imgMain.Bitmap);
  imgTarget.Bitmap.Assign(FBingImageSource.CurrentBitMap);
  txtTitle.Text := FBingImageSource.CurrentBingImageInfo.ImageTitle;
  txtCopyright.Text := FBingImageSource.CurrentBingImageInfo.CopyRight;

  Desc1.Text := FBingImageSource.CurrentBingImageInfo.DescLists[0].Desc;
  Desc2.Text := FBingImageSource.CurrentBingImageInfo.DescLists[1].Desc;
  Desc3.Text := FBingImageSource.CurrentBingImageInfo.DescLists[2].Desc;
  Desc4.Text := FBingImageSource.CurrentBingImageInfo.DescLists[3].Desc;

  Query1.Text :=FBingImageSource.CurrentBingImageInfo.DescLists[0].DescQuery;
  Query2.Text :=FBingImageSource.CurrentBingImageInfo.DescLists[1].DescQuery;
  Query3.Text :=FBingImageSource.CurrentBingImageInfo.DescLists[2].DescQuery;
  Query4.Text :=FBingImageSource.CurrentBingImageInfo.DescLists[3].DescQuery;
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
  FBingImageSource:=TBingSource.Create;
  FThread := TAnonymousThread<Boolean>.Create(
    //线程函数
    function :Boolean
    begin
      FBingImageSource.DownLoadBingInfo;
    end,
    procedure(AResult:Boolean)
    begin
      CurrentUIStyle := TUIMain;
    end,
    nil
  );
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

          imgMain.WrapMode := TImageWrapMode.iwCenter;
          imgMain.Bitmap := ImgTarget.Bitmap;

          lyImageInfo.Position.Y := Self.Height;
          lyImageInfo.Visible := True;

          ShowTitleBar;
        end
        else if LastUI = TUIDetail then
        begin
          lyImageInfo.AnimateFloat('Height', ABSPOSITIONYIMAGEINFO,
            AniDuiation,TAnimationType.atOut,TInterpolationType.itBack);
        end
        else if LastUI = TUIWaiting then
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
          TransitionAni := TFloatAnimation.Create(button1);
          TransitionAni.OnProcess := TransitionAniOnProgress;
          TransitionAni.Parent := button1;
          TransitionAni.StartValue := 0;
          TransitionAni.StopValue := 100;
          TransitionAni.PropertyName := 'Width';
          TransitionAni.Duration := AniDuiation * 2;
          TransitionAni.Enabled := True;
          TransitionAni.Start;

          ShowTitleBar;
        end
        else if LastUI = TUICountry then
        begin
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
        GaussianBlurEffect.AnimateFloat('BlurAmount',1,AniDuiation);
        bottomShadow.Opacity := 0.4;
        if LastUI = TUIMain then
        begin
          lyImageInfo.AnimateFloat('Height',
            Self.Height - ABSPOSITIONYIMAGEINFO, AniDuiation,TAnimationType.atOut,TInterpolationType.itBack);
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
        lyImageInfo.AnimateFloatWait('Position.Y', Self.Height, AniDuiation);
        lyImageInfo.Visible := False;
        LayoutCountry.AnimateFloat('Opacity', 1, AniDuiation);
        LayoutCountry.AnimateFloatWait('Height', Self.Height - ABSPOSITIONYIMAGEINFO, AniDuiation,TAnimationType.atInOut,TInterpolationType.itBack);
      end;
  end;
end;

procedure TfrmMain.HideTitleBar;
begin
  LayoutSetting.AnimateFloat('RotationAngle',-90,AniDuiation,TAnimationType.atIn,TInterpolationType.itBack);
  lyImageInfo.AnimateFloatDelay('Position.Y', Self.Height, AniDuiation,0.2);
end;

procedure TfrmMain.imgBackgroundClick(Sender: TObject);
begin
  InnerGlowEffectMain.Enabled := True;
  InnerGlowEffectMain.AnimateFloatWait('Softness',9,AniDuiation*2);
  //shezhibizhi
  InnerGlowEffectMain.AnimateFloatWait('Softness',0,AniDuiation*2);
  InnerGlowEffectMain.Enabled := False;
end;

procedure TfrmMain.imgEarthClick(Sender: TObject);
begin
  CurrentUIStyle := TUICountry;
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

procedure TfrmMain.ShowTitleBar;
begin
  lyImageInfo.Position.Y := Self.Height;
  lyImageInfo.AnimateFloat('Position.Y',
    Self.Height - ABSPOSITIONYIMAGEINFO - 40,  AniDuiation,TAnimationType.atInOut,TInterpolationType.itBack);
  LayoutSetting.AnimateFloatDelay('RotationAngle',0,AniDuiation,0.2,TAnimationType.atInOut,TInterpolationType.itBack);
end;

procedure TfrmMain.TransitionAniOnProgress(Sender: TObject);
begin
  Filter.ValuesAsFloat['Progress'] := Button1.Width;
  imgMain.Bitmap := Filter.ValuesAsBitmap['output'];
end;

end.
