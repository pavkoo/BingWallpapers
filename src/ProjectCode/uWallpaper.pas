unit uWallpaper;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.ShellAPI, Winapi.Windows;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
Posix.Stdlib;
{$ENDIF POSIX}


type
  TWallPaper = class
    class procedure SetWallpaper(const imgpath: String);
    class procedure urlOpen(sCommand: string);
  end;

implementation

{ TWallPaper }

class procedure TWallPaper.urlOpen(sCommand: string);
begin
{$IFDEF MSWINDOWS}
  ShellExecute(0, 'OPEN', PChar(sCommand), '', '', SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  _system(PAnsiChar('open ' + AnsiString(sCommand)));
{$ENDIF POSIX}
end;

class procedure TWallPaper.SetWallpaper(const imgpath: String);
begin
  SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, PChar(imgpath),
    SPIF_UPDATEINIFILE);
end;

end.
