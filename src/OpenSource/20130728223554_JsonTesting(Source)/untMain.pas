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
  if cbbProvince.Items[cbbProvince.ItemIndex] = '(手工查询)' then
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
    edtJsonURL.Text := '(未知城市)';
    Exit;
  end;

  b := TStringStream.Create('', 65001); // 65001是UTF-8
  IdHTTPClient.Get(edtJsonURL.Text, b);
  lblStatus.Text := ' 更新时间: ' + DateTimeToStr(now);

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
    mmoJsonTransfer.Lines.Add(DateTimeToStr(now) + ' 获取天气数据失败.');
    Exit;
  end;

  mmoJsonTransfer.Lines.Add(DateTimeToStr(now) + ' 获取天气数据成功！');
  mmoJsonTransfer.Lines.Add('');
  mmoJsonTransfer.Lines.Add('　城市: ' + rCity.CityName + '　　　(id:' +
    rCity.CityID + ')');
  mmoJsonTransfer.Lines.Add('　今日天气: ' + rCity.Weather);
  mmoJsonTransfer.Lines.Add('　最低气温: ' + rCity.LowTemp +
    '　　　(http://m.weather.com.cn/img/' + rCity.LowPic + ')');
  mmoJsonTransfer.Lines.Add('　最高气温: ' + rCity.HighTemp +
    '　　　(http://m.weather.com.cn/img/' + rCity.HighPic + ')');
  mmoJsonTransfer.Lines.Add('　发布时间: ' + rCity.PublishTime);

  msl := TMemoryStream.Create;
  IdHTTPClient.Get('http://m.weather.com.cn/img/' + rCity.LowPic, msl);
  imgLowPic.Bitmap.LoadFromStream(msl);
  msl.Free;
  msh := TMemoryStream.Create;
  IdHTTPClient.Get('http://m.weather.com.cn/img/' + rCity.HighPic, msh);
  imgHighPic.Bitmap.LoadFromStream(msh);
  msh.Free;
  grbShow.Text := rCity.CityID;
  lblCityName.Text := '城市: ' + rCity.CityName;
  lblWeather.Text := '天气: ' + rCity.Weather;
  lblTemp.Text := '温度: ' + rCity.LowTemp + ' / ' + rCity.HighTemp;
  lblPTime.Text := '发布时间: ' + rCity.PublishTime;
end;

procedure TfrmMain.cbbProvinceChange(Sender: TObject);
var
  i: integer;
begin
  if cbbProvince.Items[cbbProvince.ItemIndex] = '(手工查询)' then
  begin
    cbbCity.Visible := false;
    edtCityName.Visible := true;
  end
  else if cbbCity.Visible = false then
  begin
    cbbCity.Visible := true;
    edtCityName.Visible := false;
  end;

  if (cbbProvince.Items[cbbProvince.ItemIndex] = '北京') or
    (cbbProvince.Items[cbbProvince.ItemIndex] = '天津') or
    (cbbProvince.Items[cbbProvince.ItemIndex] = '上海') or
    (cbbProvince.Items[cbbProvince.ItemIndex] = '重庆') or
    (cbbProvince.Items[cbbProvince.ItemIndex] = '香港') or
    (cbbProvince.Items[cbbProvince.ItemIndex] = '澳门') then
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
  btnGetURL.Text := '更新';
  btnTrans.Text := '解码';
  btnTrans.Enabled := false;

  edtCityName.Text := '绵阳';
  lblStatus.Text := '';

  cbbProvince.Clear;
  cbbProvince.Items.Add('北京');
  cbbProvince.Items.Add('天津');
  cbbProvince.Items.Add('上海');
  cbbProvince.Items.Add('重庆');
  for i := 0 to (ChinaProvinceCount - 6) - 1 do
    cbbProvince.Items.Add(ChinaProvinceNameList[i]);
  cbbProvince.Items.Add('香港');
  cbbProvince.Items.Add('澳门');
  cbbProvince.Items.Add('(手工查询)');
  cbbProvince.ItemIndex := 0;
end;

end.
