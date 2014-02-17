unit uWebUtils;

interface
  uses
    IdHTTP,Classes;


  type
    TWeb=class(TObject)
    private
      FHttp:TIdHTTP;
    protected
      destructor Destroy; override;
    public
      constructor Create;
      function GetStream(const url:string):TStream;
    end;

implementation

{ TWeb }

constructor TWeb.Create;
begin
  FHttp:=TIdHTTP.Create(nil);
end;

destructor TWeb.Destroy;
begin
  FHttp.Free;
  inherited;
end;

function TWeb.GetStream(const url: string): TStream;
begin
  FHttp.Get(url,Result);
end;

end.
