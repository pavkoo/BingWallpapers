unit uWebUtils;

interface
  uses
    IdHTTP,Classes;


  type
    TWeb=class
    private
      FHttp:TIdHTTP;
    public
      constructor Create;
      destructor Destroy; override;
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
