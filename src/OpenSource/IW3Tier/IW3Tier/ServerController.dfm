object IWServerController: TIWServerController
  OldCreateOrder = False
  AuthBeforeNewSession = False
  AppName = 'MyApp'
  CharSet = 'UTF-8'
  CacheExpiry = 120
  ComInitialization = ciMultiThreaded
  Compression.Enabled = True
  Compression.Level = 6
  Description = 'My IntraWeb Application'
  DebugHTML = False
  DisplayName = 'IntraWeb Application'
  Log = loNone
  EnableImageToolbar = False
  ExceptionDisplayMode = smAlert
  HistoryEnabled = False
  InternalFilesURL = '/'
  JavascriptDebug = False
  PageTransitions = False
  Port = 8888
  RedirectMsgDelay = 0
  ServerResizeTimeout = 0
  ShowLoadingAnimation = True
  SessionTimeout = 10
  SSLOptions.NonSSLRequest = nsAccept
  SSLOptions.Port = 0
  SSLOptions.SSLVersion = sslv3
  Version = '12.2.12.1'
  OnNewSession = IWServerControllerBaseNewSession
  OnBrowserCheck = IWServerControllerBaseBrowserCheck
  Height = 310
  Width = 342
  object IWURLResponderEvent1: TIWURLResponderEvent
    Path = '/appservice/'
    SelfRegister = True
    OnRequest = IWURLResponderEvent1Request
    Left = 72
    Top = 64
  end
end
