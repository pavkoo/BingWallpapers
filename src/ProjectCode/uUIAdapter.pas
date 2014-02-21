unit uUIAdapter;

interface
   uses
     System.Types,FMX.Platform,System.SysUtils,System.Generics.Collections,uConst;


  type
    TUiWindows = class
    private
      FLocaleScreenSize:TPointF;
      FBingSize:TSizeF;
      procedure AdapterScreenSize;
    public
      constructor Create;
      function GetBingWidth:NativeInt;
      function GetBingHeight:NativeInt;
  end;
implementation

{ TUiWindows }



{ TUiWindows }

procedure TUiWindows.AdapterScreenSize;
var
  item:Single;
  i,widthIndex:NativeInt;
  foundHeight:Boolean;
  heightList:TList<Single>;
begin
  widthIndex:=0;
  foundHeight := False;
  //the first Bigger than Screen
  for I := 1 to High(BingSupportedResolution) do
  begin
    if (BingSupportedResolution[i][1]-FLocaleScreenSize.X)>=0 then
    begin
      FBingSize.Width := BingSupportedResolution[i][1];
      widthIndex:=i;
      Break;
    end;
  end;
  //over The Bigest
  if widthIndex=0 then
  begin
    widthIndex:=High(BingSupportedResolution);
    FBingSize.Width := BingSupportedResolution[High(BingSupportedResolution)][1];
  end;

  if foundHeight  then
     FBingSize.Height := FLocaleScreenSize.Y
  else
  begin
    heightList := TList<Single>.Create;
    for i:=widthIndex to High(BingSupportedResolution) do
    begin
      if BingSupportedResolution[i][1]<>FBingSize.Width then Break;
      heightList.Add(BingSupportedResolution[i][2]);
    end;
    heightList.Sort;
    for item in heightList do
    begin
      if (item-FLocaleScreenSize.Y)>=0 then
      begin
        FBingSize.Height := item;
        Break;
      end
      //over The Bigest
      else
        FBingSize.Height := heightList.Items[heightList.Count-1];
    end;
    heightList.Free;
  end;
end;

constructor TUiWindows.Create;
var
  ScreenServices:IFMXScreenService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService) then
  begin
    ScreenServices := TPlatformServices.Current.GetPlatformService(IFMXScreenService) as IFMXScreenService;
    FLocaleScreenSize := ScreenServices.GetScreenSize;
  end;
  AdapterScreenSize;
end;


function TUiWindows.GetBingHeight: NativeInt;
begin
  Result := Trunc(FBingSize.Height);
end;

function TUiWindows.GetBingWidth: NativeInt;
begin
  Result := Trunc(FBingSize.Width);
end;

end.
