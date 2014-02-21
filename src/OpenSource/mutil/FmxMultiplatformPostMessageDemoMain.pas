unit FmxMultiplatformPostMessageDemoMain;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes,
    Generics.Collections,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
    FMX.StdCtrls, FMX.Layouts, FMX.Memo,
    FMX.Overbyte.MessageHandling;

const
    WM_SHOW_MESSAGE = WM_USER + 1;

type
    TWorkerThread = class(TThread)
    public
        MsgSys : TMessagingSystem;
        Id     : Integer;
        procedure Execute; override;
    end;

    TForm1 = class(TForm)
    btnRunThreadButton: TButton;
    mmoDisplaymemo: TMemo;
    pnlToolPanel: TPanel;
        procedure RunThreadButtonClick(Sender: TObject);
    private
        FMsgSys      : TMessagingSystem;
        FThreadCount : Integer;
        procedure Display(const Msg: String);
        procedure WorkerThreadTerminate(Sender: TObject);
        procedure WMShowMessage(var Msg: TMessage);
    protected
        procedure CreateHandle; override;
        procedure DestroyHandle; override;
    end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{ TForm1 }

procedure TForm1.CreateHandle;
begin
    inherited CreateHandle;
    FMsgSys := TMessagingSystem.Create(Self);
    FMsgSys.RegisterMessageHandler(WM_SHOW_MESSAGE, WMShowMessage);
end;

procedure TForm1.DestroyHandle;
begin
    FreeAndNil(FMsgSys);
    inherited DestroyHandle;
end;

procedure TForm1.RunThreadButtonClick(Sender: TObject);
var
    WorkerThread : TWorkerThread;
begin
    Inc(FThreadCount);
    Display('Start thread ' + IntToStr(FThreadCount));
    WorkerThread                 := TWorkerThread.Create(TRUE);
    WorkerThread.MsgSys          := FMsgSys;
    WorkerThread.Id              := FThreadCount;
    WorkerThread.FreeOnTerminate := TRUE;
    WorkerThread.OnTerminate     := WorkerThreadTerminate;
    WorkerThread.Start;
end;

procedure TForm1.WorkerThreadTerminate(Sender: TObject);
begin
    Display('Thread ' +
            IntToStr((Sender as TWorkerThread).Id) +
            ' terminated');
end;

procedure TForm1.WMShowMessage(var Msg: TMessage);
var
    Buffer : PChar;
begin
    Buffer := PChar(Msg.LParam);
    Display(Buffer);
    FreeMem(Buffer);
end;

procedure TForm1.Display(const Msg: String);
begin
    mmoDisplaymemo.Lines.Add(IntToStr(GetCurrentThreadID) + '] ' + Msg);
end;

{ TWorkerThread }

procedure TWorkerThread.Execute;
var
    I      : Integer;
    Buffer : PChar;
const
    MaxLen = 100;
begin
    // For demo, let's do it 10 times
    for I := 1 to 10 do begin
        // Simulate some processing time by sleeping
        Sleep(1000);

        // Allocate memory to hold a message, take care of the ending nul char
        GetMem(Buffer, SizeOf(Char) * (MaxLen + 1));
        // Copy message to allocated memory, protecting overflow
        StrLCopy(Buffer,
                 PChar('Thread=' + IntToStr(Id) +
                       ' Count=' + IntToStr(I) +
                       ' ThreadID=' + IntToStr(GetCurrentThreadID)),
                 MaxLen);
        // Force a nul char at the end of buffer
        Buffer[MaxLen] := #0;
        // Post a message to the main thread which will display
        // the message and then free memory
        MsgSys.PostMessage(WM_SHOW_MESSAGE, I, LParam(Buffer));
    end;
end;

end.
