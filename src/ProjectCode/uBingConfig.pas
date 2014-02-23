unit uBingConfig;

interface
  uses
    System.IOUtils,System.SysUtils,System.IniFiles,uConst,System.Classes;
  type
   TBingConfiger=class
   private
     files:TIniFile;
     function GetControyCode:Integer;
     procedure SetControyCode(const Value:Integer);
     function GetImageFilePath:String;
     function GetLocalImages:TStringList;
   public
     constructor Create;
     destructor Destroy;override;
     procedure AddLocalImages(const Value: String);
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
var
  Config : TBingConfiger;
{ TBingConfiger }

constructor TBingConfiger.Create;
var
  filePath:string;
begin
  filePath := TPath.Combine(TPath.GetDocumentsPath,BINGCONFIGFILE);
  files:= TIniFile.Create(filePath);
end;

destructor TBingConfiger.Destroy;
begin
  files.UpdateFile;
  files.Free;
  inherited;
end;

function TBingConfiger.GetControyCode: Integer;
begin
  Result := files.ReadInteger(INIFILESECTION,INIFILECOUNTORY,0);
end;

function TBingConfiger.GetImageFilePath: String;
begin
  Result := files.ReadString(INIFILESECTION,INIFILEIMAGEDIR,'');
end;

function TBingConfiger.GetLocalImages: TStringList;
begin
  files.ReadSection(INIFILEDATASECTION,Result);
end;

procedure TBingConfiger.SetControyCode(const Value: Integer);
begin
  files.WriteInteger(INIFILESECTION,INIFILECOUNTORY,Value);
end;

procedure TBingConfiger.AddLocalImages(const Value: String);
begin
  files.WriteString(INIFILEDATASECTION,INIFILEIMAGES,Value);
end;


initialization
  Config:=TBingConfiger.Create;
finalization
  Config.Free;
end.
