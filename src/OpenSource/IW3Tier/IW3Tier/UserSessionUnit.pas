unit UserSessionUnit;

{
  This is a DataModule where you can add components or declare fields that are specific to
  ONE user. Instead of creating global variables, it is better to use this datamodule. You can then
  access the it using UserSession.
}
interface

{$DEFINE CODESITE }

uses {$IFDEF CODESITE}CodeSiteLogging, {$ENDIF}
  IWUserSessionBase, SysUtils, Classes, Data.DB, Data.Win.ADODB;

type
  TIWUserSession = class(TIWUserSessionBase)
    ADOConnection1: TADOConnection;
    qryCity: TADOQuery;
    ADODataset: TADODataSet;
  private
  public
    function ApplyChanges(const AXML, ATableName, AKeyFlds: string): string;

  end;

implementation

{$R *.dfm}

uses ADOToXML, StrUtils, Types, Variants;

{ TIWUserSession }

function TIWUserSession.ApplyChanges(const AXML, ATableName,
  AKeyFlds: string): string;
var
  sl: TStringList;
  i: Integer;
  cSQL: string;
begin
  sl := TStringList.Create;
  sl.Text := XMLChangesToMSSQL(AXML, ATableName, AKeyFlds);
  Result := sl.Text;
  for i := 0 to sl.Count - 1 do begin
    cSQL := sl.Strings[i];
    try
      if Length(cSQL) > 0 then
          ADOConnection1.Execute(cSQL);
    except
      on e: Exception do begin
        sl.Free;
        raise Exception.Create('Ö´ÐÐ:' + cSQL + '±¨´í£º'#13#10 + e.Message);
      end;
    end;
  end;
  sl.Free;
end;

end.
