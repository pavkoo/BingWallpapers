unit uBingConfig;

interface
  uses
    System.IOUtils,System.SysUtils,System.IniFiles,uConst,System.Classes;
  type
   TBingConfiger=class
   private
     files:TIniFile;
     FLocalImages:TStringList;
     function GetControyCode:Integer;
     procedure SetControyCode(const Value:Integer);
     function GetImageFilePath:String;
     function GetLocalImages:TStringList;
   public
     constructor Create;
     destructor Destroy;override;
     procedure AddLocalImages(const Ident,Value: String);
     function GetLocalImage(const Ident:String):String;
     property ControyCode:Integer  read GetControyCode write SetControyCode;
     property ImageFilePath:String  read GetImageFilePath;
     property LocalImages:TStringList read  GetLocalImages;
   end;

   
implementation

const
  INIFILESECTION = 'UserSet';
  INIFILECOUNTORY = 'CN';
  INIFILEIMAGEDIR = 'ImagePath';
  INIFILEDATASECTION = 'localData';
  INIFILEIMAGES = 'Images';
{ TBingConfiger }

constructor TBingConfiger.Create;
var
  filePath:string;
begin
  filePath := TPath.Combine(TPath.GetDocumentsPath,BINGCONFIGFILE);
  files:= TIniFile.Create(filePath);
  FLocalImages := TStringLIst.Create;
end;

destructor TBingConfiger.Destroy;
begin
  files.UpdateFile;
  files.Free;
  FLocalImages.Free;
  inherited;
end;

function TBingConfiger.GetControyCode: Integer;
begin
  Result := files.ReadInteger(INIFILESECTION,INIFILECOUNTORY,0);
end;

function TBingConfiger.GetImageFilePath: String;
begin
  Result := files.ReadString(INIFILESECTION,INIFILEIMAGEDIR,TPath.Combine(TPath.GetDocumentsPath,BINGLOCALIMAGEDIR));
  if not TDirectory.Exists(Result) then TDirectory.CreateDirectory(Result);
end;

function TBingConfiger.GetLocalImage(const Ident: String): String;
begin
  Result:=files.ReadString(INIFILEDATASECTION,Ident,'');
end;

function TBingConfiger.GetLocalImages: TStringList;
begin
  FLocalImages.Clear;
  files.ReadSection(INIFILEDATASECTION,FLocalImages);
  Result:=FLocalImages;
end;

procedure TBingConfiger.SetControyCode(const Value: Integer);
begin
  files.WriteInteger(INIFILESECTION,INIFILECOUNTORY,Value);
  files.UpdateFile;
end;

procedure TBingConfiger.AddLocalImages(const Ident,Value: String);
begin
  files.WriteString(INIFILEDATASECTION,Ident,Value);
  files.UpdateFile;
end;



end.
