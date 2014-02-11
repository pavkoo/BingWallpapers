在目前流行的三层构架RemObjects、kmbMW、RealThinClient中RealThinClient以轻量、简单博得不少Delphi使用者的青睐。这里我向大家演示的框架比RealThinClient更轻量，更简单。这就是利用Intraweb作为中间层，Indy HTTP作为客户端，SuperObject作为数据编码格式实现三层构架。这一框架将B/S结构与C/S结构处理逻辑统一在一套源代码中，用同一台服务器既提供网页服务也通过应用服务。为实现这一目标，该框架的关键技术是如何在Dataset与XML间相互转换，这里发布的压缩文件中包含TADODataset与XML相互转换的源代码：
//将TADODataset转换成XML
function RecordsetToXML(const ARecordset: ADOInt._Recordset;
  const AChangesOnly: Boolean = False;
  const aIncludeSchema: Boolean = True): WideString;
//将XML转换成TADODataset
function XMLToRecordset(const AXML: WideString): ADOInt._Recordset;

//将XML变动数据转换成MS SQL的Update/Delete/Insert语句
function XMLChangesToMSSQL(const AXML, ATableName,
  AKeyFlds: WideString): WideString;

xander.xiao@gmail.com原创作品，转载请注明