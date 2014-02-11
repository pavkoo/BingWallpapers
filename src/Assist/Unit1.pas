unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  FMX.Layouts, FMX.Memo, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc,
  FMX.Objects,Generics.Collections,Vcl.Graphics,Vcl.Imaging.jpeg;

type
  TForm1 = class(TForm)
    Button1: TButton;
    IdHTTP1: TIdHTTP;
    Memo1: TMemo;
    XMLDocument1: TXMLDocument;
    Image1: TImage;
    btn1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation

{$R *.fmx}

procedure TForm1.btn1Click(Sender: TObject);
var
  a,b,c:AnsiString;
    h: cardinal;
  i: Integer;
  k: WideString;
begin
  a:='asdf';
  b:=a;
  c:=a;
//  ShowMessage(IntToStr(PLongInt(PByte(a) - 8)^)+B+C);

  k:='fs_id';
  h := 0;
{$Q-}
  for i := 1 to Length(k) do
    h := h*129 + ord(k[i]) + $9e370001;
{$Q+}
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  str:TStringStream;
  img:TMemoryStream;
  tempStr:String;
  XMLNode :IXMLNode;
  list,width,height:TStringList;
  sortlist:TList<Integer>;
  i,j,count:integer;
  pic:TJPEGImage;
begin
  str := TStringStream.Create;
//  IdHTTP1.Request.CustomHeaders.Text :=
//  'Accept: image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*'+
//  'Accept:  application/xaml+xml' ;
//  #13+#10+'Referer:http://url'+
//  #13+#10+'Accept-Language: zh-CN' +
//  #13+#10+'User-Agent: Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)'+
//  #13+#10+'Accept-Encoding: gzip, deflate'+
//  #13+#10+'Host: ***'+
//  #13+#10+'Connection: Keep-Alive'+
//  #13+#10+'Authorization: Basic *****=';
//  idhttp1.Request.ContentType := 'application/x-www-form-urlencoded';
  IdHTTP1.get('http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=zh-CN',str);
  memo1.WordWrap := True;
//  tempStr := str.DataString;
//  tempStr := Utf8ToAnsi(tempStr);
  XMLDocument1.LoadFromStream(str,xetUTF_8);

//  memo1.lines.Add(tempStr);
  XMLDocument1.Active:=TRUE;
  XMLDocument1.Encoding:='UTF-8';
//  memo1.Text:=XMLDocument1.XML.Text;
  XMLNode:= XMLDocument1.DocumentElement;

  XMLNode:= XMLNode.ChildNodes.Get(0);
  XMLNode := XMLNode.ChildNodes.Get(4);
   memo1.Text:=XMLNode.NodeName + ' '+XMLNode.NodeValue ;
  width:=TStringList.Create;
  height:=TStringList.Create;
  list:=TStringList.Create;
//
//  width.Add('320');
//  width.Add('480');
//  width.Add('400');
//  width.Add('240');
//  width.Add('360');
//  width.Add('800');
//  width.Add('640');
//  width.Add('720');
//  width.Add('850');
//  width.Add('854');
//  width.Add('940');
//  width.Add('540');
//  width.Add('960');
//  width.Add('1024');
//  width.Add('600');
//  width.Add('768');
//  width.Add('1080');
//  width.Add('1136');
//  width.Add('1280');
//  width.Add('1366');
//  width.Add('1800');
//  width.Add('1920');
//  width.Add('1440');
//  width.Add('1200');
//  width.add('1152');
//  width.add('2048');
//  width.add('2560');
//  width.add('512');
//  width.add('342');
//  width.add('384');
//  width.add('848');
//  width.add('832');
//  width.add('544');
//  width.add('576');
//  width.add('1120');
//  width.add('1600');
//  width.add('1680');
//  width.add('1792');
//  width.add('1856');
//  width.add('2880');
//  width.add('2538');
//  width.add('2304');
//  width.add('3200');
//  width.add('3840');
//  width.add('4096');
//  width.add('5120');
//  width.add('6400');
//  width.add('7680');
//  width.add('8192');
//  width.add('4608');
//  width.add('270');
//  width.add('234');
//  width.add('250');
//  width.add('300');
//  width.add('272');
//  width.add('256');
//  width.add('352');
//  width.add('350');
//  width.add('500');
//  width.add('348');
//  width.add('364');
//  width.add('624');
//  width.add('900');
//  width.add('1050');
//  width.add('1344');
//  width.add('1392');
//  width.add('1536');
//  width.add('1728');
//  width.add('4800');
//  width.add('4320');
//
//
//  sortlist := Tlist<Integer>.Create;
//  for I := 0 to width.Count - 1 do
//  begin
//    sortlist.Add(strtoint(width.Strings[i]));
//  end;
//  sortlist.Sort;
//  width.Clear;
//  for I := 0 to sortlist.Count - 1 do
//  begin
//    width.Add(inttostr(sortlist.Items[i]));
//    height.Add(inttostr(sortlist.Items[i]));
//  end;
//
//  sortlist.Free;
//
//
//  for I := 0 to width.Count - 1 do
//  begin
//    for j := 0 to height.Count - 1 do
//    begin
//      tempStr:='_'+width.Strings[i]+'x'+height.Strings[j];
      list.Add('_240x240');
//    end;
//  end;

   img := TMemoryStream.Create;
   for I := 0 to List.Count - 1 do
   begin
     tempStr:='http://www.bing.com'+XMLNode.NodeValue +List.Strings[i] +'.jpg';
     try
          IdHTTP1.get(tempStr,img);
          img.Position := 0;
          pic:=TJPEGImage.Create;
          pic.LoadFromStream(img);
          pic.SaveToFile('1111.jpg');
          img.Position := 0;
          image1.Bitmap.LoadFromStream(img);
          memo1.Lines.Add(List.Strings[i]);
     except on E: Exception do
     end;
   end;
   img.Free;
  str.Free;
end;

end.
