unit FMX.Overbyte.MessageHandling;
{$DEFINE OVERBYTE_INCLUDE_MODE}
{$IFDEF ANDROID}
    {$I FMX.Overbyte.Android.MessageHandling.pas}
{$ENDIF}
{$IFDEF MSWINDOWS}
    {$I FMX.Overbyte.Windows.MessageHandling.pas}
{$ENDIF}
