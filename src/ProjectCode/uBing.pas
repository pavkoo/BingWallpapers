unit uBing;

interface

uses
  uConst, Generics.Collections, System.SysUtils,System.Classes,XSuperObject;

type
  TBingResponseFormat = (brfXml, brfJson);
  TBingResquestMkt = (mktUS, mktCN, mktJP, mktAU, mktUK, mktDE, mktNZ, mktCA);

  TBingUrlParam = class
    bingFormat: TBingResponseFormat;
    { The startDateindex parameter tells where you want to start from.
      0 would start at the current day,
      1 the previous day,
      2 the day after that,
      etc.
      For instance,
      if the date were 1/30/2011, using idx = 0, the file would start with 20110130;
      using idx = 1, it would start with 20110129; and so forth. }
    startDateindex: Integer;
    instanceCount: Integer;
    mkt: TBingResquestMkt;
  private
    function getResponseFormat: string;
    function getRequestMkt: String;
  public
    function ToString(): string; override;
  end;

  TBingImageDesc = class
  public
    Desc: String;
    DescQuery: String;
    DescLink: String;
    Constructor Create;
    procedure Clear;
  end;

  TBingImageInfo = class
  public
    StartDate: TDate;
    EndDate: TDate;
    UrlBase: String;
    CopyRight: String;
    CopyRightLink: String;
    ImageTitle: String;
    ImageLink: String;
    DescLists: TList<TBingImageDesc>;
    Constructor Create;
  protected
    destructor Destroy; override;
  public
    procedure Clear;
  end;

  TBingResultParse = class helper for TStream
    procedure ParseResult(var resultList:TList<TBingImageInfo>);
  end;

implementation

{ TBingUrlParam }

function TBingUrlParam.getRequestMkt: String;
begin
  case mkt of
    mktUS:
      Result := SMKTUS;
    mktCN:
      Result := SMKTCN;
    mktJP:
      Result := SMKTJP;
    mktAU:
      Result := SMKTAU;
    mktUK:
      Result := SMKTUK;
    mktDE:
      Result := SMKTDE;
    mktNZ:
      Result := SMKTNZ;
    mktCA:
      Result := SMKTCA;
  end;
end;

function TBingUrlParam.getResponseFormat: string;
begin
  case bingFormat of
    brfXml:
      Result := BingResponseXML;
    brfJson:
      Result := BingResponseJSON;
  end;
end;

function TBingUrlParam.ToString: string;
begin
  Result := Format(BINGIMGSOURCE, [getResponseFormat, startDateindex,
    instanceCount, getRequestMkt]);
end;

{ TBingImageDesc }

procedure TBingImageDesc.Clear;
begin
  Desc := '';
  DescQuery := '';
  DescLink := '';
end;

constructor TBingImageDesc.Create;
begin
  Clear;
end;

{ TBingImageInfo }

procedure TBingImageInfo.Clear;
var
  i: Integer;
begin
  StartDate := 0;
  EndDate := 0;
  UrlBase := '';
  CopyRight := '';
  CopyRightLink := '';
  ImageTitle := '';
  ImageLink := '';
  for i := 0 to DescLists.Count - 1 do
  begin
    if DescLists.Items[i] <> nil then
      DescLists.Delete(i);
  end;
  DescLists := TList<TBingImageDesc>.Create;
end;

constructor TBingImageInfo.Create;
begin
  StartDate := 0;
  EndDate := 0;
  UrlBase := '';
  CopyRight := '';
  CopyRightLink := '';
  ImageTitle := '';
  ImageLink := '';
  DescLists := TList<TBingImageDesc>.Create;
end;

destructor TBingImageInfo.Destroy;
var
  i: Integer;
begin
  for i := 0 to DescLists.Count - 1 do
  begin
    if DescLists.Items[i] <> nil then
      DescLists.Delete(i);
  end;
  DescLists.Free;
  inherited;
end;

{ TBingResultParse }


procedure TBingResultParse.ParseResult(var resultList:TList<TBingImageInfo>);
var
  StringStream:TStringStream;
  bingInfo:TBingImageInfo;
  bingInfoDesc:TBingImageDesc;
  iso,desc,item,descItem:ISuperObject;
  itemcast,descCast:ICast;
begin
  Assert(Self<>nil,'传入需要转换的Stream');
  if resultList=nil then resultList.Create;
  try
    StringStream := TStringStream.Create;
    StringStream.LoadFromStream(Self);
    iso := SO(StringStream.DataString);

    for itemcast in iso do
    begin
      item := itemcast.AsObject;
      bingInfo := TBingImageInfo.Create;
      bingInfo.StartDate := StrToDateDef(item['startdate'].AsString,Now);
      bingInfo.EndDate := StrToDateDef(item['enddate'].AsString,Now);
      bingInfo.UrlBase :=  item['urlBase'].AsString;
      bingInfo.CopyRight := item['copyright'].AsString;
      bingInfo.CopyRightLink := item['copyrightlink'].AsString;
      bingInfo.ImageTitle := item['messages.message.msgtext'].AsString;
      bingInfo.ImageTitle := item['messages.message.msglink'].AsString;
      desc := SO( item['hotspots'].AsString);
      for descCast in desc do
      begin
        descItem := descCast.AsObject;
        bingInfoDesc := TBingImageDesc.Create;
        bingInfoDesc.Desc := descItem['desc'].AsString;
        bingInfoDesc.DescLink := descItem['link'].AsString;
        bingInfoDesc.DescQuery := descItem['query'].AsString;
        bingInfo.DescLists.Add(bingInfoDesc);
      end;
      resultList.Add(bingInfo);
    end;
  finally
    StringStream.Free;
  end;
end;

end.
