unit uUrlParam;

interface
   type
     TBingResponseFormat = (brfXml,brfJson);
     TBingResquestMkt = (mktUS, mktCN, mktJP, mktAU, mktUK, mktDE, mktNZ, mktCA);
     TBingUrlParam=record
       format:TBingResponseFormat;
       {The startDateindex parameter tells where you want to start from.
       0 would start at the current day,
       1 the previous day,
       2 the day after that,
       etc.
       For instance,
       if the date were 1/30/2011, using idx = 0, the file would start with 20110130;
       using idx = 1, it would start with 20110129; and so forth.}
       startDateindex:Integer;
       instanceCount:Integer;
       mkt:TBingResquestMkt;
     end;
implementation

end.
