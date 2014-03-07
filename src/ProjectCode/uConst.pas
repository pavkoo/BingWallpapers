unit uConst;

interface

  const
    BINGCONFIGFILE = 'bingConfig.ini';
    BINGLOCALIMAGEDIR = 'bingImages';

    BINGIMGSOURCE = 'http://www.bing.com/HPImageArchive.aspx?format=%s&idx=%d&n=%d&mkt=%s';
    BINGIMGURL = 'http://www.bing.com/%s_%dx%d.jpg';

    SMKTUS='en-US';
    SMKTCN ='zh-CN';
    SMKTJP ='ja-JP';
    SMKTAU ='en-AU';
    SMKTUK ='en-UK';
    SMKTDE ='de-DE';
    SMKTNZ ='en-NZ';
    SMKTCA ='en-CA';

    BingResponseXML='xml';
    BingResponseJSON='js';

    //array must sorted By width ,this array is gen by project1.exe
    BingSupportedResolution:array [1..25] of array [1..2] of Integer=(
     (240,240),
     (240,320),
     (240,400),
     (320,240),
     (320,320),
     (360,480),
     (400,240),
     (480,360),
     (480,640),
     (480,800),
     (540,900),
     (640,480),
     (720,1280),
     (768,1024),
     (768,1280),
     (768,1366),
     (800,480),
     (800,600),
     (900,540),
     (1024,768),
     (1280,720),
     (1280,768),
     (1366,768),
     (1920,1080),
     (1920,1200)
     );

  type
    TBingResponseFormat = (brfXml, brfJson);
    TBingResquestMkt = (mktCN,mktUS,mktJP, mktAU, mktUK, mktDE, mktNZ, mktCA);

  var
    ErrorString:String;
implementation

end.

