unit ubingImgSource;

interface

uses
  IdHTTP, Classes, System.SysUtils, uBingConfig, uUIAdapter, FMX.Graphics,
  uBing,
  Generics.Collections, uConst;

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

    procedure GetStreamFromWeb(const url: string;Stream:TStream);
    function GetCurrentBingImageInfo: TBingImageInfo;
    function GetImageUrl:String;
  public
    CurrentBitMap: TBitMap;
    constructor Create;
    destructor Destroy; override;

    procedure DownLoadBingInfo;
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
  CurrentBitMap := TBitmap.Create;
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

function TBingSource.GetImageUrl: String;
begin
  Result:='';
  if CurrentBingImageInfo=nil then  Exit;
  Result:= Format(BINGIMGURL,[CurrentBingImageInfo.UrlBase,FLocalInfo.GetBingWidth,FLocalInfo.GetBingHeight]);
end;

procedure TBingSource.GetStreamFromWeb(const url: string;Stream:TStream);
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
  stream: TStream;
begin
  stream := TStringStream.Create;
  GetStreamFromWeb(FParams.ToString,stream);
  stream.ParseResult(FBingImageInfo);
  if CurrentBingImageInfo = nil then
    Exit;
  if stream<>nil then Freeandnil(stream);
  stream := TMemoryStream.Create;
  GetStreamFromWeb(GetImageUrl,stream);
  if stream<>nil then CurrentBitMap.LoadFromStream(stream);
  if stream<>nil then Freeandnil(stream);
end;

procedure TBingSource.SetCountry(MKT: TBingResquestMkt);
begin
  FParams.MKT := MKT;
  FConfig.ControyCode := Ord(MKT);
end;

end.
