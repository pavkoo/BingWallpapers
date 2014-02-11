object IWUserSession: TIWUserSession
  OldCreateOrder = False
  Height = 248
  Width = 340
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=TEST.mdb;Persist Se' +
      'curity Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 48
    Top = 16
  end
  object qryCity: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select distinct city from Customers order by 1')
    Left = 48
    Top = 128
  end
  object ADODataset: TADODataSet
    Connection = ADOConnection1
    CursorType = ctDynamic
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 48
    Top = 72
  end
end
