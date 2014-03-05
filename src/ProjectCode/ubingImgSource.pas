unit ubingImgSource;

interface

uses
  IdHTTP, Classes, System.SysUtils, uBingConfig, uUIAdapter, FMX.Graphics,
  uBing,
  Generics.Collections, uConst,System.IOUtils;

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
    FParams: TBingUrlParam;

    procedure GetStreamFromWeb(const url: string; Stream: TStream);
    function GetCurrentBingImageInfo: TBingImageInfo;
    function GetImageUrl: String;
    function GetImageFileName:String;
  public
    CurrentBitMap: TBitMap;
    fileimagePath: String;
    constructor Create;
    destructor Destroy; override;

    procedure DownLoadBingInfo;
    procedure DownLoadPreviousBingInfo;
    procedure DownLoadNextBingInfo;
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
  CurrentBitMap := TBitMap.Create;
  FParams.bingFormat := TBingResponseFormat.brfJson;
  FParams.startDateindex := 0;
  FParams.instanceCount := 1;
  FParams.MKT := TBingResquestMkt(FConfig.ControyCode);
end;

destructor TBingSource.Destroy;
begin
  FLocalInfo.Free;
  FConfig.Free;
  FParams.Free;
  CurrentBitMap.Free;
  inherited;
end;

function TBingSource.GetCurrentBingImageInfo: TBingImageInfo;
begin
  Result := nil;
  if Assigned(FBingImageInfo) and (FBingImageInfo.Count > 0) then
    Result := FBingImageInfo.Items[FBingImageInfo.Count - 1];
end;

function TBingSource.GetImageFileName: String;
var
  temp:TStringList;
begin
  //url eg： http://s.cn.bing.net/az/hprichbg/rb/MontedaRochaDam_ZH-CN8975168542_1366x768.jpg
  //取出MontedaRochaDam_ZH-CN8975168542_1366x768.jpg
  temp:=TStringList.Create;
  temp.Delimiter := '/';
  temp.DelimitedText := CurrentBingImageInfo.Url;

  Result:= temp.Strings[temp.Count-1];
end;

function TBingSource.GetImageUrl: String;
begin
  Result := '';
  if CurrentBingImageInfo = nil then
    Exit;
  Result := Format(BINGIMGURL, [CurrentBingImageInfo.UrlBase,
    FLocalInfo.GetBingWidth, FLocalInfo.GetBingHeight]);
end;

procedure TBingSource.GetStreamFromWeb(const url: string; Stream: TStream);
var
  FHttp: TIdHTTP;
begin
  FHttp := TIdHTTP.Create(nil);
  try
    FHttp.Request.ContentType := 'application/x-www-form-urlencoded';
    FHttp.Get(url, Stream);
  except
    on E: Exception do
    begin
      FHttp.Free;
    end;
  end;
end;

procedure TBingSource.DownLoadBingInfo;
var
  Stream: TStream;
  tempImgUrl: String;
begin
  Stream := TStringStream.Create;
  GetStreamFromWeb(FParams.ToString, Stream);
  Stream.ParseResult(FBingImageInfo);
  if CurrentBingImageInfo = nil then
    Exit;
  if Stream <> nil then
    Freeandnil(Stream);
  tempImgUrl := GetImageUrl;
  // 看本地是否保存有图片
  if (FConfig.LocalImages.IndexOf(GetImageFileName) >= 0) then
  begin
    fileimagePath :=FConfig.GetLocalImage(GetImageFileName);
    if fileimagePath<>'' then CurrentBitMap.LoadFromFile(fileimagePath);
  end
  else
  begin
    Stream := TMemoryStream.Create;
    GetStreamFromWeb(tempImgUrl, Stream);
    if Stream <> nil then
      CurrentBitMap.LoadFromStream(Stream);
    fileimagePath := TPath.Combine(FConfig.ImageFilePath,GetImageFileName);
    FConfig.AddLocalImages(GetImageFileName,fileimagePath);
    CurrentBitMap.SaveToFile(fileimagePath);
    if Stream <> nil then
      Freeandnil(Stream);
  end;
end;

procedure TBingSource.DownLoadNextBingInfo;
begin
  if FParams.startDateindex = 0 then
    Exit
  else
  begin
    FParams.startDateindex := FParams.startDateindex - 1;
    DownLoadBingInfo;
  end;
end;

procedure TBingSource.DownLoadPreviousBingInfo;
begin
  FParams.startDateindex := FParams.startDateindex + 1;
  DownLoadBingInfo;
end;

procedure TBingSource.SetCountry(MKT: TBingResquestMkt);
begin
  FParams.MKT := MKT;
  FConfig.ControyCode := Ord(MKT);
end;

end.
