��Ŀǰ���е����㹹��RemObjects��kmbMW��RealThinClient��RealThinClient���������򵥲��ò���Delphiʹ���ߵ�������������������ʾ�Ŀ�ܱ�RealThinClient�����������򵥡����������Intraweb��Ϊ�м�㣬Indy HTTP��Ϊ�ͻ��ˣ�SuperObject��Ϊ���ݱ����ʽʵ�����㹹�ܡ���һ��ܽ�B/S�ṹ��C/S�ṹ�����߼�ͳһ��һ��Դ�����У���ͬһ̨���������ṩ��ҳ����Ҳͨ��Ӧ�÷���Ϊʵ����һĿ�꣬�ÿ�ܵĹؼ������������Dataset��XML���໥ת�������﷢����ѹ���ļ��а���TADODataset��XML�໥ת����Դ���룺
//��TADODatasetת����XML
function RecordsetToXML(const ARecordset: ADOInt._Recordset;
  const AChangesOnly: Boolean = False;
  const aIncludeSchema: Boolean = True): WideString;
//��XMLת����TADODataset
function XMLToRecordset(const AXML: WideString): ADOInt._Recordset;

//��XML�䶯����ת����MS SQL��Update/Delete/Insert���
function XMLChangesToMSSQL(const AXML, ATableName,
  AKeyFlds: WideString): WideString;

xander.xiao@gmail.comԭ����Ʒ��ת����ע��