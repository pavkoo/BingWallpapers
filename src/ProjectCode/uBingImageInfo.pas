unit uBingImageInfo;

interface
  uses
    Generics.Collections;
    Type
      TBingImageDesc=class(TObject)
        public
          Desc:String;
          DescQuery:String;
          DescLink:String;
          Constructor Create;
      end;
      TBingImageInfo=class(TObject)
        public
          StartDate:TDate;
          EndDate:TDate;
          UrlBase:String;
          CopyRight:String;
          CopyRightLink:String;
          ImageTitle:String;
          ImageLink:String;
          DescLists:TList<TBingImageDesc>;
          Constructor Create;
        protected
          destructor Destroy; override;
      end;

implementation

{ TBingImageDesc }

constructor TBingImageDesc.Create;
begin
  Desc:='';
  DescQuery:='';
  DescLink:='';
end;

{ TBingImageInfo }

constructor TBingImageInfo.Create;
begin
  StartDate:=0;
  EndDate:=0;
  UrlBase:='';
  CopyRight:='';
  CopyRightLink:='';
  ImageTitle:='';
  ImageLink:='';
  DescLists:=TList<TBingImageDesc>.Create;
end;

destructor TBingImageInfo.Destroy;
var
  i:Integer;
begin
  for I := 0 to DescLists.Count - 1 do
  begin
    if DescLists.Items[i]<>nil then
      DescLists.Delete(i);
  end;
  DescLists.Free;
  inherited;
end;

end.
