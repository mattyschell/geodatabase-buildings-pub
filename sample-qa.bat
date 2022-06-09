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
set BATLOG=%TARGETLOGDIR%\%TARGETFC%_qa.log
echo starting qa of %TARGETFC% on %date% at %time% > %BATLOG%
rem %PROPY% %BUILDINGSPUB%src\py\qa.py %TARGETFC% && (
rem    echo. >> %BATLOG% echo QA'd %TARGETFC% on %date% at %time% >> %BATLOG%
rem ) || (
rem %PROPY% %BUILDINGSPUB%src\py\notify.py ": Failed qa of %TARGETFC% on %SDEFILE%" %NOTIFY% "import" && EXIT /B 1
rem ) 
%PROPY% %BUILDINGSPUB%src\py\qa.py %TARGETFC%