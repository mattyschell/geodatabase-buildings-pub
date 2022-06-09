REM change these 
set DBENV=XXX
set DBNAME=XXX_xxx_Xxx
set SOURCEDB=xxxXXxxx
REM unmask these
set BASEPATH=C:\xxx
set NOTIFY=xxxx@xxx.xxx.xxx
set NOTIFYFROM=xxxx@xxx.xx.xxx
set SMTPFROM=xxxx.xxxx
REM review these should be good
set SDEFILE=%BASEPATH%\connections\sqlserver\%DBENV%\%DBNAME%\sl_%DBNAME%_gispub.sde
set SOURCEFC=%BASEPATH%\connections\oracle19c\%DBENV%\GIS-%SOURCEDB%\bldg.sde\BLDG.BUILDING
set TARGETFC=oti_building
set TARGETLOGDIR=%BASEPATH%\geodatabase-scripts\logs\geodatabase-buildings-pub\
set TOILER=%BASEPATH%\geodatabase-toiler\
set BUILDINGSPUB=%BASEPATH%\geodatabase-buildings-pub\
set PYTHONPATH=%TOILER%src\py;%BUILDINGSPUB%
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set BATLOG=%TARGETLOGDIR%building_import.log
echo starting building import to target %TARGETFC% on %date% at %time% > %TARGETLOGDIR%import.log
%PROPY% %BUILDINGSPUB%src\py\delete.py %TARGETFC% && (
   echo. deleted target %TARGETFC% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGSPUB%src\py\notify.py ": Failed to delete %TARGETFC% on %SDEFILE%" %NOTIFY% "import" && EXIT /B 1
)  
%PROPY% %BUILDINGSPUB%src\py\import.py %TARGETFC% %SOURCEFC% && (
   echo. >> %BATLOG% echo imported target %TARGETFC% on %date% at %time% >> %BATLOG%
) || (
%PROPY% %BUILDINGSPUB%src\py\notify.py ": Failed to import %TARGETFC% on %SDEFILE%" %NOTIFY% "import" && EXIT /B 1
) 
