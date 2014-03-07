unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.IOUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  AndroidApi.Jni.JavaTypes, AndroidApi.Jni.Telephony, FMX.Helpers.Android,
  AndroidApi.Jni.GraphicsContentViewText, FMX.Objects,Androidapi.JNIBridge;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function JBitmapToBitmap(const AImage: JBitmap): TBitmap;
    function BitmapToJBitmap(const AImage: TBitmap): JBitmap;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

function TForm1.BitmapToJBitmap(const AImage: TBitmap): JBitmap;
begin

end;
procedure TForm1.Button1Click(Sender: TObject);
var
  Service: JObject;
  Manager: JTelephonyManager;
  bitmap:JDrawable;
  bitmapclass:TJDrawable;
  bd:TjBitmapDrawable;
  ImageData: TJavaArray<Integer>;
  filePath:String;
begin
  {
    Service := SharedActivityContext.getSystemService(TJContext.JavaClass.TELEPHONY_SERVICE);
    if Service = nil then Exit('');
    Manager := TJTelephonyManager.Wrap((Service as ILocalObject).GetObjectID);
    Result := JStringToString(Manager.getDeviceId);
  }
  filePath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'asdf.jpg');
  Image1.Bitmap.SaveToFile(filePath);
//  bitmap := bitmapclass.JavaClass.createFromPath(StringtoJstring(filePath));
//
//  bitmap :=  bd.JavaClass.createFromPath(StringtoJstring(filePath));
  SharedActivityContext.setWallpaper(bd.JavaClass.init(StringtoJstring(filePath)).getBitmap);

//   SharedActivityContext.setWallpaper(image1.Bitmap.);
//  Service := SharedActivityContext.getSystemService(StringtoJstring('asdf'));
//  if Service = nil then
//    Exit;
  // Manager := TJTelephonyManager.Wrap((Service as ILocalObject).GetObjectID);
  // Result := JStringToString(Manager.getDeviceId);
end;


function TForm1.JBitmapToBitmap(const AImage: JBitmap): TBitmap;
var
  ImageData: TJavaArray<Integer>;
  BitmapData: TBitmapData;
  Width, Height: Integer;
  bit:TBitmap;
begin
  Assert(AImage <> nil);
  Width := AImage.getWidth;
  Height := AImage.getHeight;
  ImageData := TJavaArray<Integer>.Create(Width * Height);
  AImage.getPixels(ImageData, 0, Width, 0, 0, Width, Height);
  bit:=  TBitmap.Create;
  if bit.Map(TMapAccess.maWrite, BitmapData) then
  try
    Result := TBitmap.Create(Width, Height);
    Move(ImageData.Data^, BitmapData.Data^, Width * Height * SizeOf(Integer));
  finally
    Result.Unmap(BitmapData);
  end
  else
    Result := nil;
end;

end.
