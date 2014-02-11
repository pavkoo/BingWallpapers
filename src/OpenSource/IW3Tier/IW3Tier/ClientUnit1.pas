unit ClientUnit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB;

type
  TForm3 = class(TForm)
    edtAddr: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    btnAdd: TButton;
    Memo1: TMemo;
    HTTP: TIdHTTP;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    btnTime: TButton;
    Edit5: TEdit;
    Edit6: TEdit;
    DBGrid1: TDBGrid;
    DataSource: TDataSource;
    Panel1: TPanel;
    Label3: TLabel;
    btnFetch: TButton;
    btnSave: TButton;
    cmbPage: TComboBox;
    edtPageCount: TEdit;
    cmbRowsPerPage: TComboBox;
    DATA: TADODataSet;
    Label4: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure btnTimeClick(Sender: TObject);
    procedure btnFetchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbRowsPerPageSelect(Sender: TObject);
    procedure DATAAfterScroll(DataSet: TDataSet);
    procedure DATAAfterPost(DataSet: TDataSet);
    procedure btnSaveClick(Sender: TObject);
    procedure DATAAfterDelete(DataSet: TDataSet);
  private
    FRowsPerPage: Integer;
    FRecordCount: Int64;
    procedure SetRecordCount(const Value: Int64);
    procedure SetRowsPerPage(const Value: Integer);
    procedure RefreshPageCount;
  public
    property RecordCount: Int64 read FRecordCount write SetRecordCount;
    property RowsPerPage: Integer read FRowsPerPage write SetRowsPerPage;

  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
uses IdCookieManager, IdCookie, superobject, ADOToXML;
procedure TForm3.btnAddClick(Sender: TObject);
var
  sl: TStringList;
  Response: TStringStream;
  Params, Result: ISuperObject;
begin
  sl := TStringList.Create;
  sl.Values['Function'] := 'Add';
  Params := SO;
  Params.I['A'] := StrToIntDef(Edit1.Text, 0);
  Params.I['B'] := StrToIntDef(Edit2.Text, 0);
  Params.S['Info'] := 'º”∑®º∆À„';
  sl.Values['Params'] := Params.AsJSon();
  Response := TStringStream.Create;
  HTTP.Post('http://' + edtAddr.Text + '/appservice/', sl, Response);
  sl.Text := Response.DataString;
  Memo1.Lines.AddStrings(sl);
  Result := SO(sl.Values['Result']);
  Edit3.Text := Result.S['Result'];
  Edit4.Text := Result.S['Info'];
  sl.Free;
  Response.Free;
end;

procedure TForm3.btnFetchClick(Sender: TObject);
var
  sl: TStringList;
  Response: TStringStream;
  Params, Result: ISuperObject;
  xml: string;
begin
  sl := TStringList.Create;
  sl.Values['Function'] := 'FetchData';
  Params := SO;
  Params.I['PageNo'] := StrToIntDef(cmbPage.Text, 1);
  Params.I['PageSize'] := StrToIntDef(cmbRowsPerPage.Text, 15);
  Params.S['TableName'] := 'Orders';
  sl.Values['Params'] := Params.AsJSon();
  Response := TStringStream.Create;
  HTTP.Post('http://' + edtAddr.Text + '/appservice/', sl, Response);
  sl.Text := Response.DataString;
  Result := SO(sl.Values['Result']);
  if Result <> nil then begin
    RecordCount := Result.I['RecordCount'];
    if RecordCount > 0 then begin
      cmbPage.ItemIndex := cmbPage.Items.IndexOf(IntToStr(Result.I['PageNo']));
      xml := Result.S['XML'];
      Memo1.Lines.Add(Result.S['XML']);
      DATA.DisableControls;
      DATA.Close;;
      DATA.Recordset := XMLToRecordset(xml);
      DATA.EnableControls;
    end;
  end
  else
      ShowMessage(Memo1.Lines.Values['Result']);

  sl.Free;
  Response.Free;
end;

procedure TForm3.btnSaveClick(Sender: TObject);
var
  sl: TStringList;
  Response: TStringStream;
  Params, Result: ISuperObject;
  xml: string;
begin
  sl := TStringList.Create;
  sl.Values['Function'] := 'SaveData';
  Params := SO;
  Params.S['Changes'] := RecordsetToXML(DATA.Recordset, True);
  Params.S['TableName'] := 'Orders';
  sl.Values['Params'] := Params.AsJSon();
  Response := TStringStream.Create;
  HTTP.Post('http://' + edtAddr.Text + '/appservice/', sl, Response);
  sl.Text := Response.DataString;
  Result := SO(sl.Values['Result']);
  if Result <> nil then begin
    Memo1.Lines.Add(Result.S['Info']);
    if Length(Result.S['Error']) > 0 then
        ShowMessage(Result.S['Error'])
    else begin
      DATA.UpdateBatch;
      btnSave.Enabled := False;
    end;
  end;
  sl.Free;
  Response.Free;
end;

procedure TForm3.btnTimeClick(Sender: TObject);
var
  sl: TStringList;
  Response: TStringStream;
  Result: ISuperObject;
begin
  sl := TStringList.Create;
  sl.Values['Function'] := 'Time';
  Response := TStringStream.Create;
  HTTP.Post('http://' + edtAddr.Text + '/appservice/', sl, Response);
  sl.Text := Response.DataString;
  Memo1.Lines.AddStrings(sl);
  Result := SO(sl.Values['Result']);
  Edit5.Text := Result.S['Info'];
  Edit6.Text := Result.S['Result'];
  sl.Free;
  Response.Free;
end;

procedure TForm3.cmbRowsPerPageSelect(Sender: TObject);
begin
  RowsPerPage := StrToIntDef(cmbRowsPerPage.Text, 50);
  RefreshPageCount;
  btnFetch.Click;
end;

procedure TForm3.DATAAfterDelete(DataSet: TDataSet);
begin
   btnSave.Enabled := True;
end;

procedure TForm3.DATAAfterPost(DataSet: TDataSet);
begin
  btnSave.Enabled := True;
end;

procedure TForm3.DATAAfterScroll(DataSet: TDataSet);
begin
  with Dataset do begin
    label4.Caption := IntToStr(Recno) + '/' + IntToStr(RecordCount);
  end;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  RowsPerPage := 10;
end;

procedure TForm3.RefreshPageCount;
var
  nPageCount, i: Integer;
begin
  nPageCount := (FRecordCount + RowsPerPage - 1) div RowsPerPage;
  edtPageCount.Text := '/' + IntToStr(nPageCount);
  cmbPage.Clear;
  for i := 1 to nPageCount do
      cmbPage.Items.Add(IntToStr(i));
end;

procedure TForm3.SetRecordCount(const Value: Int64);
begin
  FRecordCount := Value;
  RefreshPageCount;
end;

procedure TForm3.SetRowsPerPage(const Value: Integer);
begin
  FRowsPerPage := Value;
  RefreshPageCount;
end;

end.
