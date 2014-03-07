unit Unit3;
interface
implementation
end.
//
//interface
//
//procedure AskRoot;
//
//implementation
//
//uses System.SysUtils, Androidapi.JNIBridge,
//  Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.JavaTypes,
//  FMX.Helpers.Android;
//
//type
//  JProcess = interface;
//  JRuntime = interface;
//
//  // ----------------------------------JProcess----------------------
//  JProcessClass = interface(JObjectClass)
//    ['{7BFD2CCB-89B6-4382-A00B-A7B5BB0BC7C9}']
//  end;
//
//  [JavaSignature('java/lang/Process')]
//  JProcess = interface(JObject)
//    ['{476414FD-570F-4EDF-B678-A2FE459EA6EB}'] { Methods }
//    procedure destroy; cdecl;
//    function exitValue: integer; cdecl;
//    function getErrorStream: JInputStream; cdecl;
//    function getInputStream: JOutputStream; cdecl;
//    function waitFor: integer; cdecl;
//  end;
//
//  TJProcess = class(TJavaGenericImport)
//  end; // ----------------------------------Jruntime----------------------
//
//  JRuntimeClass = interface(JObjectClass)
//    ['{3F2E949D-E97C-4AD8-B5B9-19CB0A6A29F3}'] { costant }
//  end;
//
//  [JavaSignature('java/lang/Runtime')]
//  JRuntime = interface(JObject)
//    ['{C097A7EC-677B-4BCB-A4BD-7227160750A5}'] { Methods }
//    procedure addShutdownHook(hook: JThread); cdecl;
//    function availableProcessors: integer; cdecl;
//    function exec(progArray, envp: array of JString): JProcess; overload;
//    function exec(progArray: JString; envp: array of JString; directory: JFile)
//      : JProcess; overload;
//    function exec(progArray, envp: array of JString; directory: JFile)
//      : JProcess; overload;
//    function exec(prog: JString; envp: array of JString): JProcess; cdecl;
//      overload;
//    function exec(progArray: array of JString): JProcess; overload;
//    function exec(prog: JString): JProcess; cdecl; overload;
//    procedure Exit(code: integer); cdecl;
//    function freeMemory: LongInt; cdecl;
//    procedure gc; cdecl;
//    function getLocalizedInputStream(stream: JInputStream)
//      : JInputStream; cdecl;
//    function getLocalizedOutputStream(stream: JOutputStream)
//      : JOutputStream; cdecl;
//    function getRuntime: JRuntime; cdecl;
//    procedure halt(code: integer); cdecl;
//    procedure load(pathName: JString); cdecl;
//    procedure loadLibrary(libName: JString); cdecl;
//    function maxMemory: LongInt; cdecl;
//    function RemoveShutdownHook(hook: JThread): Boolean; cdecl;
//    procedure runFinalization; cdecl;
//    procedure runFinalizersOnExit(run: Boolean); cdecl;
//    function totalMemory: LongInt; cdecl;
//    procedure traceInstructions(enable: Boolean); cdecl;
//    procedure traceMethodCalls(enable: Boolean); cdecl;
//  end;
//
//  TJRuntime = class(TJavaGenericImport)
//  end;
//
//procedure AskRoot;
//var
//  Root: JRuntime;
//begin
//  Root.getRuntime.exec(StringToJString('su'));
//end;
//
//end.

