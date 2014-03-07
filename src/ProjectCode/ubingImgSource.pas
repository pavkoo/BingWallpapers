unit ubingImgSource;

interface

uses
  IdHTTP, Classes, System.SysUtils, uBingConfig, uUIAdapter, FMX.Graphics,
  uBing,
  Generics.Collections, uConst, System.IOUtils;

type

  {
    数据源提供者
    如果本地有图片，就先从本地区图片
    否则就需要从网络上重新取数据
  }
  TBingSource = class
  private
    FLocalInfo: TBingLocal;
    FConfig: TBingConfiger;
    FBingImageInfo: TList<TBingImageInfo>;
    FDownLoadsBingInfo: TDictionary<string, TBingImageInfo>;
    FParams: TBingUrlParam;
    FCurrentBingImageInfo: TBingImageInfo;
    function GetStreamFromWeb(const url: string; Stream: TStream): Boolean;
    function GetCurrentBingImageInfo: TBingImageInfo;
    function GetImageUrl(BingImageInfo: TBingImageInfo): String;
    function GetImageFileName(BingImageInfo: TBingImageInfo): String;
  public
    fileimagePath: String;
    constructor Create;
    destructor Destroy; override;

    function DownLoadBingInfo: Boolean;
    function DownLoadPreviousBingInfo: Boolean;
    function DownLoadNextBingInfo: Boolean;
    procedure SetCountry(MKT: TBingResquestMkt);
    property CurrentBingImageInfo: TBingImageInfo read GetCurrentBingImageInfo;
  end;

implementation

{ TWeb }

constructor TBingSource.Create;
begin
  FConfig := TBingConfiger.Create;
  FLocalInfo := TBingLocal.Create;
  FParams := TBingUrlParam.Create;
  FParams.bingFormat := TBingResponseFormat.brfJson;
  FParams.startDateindex := 0;
  FParams.instanceCount := 1;
  FParams.MKT := TBingResquestMkt(FConfig.ControyCode);
  FDownLoadsBingInfo := TDictionary<string, TBingImageInfo>.Create;
end;

destructor TBingSource.Destroy;
begin
  FLocalInfo.Free;
  FConfig.Free;
  FParams.Free;
  inherited;
end;

function TBingSource.GetCurrentBingImageInfo: TBingImageInfo;
begin
  Result := FCurrentBingImageInfo;
end;

function TBingSource.GetImageFileName(BingImageInfo: TBingImageInfo): String;
var
  temp: TStringList;
begin
  // url eg： http://s.cn.bing.net/az/hprichbg/rb/MontedaRochaDam_ZH-CN8975168542_1366x768.jpg
  // 取出MontedaRochaDam_ZH-CN8975168542_1366x768.jpg
  temp := TStringList.Create;
  temp.Delimiter := '/';
  temp.DelimitedText := BingImageInfo.url;

  Result := temp.Strings[temp.Count - 1];
end;

function TBingSource.GetImageUrl(BingImageInfo: TBingImageInfo): String;
begin
  Result := '';
  Result := Format(BINGIMGURL, [BingImageInfo.UrlBase, FLocalInfo.GetBingWidth,
    FLocalInfo.GetBingHeight]);
end;

function TBingSource.GetStreamFromWeb(const url: string;
  Stream: TStream): Boolean;
var
  FHttp: TIdHTTP;
begin
  Result := True;
  FHttp := TIdHTTP.Create(nil);
  try
    FHttp.Request.ContentType := 'application/x-www-form-urlencoded';
    FHttp.Get(url, Stream);
  except
    on E: Exception do
    begin
      ErrorString := '访问网络错误！';
      FHttp.Free;
      Result := False;
    end;
  end;
end;

// 每次只下一个图片
function TBingSource.DownLoadBingInfo: Boolean;
var
  Stream: TStream;
  tempImgUrl, ImageFileName: String;
begin
  Result := True;
  if FDownLoadsBingInfo.ContainsKey(FParams.ToString) then
  begin
    FCurrentBingImageInfo := FDownLoadsBingInfo.Items[FParams.ToString];
    Exit;
  end;
  if FBingImageInfo <> nil then
    FBingImageInfo.Clear;
  Stream := TStringStream.Create;
  Result := GetStreamFromWeb(FParams.ToString, Stream);
  if not Result then
    Exit;
  Result := Stream.ParseResult(FBingImageInfo);
  if not Result then
    Exit;
  FCurrentBingImageInfo := FBingImageInfo.Items[0];
  if Stream <> nil then
    Freeandnil(Stream);
  tempImgUrl := GetImageUrl(FCurrentBingImageInfo);
  ImageFileName := GetImageFileName(FCurrentBingImageInfo);
  // 看本地是否保存有图片
  if (FConfig.LocalImages.IndexOf(ImageFileName) >= 0) then
  begin
    fileimagePath := FConfig.GetLocalImage(ImageFileName);
    if fileimagePath <> '' then
    begin
      try
        FCurrentBingImageInfo.bitMap.LoadFromFile(fileimagePath);
        Exit;
      except
        on E: Exception do
      end;
    end;
  end;
  Stream := TMemoryStream.Create;
  Result := GetStreamFromWeb(tempImgUrl, Stream);
  if not Result then
    Exit;
  if Stream <> nil then
    FCurrentBingImageInfo.bitMap.LoadFromStream(Stream);
  fileimagePath := TPath.Combine(FConfig.ImageFilePath, ImageFileName);
  FConfig.AddLocalImages(ImageFileName, fileimagePath);
  FCurrentBingImageInfo.bitMap.SaveToFile(fileimagePath);
  if Stream <> nil then
    Freeandnil(Stream);
  FDownLoadsBingInfo.Add(FParams.ToString, FCurrentBingImageInfo);
end;

function TBingSource.DownLoadNextBingInfo: Boolean;
begin
  if FParams.startDateindex = 0 then
  begin
    Result := False;
    ErrorString := '已经是最新一张了';
    Exit;
  end
  else
  begin
    FParams.startDateindex := FParams.startDateindex - 1;
    Result := DownLoadBingInfo;
  end;
end;

function TBingSource.DownLoadPreviousBingInfo: Boolean;
begin
  // bing 最多只支持17张图片
  if FParams.startDateindex > 17 then
  begin
    Result := False;
    ErrorString := '没有更多壁纸了';
    Exit;
  end;
  FParams.startDateindex := FParams.startDateindex + 1;
  Result:=DownLoadBingInfo;
end;

procedure TBingSource.SetCountry(MKT: TBingResquestMkt);
begin
  FParams.MKT := MKT;
  FConfig.ControyCode := Ord(MKT);
end;

end.
