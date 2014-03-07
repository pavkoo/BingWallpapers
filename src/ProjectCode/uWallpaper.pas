unit uWallpaper;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.ShellAPI, Winapi.Windows;
{$ENDIF MSWINDOWS}
{$IFDEF ANDROID}
FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.Net,
  Androidapi.JNI.JavaTypes, IdUri;
{$ELSE}
{$IFDEF IOS}
iOSapi.Foundation, FMX.Helpers.iOS;
{$ENDIF IOS}
{$ENDIF ANDROID}

type
  TWallPaper = class
    class procedure SetWallpaper(const imgpath: String);
    class procedure urlOpen(sCommand: string);
  end;

implementation

{ TWallPaper }

class procedure TWallPaper.urlOpen(sCommand: string);
{$IFDEF MSWINDOWS}
begin
  ShellExecute(0, 'OPEN', PChar(sCommand), '', '', SW_SHOWNORMAL);
end;
{$ENDIF MSWINDOWS}
{$IFDEF ANDROID}

var
  Intent: JIntent;
begin
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
    TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(sCommand))));
  SharedActivity.startActivity(Intent);
end;
{$ELSE}
{$IFDEF IOS}

var
  NSU: NSUrl;
begin
  NSU := StrToNSUrl(TIdURI.URLEncode(URL));
  if SharedApplication.canOpenURL(NSU) then
    SharedApplication.openUrl(NSU);
end;
{$ELSE}
{$ENDIF IOS}
{$ENDIF ANDROID}

class procedure TWallPaper.SetWallpaper(const imgpath: String);
begin
{$IFDEF MSWINDOWS}
  SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, PChar(imgpath),
    SPIF_UPDATEINIFILE);
{$ENDIF MSWINDOWS}
{$IFDEF ANDROID}
  SharedActivityContext.SetWallpaper(TjBitmapDrawable.JavaClass.init(StringToJString(imgpath))
    .getBitmap);
{$ENDIF ANDROID}
end;

end.
