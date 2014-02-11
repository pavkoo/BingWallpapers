object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 446
  ClientWidth = 808
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object edtAddr: TEdit
    Left = 32
    Top = -1
    Width = 225
    Height = 23
    ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
    TabOrder = 0
    Text = '127.0.0.1:8888'
  end
  object PageControl1: TPageControl
    Left = 32
    Top = 28
    Width = 753
    Height = 410
    ActivePage = TabSheet1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #20989#25968#35843#29992
      object Label1: TLabel
        Left = 328
        Top = 9
        Width = 8
        Height = 15
        Caption = '+'
      end
      object Label2: TLabel
        Left = 424
        Top = 6
        Width = 8
        Height = 15
        Caption = '='
      end
      object btnAdd: TButton
        Left = 12
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 0
        OnClick = btnAddClick
      end
      object Memo1: TMemo
        Left = 12
        Top = 61
        Width = 717
        Height = 300
        ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object Edit1: TEdit
        Left = 264
        Top = 3
        Width = 49
        Height = 23
        ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
        TabOrder = 2
        Text = '50'
      end
      object Edit2: TEdit
        Left = 360
        Top = 3
        Width = 49
        Height = 23
        ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
        TabOrder = 3
        Text = '80'
      end
      object Edit3: TEdit
        Left = 464
        Top = 3
        Width = 81
        Height = 23
        ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
        TabOrder = 4
        Text = '80'
      end
      object Edit4: TEdit
        Left = 105
        Top = 3
        Width = 144
        Height = 23
        ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
        TabOrder = 5
        Text = 'Edit4'
      end
      object btnTime: TButton
        Left = 12
        Top = 30
        Width = 75
        Height = 25
        Caption = 'Time'
        TabOrder = 6
        OnClick = btnTimeClick
      end
      object Edit5: TEdit
        Left = 105
        Top = 30
        Width = 144
        Height = 23
        ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
        TabOrder = 7
        Text = 'Edit4'
      end
      object Edit6: TEdit
        Left = 264
        Top = 30
        Width = 281
        Height = 23
        ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
        TabOrder = 8
        Text = 'Edit4'
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25968#25454#22788#29702
      ImageIndex = 1
      object DBGrid1: TDBGrid
        Left = 0
        Top = 41
        Width = 745
        Height = 338
        Align = alClient
        DataSource = DataSource
        ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 745
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label3: TLabel
          Left = 120
          Top = 18
          Width = 8
          Height = 15
          Caption = 'x'
        end
        object Label4: TLabel
          Left = 240
          Top = 20
          Width = 24
          Height = 15
          Caption = '0/0'
        end
        object btnFetch: TButton
          Left = 409
          Top = 11
          Width = 51
          Height = 24
          Caption = #33719#21462
          TabOrder = 0
          OnClick = btnFetchClick
        end
        object btnSave: TButton
          Left = 481
          Top = 11
          Width = 51
          Height = 24
          Caption = #20445#23384
          Enabled = False
          TabOrder = 1
          OnClick = btnSaveClick
        end
        object cmbPage: TComboBox
          Left = 9
          Top = 14
          Width = 53
          Height = 23
          ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
          TabOrder = 2
          Text = '1'
          OnSelect = btnFetchClick
        end
        object edtPageCount: TEdit
          Left = 60
          Top = 14
          Width = 53
          Height = 23
          Color = clBtnFace
          ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
          ReadOnly = True
          TabOrder = 3
          Text = '/1'
        end
        object cmbRowsPerPage: TComboBox
          Left = 134
          Top = 14
          Width = 53
          Height = 23
          ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
          ItemIndex = 0
          TabOrder = 4
          Text = '10'
          OnSelect = cmbRowsPerPageSelect
          Items.Strings = (
            '10'
            '20'
            '50'
            '100'
            '500'
            '1000')
        end
      end
    end
  end
  object HTTP: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 9090
    ProxyParams.ProxyServer = '127.0.0.1'
    Request.CharSet = 'UTF-8'
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 224
    Top = 256
  end
  object DataSource: TDataSource
    DataSet = DATA
    Left = 304
    Top = 256
  end
  object DATA: TADODataSet
    LockType = ltBatchOptimistic
    AfterPost = DATAAfterPost
    AfterDelete = DATAAfterDelete
    AfterScroll = DATAAfterScroll
    CommandType = cmdFile
    Parameters = <>
    Left = 152
    Top = 256
  end
end
