object SearchForm: TSearchForm
  Left = 0
  Top = 0
  Caption = 'SearchForm'
  ClientHeight = 272
  ClientWidth = 656
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    656
    272)
  PixelsPerInch = 96
  TextHeight = 13
  object GSearch: TEdit
    Left = 8
    Top = 8
    Width = 370
    Height = 21
    ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
    TabOrder = 0
  end
  object go: TButton
    Left = 384
    Top = 8
    Width = 34
    Height = 25
    Caption = 'go'
    TabOrder = 1
    OnClick = goClick
  end
  object ResultList: TListBox
    Left = 8
    Top = 40
    Width = 353
    Height = 223
    Anchors = [akLeft, akTop, akRight, akBottom]
    ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
    ItemHeight = 13
    TabOrder = 2
  end
  object mmo1: TMemo
    Left = 384
    Top = 39
    Width = 264
    Height = 225
    ImeName = #20013#25991'('#31616#20307') - '#24517#24212' Bing '#36755#20837#27861
    Lines.Strings = (
      'mmo1')
    TabOrder = 3
  end
end
