unit ServerController;

interface

uses
  SysUtils, Classes, IWServerControllerBase, IWBaseForm, HTTPApp,
  // For OnNewSession Event
  IW.Http.Request, IW.HTTP.Reply,
  UserSessionUnit, IWApplication, IWAppForm, IW.Browser.Other,
  IW.Browser.Browser, IWURLResponderBase, IWURLResponder;

type
  TIWServerController = class(TIWServerControllerBase)
    IWURLResponderEvent1: TIWURLResponderEvent;
    procedure IWServerControllerBaseNewSession(ASession: TIWApplication;
      var VMainForm: TIWBaseForm);
    function IWURLResponderEvent1Request(aApplication: TIWApplication;
      aRequest: THttpRequest; aResponse: THttpReply): Boolean;
    procedure IWServerControllerBaseBrowserCheck(aSession: TIWApplication;
      var rBrowser: TBrowser);
  private
    function SessionCount: Integer;
  public
  end;

function UserSession: TIWUserSession;
function IWServerController: TIWServerController;

implementation

{$R *.dfm}

uses
  IWInit, IWGlobal, IW.Browser.InternetExplorer, IW.Browser.Safari, Variants,
  IW.Browser.Chrome, IW.Browser.Firefox, superobject, DB, ADODB, ADOInt,
  ADOToXML;

function IWServerController: TIWServerController;
begin
  Result := TIWServerController(GServerController);
end;

function UserSession: TIWUserSession;
begin
  Result := TIWUserSession(WebApplication.Data);
end;

procedure TIWServerController.IWServerControllerBaseBrowserCheck(
  aSession: TIWApplication; var rBrowser: TBrowser);
var
  MinVersion: Single;
begin
  if (rBrowser is TOther) then begin
    // unknown browser
    rBrowser.Free;
    // accept the unknown browser as Internet Explorer 8
    rBrowser := TInternetExplorer.Create(8);
  end
  else if (rBrowser is TSafari) and (not rBrowser.IsSupported) then begin
    // if is Safari, but older version
    MinVersion := rBrowser.MinSupportedVersion;
    rBrowser.Free;
    // we will create it as the minimum supported version
    rBrowser := TSafari.Create(MinVersion);
  end
  // if is Chrome, but older version
  else if (rBrowser is TChrome) and (not rBrowser.IsSupported) then begin
    MinVersion := rBrowser.MinSupportedVersion;
    rBrowser.Free;
    // we will create it as the minimum supported version
    rBrowser := TChrome.Create(MinVersion);
  end
  // if is Firefox, but older version
  else if (rBrowser is TFirefox) and (not rBrowser.IsSupported) then begin
    MinVersion := rBrowser.MinSupportedVersion;
    rBrowser.Free;
    // we will create it as the minimum supported version
    rBrowser := TFirefox.Create(MinVersion);
  end
  // if is IE, but older version
  else if (rBrowser is TInternetExplorer) and (not rBrowser.IsSupported) then
  begin
    MinVersion := rBrowser.MinSupportedVersion;
    rBrowser.Free;
    // we will create it as the minimum supported version
    rBrowser := TInternetExplorer.Create(MinVersion);
  end;
end;

procedure TIWServerController.IWServerControllerBaseNewSession(
  ASession: TIWApplication; var VMainForm: TIWBaseForm);
begin
  ASession.Data := TIWUserSession.Create(nil);
end;

function TIWServerController.SessionCount: Integer;
begin
  Result := GSessions.LockList.Count;
  GSessions.UnLockList;
end;

function TIWServerController.IWURLResponderEvent1Request(
  aApplication: TIWApplication; aRequest: THttpRequest;
  aResponse: THttpReply): Boolean;
var
  oParams, oResult: ISuperObject;
  aRows: OleVariant;
  cFunc: string;
  nTotal, nSkip, nPageNo, nPageSize, i, j: Integer;
  d: TADODataset;
  q: TADODataset;
begin
  Result := True;
  cFunc := aRequest.ContentFields.Values['Function'];
  oParams := SO(aRequest.ContentFields.Values['Params']);
  oResult := SO;
  if SameText(cFunc, 'Add') then begin
    oResult.I['Result'] := oParams.I['A'] + oParams.I['B'];
    oResult.S['Info'] := oParams.S['Info'];
  end else if SameText(cFunc, 'Time') then begin
    oResult.S['Result'] := FormatDateTime('yyyy-MM-dd hh:nn:ss zzz', Now);
    oResult.S['Info'] := '服务器时间';
  end else if SameText(cFunc, 'FetchData') then begin
    nPageNo := oParams.I['PageNo'];
    nPageSize := oParams.I['PageSize'];
    q := TIWUserSession(aApplication.Data).ADODataset;
    q.Close;
    q.CommandText := 'select * from 招行营业网点';
    q.Open;
    nTotal := q.RecordCount;
    // d.Clone(q);
    nSkip := (nPageNo - 1) * nPageSize;
    if nSkip >= nTotal then begin
      nSkip := 0;
      nPageNo := 1;
    end;
    d := TADODataset.Create(nil);
    d.LockType := ltBatchOptimistic;
    // d.CommandType := cmdFile;
    d.FieldDefs.Assign(q.FieldDefs);
    d.CreateDataSet;
    q.First;
    for i := 1 to nSkip do
        q.Next;
    if nSkip + nPageSize > nTotal then
        nPageSize := nTotal - nSkip;
    aRows := q.Recordset.GetRows(nPageSize, AdBookmarkCurrent, EmptyParam);
    for i := 0 to nPageSize - 1 do begin
      d.Append;
      for j := 0 to d.FieldCount - 1 do
          d.Fields[j].Value := aRows[j, i];
      d.Post;
    end;
    d.UpdateBatch();
    // oResult.S['GetString']:=q.Recordset.GetString(adClipString,nPageSize,',',#13#10,'NULL');
    oResult.I['RecordCount'] := nTotal;
    oResult.I['PageNo'] := nPageNo;
    oResult.S['XML'] := RecordsetToXML(d.Recordset);
    d.Close;
    d.Free;
    q.Close;
  end else if SameText(cFunc, 'SaveData') then begin
    try
      oResult.S['Info'] := TIWUserSession(aApplication.Data).ApplyChanges(
        oParams.S['Changes'], '招行营业网点', 'ID');
    except
      on e: Exception do
          oResult.S['Error'] := e.Message;
    end;
  end;
  aResponse.WriteString(
    'Function=' + aRequest.ContentFields.Values['Function'] + #13#10 +
    'Params=' + aRequest.ContentFields.Values['Params'] + #13#10 +
    'Result=' + oResult.AsJSon()
    );
end;

initialization

TIWServerController.SetServerControllerClass;

end.
