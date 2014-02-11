unit ADOToXML;

interface

uses Classes, MSXML, SysUtils, ComObj, ADOInt;

function RecordsetToXML(const ARecordset: ADOInt._Recordset;
  const AChangesOnly: Boolean = False;
  const aIncludeSchema: Boolean = True): WideString;
function XMLToRecordset(const AXML: WideString): ADOInt._Recordset;
function XMLChangesToMSSQL(const AXML, ATableName,
  AKeyFlds: WideString): WideString;

implementation

uses Types, StrUtils;

function RecordsetToXML(const ARecordset: ADOInt._Recordset;
  const AChangesOnly: Boolean = False;
  const aIncludeSchema: Boolean = True): WideString;
var
  XMLDoc: IXMLDOMDocument;
  DataNode: IXMLDOMNode;
  NodeList: IXMLDOMNodeList;
  i: integer;
begin
  Result := '';
  XMLDoc := CoDOMDocument.Create;
  XMLDoc.ASync := FALSE;
  ARecordset.Save(XMLDoc, adPersistXML);
  if AChangesOnly then begin
    DataNode := XMLDoc.ChildNodes[0].ChildNodes[1];
    NodeList := DataNode.SelectNodes('*');
    for i := (NodeList.Length - 1) downto 0 do
      if (NodeList.Item[i].NodeName = 'z:row') then
          DataNode.RemoveChild(NodeList.item[i]);
  end;
  if not aIncludeSchema then
      Result := XMLDoc.ChildNodes[0].ChildNodes[1].XML
  else
      Result := XMLDoc.XML;
end;

function XMLToRecordset(const AXML: WideString): ADOInt._Recordset;
var
  XMLDoc: IXMLDOMDocument;
  rs: OleVariant;
begin
  XMLDoc := CoDOMDocument.Create;
  XMLDoc.ASync := False;

  if not XMLDoc.loadXML(AXML) then
    with XMLDoc.ParseError do
        raise Exception.CreateFmt('%s [%d, %d]', [Reason, LinePos, Line]);

  rs := CoRecordset.Create;
  rs.Open(XMLDoc);

  Result := IUnknown(rs) as _Recordset;
end;

function XMLChangesToMSSQL(const AXML, ATableName,
  AKeyFlds: WideString): WideString;
var
  XMLDoc: IXMLDOMDocument;
  DataNode, RecNode, OldNode, FldNode: IXMLDOMNode;
  NodeList: IXMLDOMNodeList;
  cPrefix, cNodeValue, cFldID, cFldName, cFldVal, cSQL: WideString;
  cFldList, cValList: WideString;
  i, j, k: integer;
  FldAttributes: TStringList;
  FldLookup: TStringList;
  aKeyFldList: TStringDynArray;
  function NodeAttr(const ANode: IXMLDOMNode; const AName: WideString)
    : WideString;
  var
    i: Integer;
    a: IXMLDOMNamedNodeMap;
  begin
    Result := '';
    a := ANode.attributes;
    for i := 0 to a.Length - 1 do begin
      if SameText(a[i].nodeName, AName) then begin
        Result := a[i].nodeValue;
        break;
      end;
    end;
  end;
  function IsString(const AFldID: WideString): Boolean;
  begin
    Result := FldAttributes.Values[AFldID + '.dt:type'] = 'string';
  end;
  function SQLWhere(const ANode: IXMLDOMNode): WideString;
  var
    i: Integer;
    cFldName, cFldID, cFldVal: WideString;
  begin
    Result := '';
    for i := low(aKeyFldList) to high(aKeyFldList) do begin
      cFldName := aKeyFldList[i];
      cFldID := FldLookup.Values[cFldName];
      cFldVal := NodeAttr(ANode, cFldID);
      if IsString(cFldID) then
          cFldVal := QuotedStr(cFldVal);
      if Length(Result) > 0 then
          Result := Result + ' AND ';
      Result := Result + cFldName + '=' + cFldVal;
    end;
    if Length(Result) > 0 then
        Result := ' WHERE ' + Result;
  end;
begin
  Result := '';
  XMLDoc := CoDOMDocument.Create;
  XMLDoc.ASync := FALSE;
  if not XMLDoc.loadXML(AXML) then
    with XMLDoc.ParseError do
        raise Exception.CreateFmt('%s [%d, %d]', [Reason, LinePos, Line]);
  aKeyFldList := SplitString(AKeyFlds, ',');
  FldAttributes := TStringList.Create;
  FldAttributes.Sorted := True;
  FldLookup := TStringList.Create;
  FldLookup.Sorted := True;
  DataNode := XMLDoc.documentElement.childNodes[0].childNodes[0];
  NodeList := DataNode.childNodes;
  for i := 0 to NodeList.length - 1 do begin
    DataNode := NodeList[i];
    if DataNode.hasChildNodes then begin
      cNodeValue := DataNode.attributes[0].nodeValue;
      cPrefix := cNodeValue + '.';
      for j := 1 to DataNode.attributes.length - 1 do begin
        if DataNode.attributes[j].nodeName = 'rs:name' then begin
          FldAttributes.Add(cPrefix + DataNode.attributes[j].nodeName + '=' +
            DataNode.attributes[j].nodeValue);
          FldLookup.Add(DataNode.attributes[j].nodeValue + '=' + cNodeValue);
        end;
      end;
      if Length(FldAttributes.Values[cPrefix + 'rs:name']) = 0 then begin
        FldAttributes.Add(cPrefix + 'rs:name=' + cNodeValue);
        FldLookup.Add(cNodeValue + '=' + cNodeValue);
      end;
      DataNode := NodeList[i].childNodes[0];
      if DataNode <> nil then
        for j := 0 to DataNode.attributes.length - 1 do
            FldAttributes.Add(cPrefix + DataNode.attributes[j].nodeName + '=' +
            DataNode.attributes[j].nodeValue);
    end;
  end;
  // Log(FldAttributes);
  // Log(FldLookup);
  DataNode := XMLDoc.documentElement.childNodes[1];
  NodeList := DataNode.childNodes;
  for i := 0 to NodeList.length - 1 do begin
    DataNode := NodeList[i];
    // Log(DataNode.nodeName);
    if DataNode.nodeName = 'rs:update' then begin
      OldNode := DataNode.childNodes[0].childNodes[0];
      RecNode := DataNode.childNodes[1];
      // Log(SQLWhere(OldNode));
      // Log(RecNode.nodeName);
      cSQL := '';
      for j := 0 to RecNode.attributes.length - 1 do begin
        FldNode := RecNode.attributes[j];
        cFldID := FldNode.nodeName;
        cFldVal := FldNode.nodeValue;
        if IsString(cFldID) then
            cFldVal := QuotedStr(cFldVal);
        cFldName := FldAttributes.Values[cFldID + '.rs:name'];
        if Length(cSQL) > 0 then
            cSQL := cSQL + ',';
        cSQL := cSQL + cFldName + '=' + cFldVal;
      end;
      cSQL := 'UPDATE ' + ATableName + ' SET ' + cSQL + SQLWhere(OldNode);
      Result := Result + cSQL + #13#10;
    end else if DataNode.nodeName = 'rs:delete' then begin
      for j := 0 to DataNode.childNodes.length - 1 do begin
        RecNode := DataNode.childNodes[j];
        cSQL := 'DELETE ' + ATableName + SQLWhere(RecNode);
        Result := Result + cSQL + #13#10;
      end;
    end else if DataNode.nodeName = 'rs:insert' then begin
      for j := 0 to DataNode.childNodes.length - 1 do begin
        RecNode := DataNode.childNodes[j];
        cFldList := '';
        cValList := '';
        for k := 0 to RecNode.attributes.length - 1 do begin
          FldNode := RecNode.attributes[k];
          cFldID := FldNode.nodeName;
          cFldVal := FldNode.nodeValue;
          if IsString(cFldID) then
              cFldVal := QuotedStr(cFldVal);
          cFldName := FldAttributes.Values[cFldID + '.rs:name'];
          if Length(cFldList) > 0 then begin
            cFldList := cFldList + ',';
            cValList := cValList + ',';
          end;
          cFldList := cFldList + cFldName;
          cValList := cValList + cFldVal;
        end;
        cSQL := 'INSERT INTO ' + ATableName + '(' + cFldList + ')' +
          ' VALUES(' + cValList + ')';
        Result := Result + cSQL + #13#10;
      end;
    end;
  end;
  FldAttributes.Free;
  FldLookup.Free;
end;

end.
