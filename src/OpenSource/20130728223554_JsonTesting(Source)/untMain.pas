 unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, SuperObject, UnitChinaWeather, FMX.Types, FMX.Controls,
  FMX.Forms, FMX.Dialogs,
  FMX.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, FMX.Layouts, FMX.Memo, FMX.Edit, FMX.Objects, FMX.ListBox;

type
  TfrmMain = class(TForm)
    IdHTTPClient: TIdHTTP;
    btnGetURL: TButton;
    mmoJsonContent: TMemo;
    edtJsonURL: TEdit;
    lblTitle1: TLabel;
    mmoJsonTransfer: TMemo;
    lblTitle2: TLabel;
    pnlStatus: TPanel;
    lblStatus: TLabel;
    btnTrans: TButton;
    edtCityName: TEdit;
    grbShow: TGroupBox;
    lblCityName: TLabel;
    lblWeather: TLabel;
    lblTemp: TLabel;
    lblPTime: TLabel;
    imgLowPic: TImage;
    imgHighPic: TImage;
    StyleBookPack: TStyleBook;
    cbbProvince: TComboBox;
    cbbCity: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnGetURLClick(Sender: TObject);
    procedure btnTransClick(Sender: TObject);
    procedure edtCityNameChangeTracking(Sender: TObject);
    procedure cbbProvinceChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.btnGetURLClick(Sender: TObject);
var
  b: TStringStream;
begin
  if cbbProvince.Items[cbbProvince.ItemIndex] = '(�ֹ���ѯ)' then
  begin
    if edtCityName.Text = '' then
      Exit;
    edtJsonURL.Text := GetURLByCityName(edtCityName.Text);
  end
  else if cbbCity.Items.Count = 0 then
    edtJsonURL.Text := GetURLByCityName
      (cbbProvince.Items[cbbProvince.ItemIndex])
  else
    edtJsonURL.Text := GetURLByCityName(cbbCity.Items[cbbCity.ItemIndex]);

  if edtJsonURL.Text = '' then
  begin
    edtJsonURL.Text := '(δ֪����)';
    Exit;
  end;

  b := TStringStream.Create('', 65001); // 65001��UTF-8
  IdHTTPClient.Get(edtJsonURL.Text, b);
  lblStatus.Text := ' ����ʱ��: ' + DateTimeToStr(now);

  mmoJsonContent.Text := b.DataString;
  btnTrans.Enabled := (mmoJsonContent.Text <> '');

  b.Destroy;
end;

procedure TfrmMain.btnTransClick(Sender: TObject);
var
  rCity: RCityWeatherCurrent;
  msl, msh: TMemoryStream;
begin
  mmoJsonTransfer.Lines.Clear;

  rCity := GetWeatherDataByJson(mmoJsonContent.Text);
  if rCity.IsEmpty then
  begin
    mmoJsonTransfer.Lines.Add(DateTimeToStr(now) + ' ��ȡ��������ʧ��.');
    Exit;
  end;

  mmoJsonTransfer.Lines.Add(DateTimeToStr(now) + ' ��ȡ�������ݳɹ���');
  mmoJsonTransfer.Lines.Add('');
  mmoJsonTransfer.Lines.Add('������: ' + rCity.CityName + '������(id:' +
    rCity.CityID + ')');
  mmoJsonTransfer.Lines.Add('����������: ' + rCity.Weather);
  mmoJsonTransfer.Lines.Add('���������: ' + rCity.LowTemp +
    '������(http://m.weather.com.cn/img/' + rCity.LowPic + ')');
  mmoJsonTransfer.Lines.Add('���������: ' + rCity.HighTemp +
    '������(http://m.weather.com.cn/img/' + rCity.HighPic + ')');
  mmoJsonTransfer.Lines.Add('������ʱ��: ' + rCity.PublishTime);

  msl := TMemoryStream.Create;
  IdHTTPClient.Get('http://m.weather.com.cn/img/' + rCity.LowPic, msl);
  imgLowPic.Bitmap.LoadFromStream(msl);
  msl.Free;
  msh := TMemoryStream.Create;
  IdHTTPClient.Get('http://m.weather.com.cn/img/' + rCity.HighPic, msh);
  imgHighPic.Bitmap.LoadFromStream(msh);
  msh.Free;
  grbShow.Text := rCity.CityID;
  lblCityName.Text := '����: ' + rCity.CityName;
  lblWeather.Text := '����: ' + rCity.Weather;
  lblTemp.Text := '�¶�: ' + rCity.LowTemp + ' / ' + rCity.HighTemp;
  lblPTime.Text := '����ʱ��: ' + rCity.PublishTime;
end;

procedure TfrmMain.cbbProvinceChange(Sender: TObject);
var
  i: integer;
begin
  if cbbProvince.Items[cbbProvince.ItemIndex] = '(�ֹ���ѯ)' then
  begin
    cbbCity.Visible := false;
    edtCityName.Visible := true;
  end
  else if cbbCity.Visible = false then
  begin
    cbbCity.Visible := true;
    edtCityName.Visible := false;
  end;

  if (cbbProvince.Items[cbbProvince.ItemIndex] = '����') or
    (cbbProvince.Items[cbbProvince.ItemIndex] = '���') or
    (cbbProvince.Items[cbbProvince.ItemIndex] = '�Ϻ�') or
    (cbbProvince.Items[cbbProvince.ItemIndex] = '����') or
    (cbbProvince.Items[cbbProvince.ItemIndex] = '���') or
    (cbbProvince.Items[cbbProvince.ItemIndex] = '����') then
  begin
    cbbCity.Clear;
    cbbCity.Enabled := false;
  end
  else
  begin
    cbbCity.Clear;
    cbbCity.Enabled := true;
    for i := 0 to 20 do
      if ChinaCityNameOfProvinceList[cbbProvince.ItemIndex - 4, i] <> '' then
        cbbCity.Items.Add(ChinaCityNameOfProvinceList
          [cbbProvince.ItemIndex - 4, i]);
    if cbbCity.Count > 0 then
      cbbCity.ItemIndex := 0;
  end;
end;

procedure TfrmMain.edtCityNameChangeTracking(Sender: TObject);
begin
  btnGetURL.Enabled := (edtCityName.Text <> '');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: integer;
begin
  btnGetURL.Text := '����';
  btnTrans.Text := '����';
  btnTrans.Enabled := false;

  edtCityName.Text := '����';
  lblStatus.Text := '';

  cbbProvince.Clear;
  cbbProvince.Items.Add('����');
  cbbProvince.Items.Add('���');
  cbbProvince.Items.Add('�Ϻ�');
  cbbProvince.Items.Add('����');
  for i := 0 to (ChinaProvinceCount - 6) - 1 do
    cbbProvince.Items.Add(ChinaProvinceNameList[i]);
  cbbProvince.Items.Add('���');
  cbbProvince.Items.Add('����');
  cbbProvince.Items.Add('(�ֹ���ѯ)');
  cbbProvince.ItemIndex := 0;
end;

end.
