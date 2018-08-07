SET MOD_NAME=CoalPowered
SET PREVIOUS_VERSION=0.0.2
SET LAST_VERSION=0.0.3
SET MOD_LOCATION=C:\Users\zdeno\git\%MOD_NAME%\%MOD_NAME%

SET PREVIOUS_VERSION_LOCATION=%APPDATA%\Factorio\mods\%MOD_NAME%_%PREVIOUS_VERSION%
SET LAST_VERSION_LOCATION=%APPDATA%\Factorio\mods\%MOD_NAME%_%LAST_VERSION%

IF exist "%PREVIOUS_VERSION_LOCATION%\" RD /S /Q "%PREVIOUS_VERSION_LOCATION%"
IF exist "%LAST_VERSION_LOCATION%\"     RD /S /Q "%LAST_VERSION_LOCATION%"

XCOPY "%MOD_LOCATION%\src" "%LAST_VERSION_LOCATION%" /S /I
XCOPY "%MOD_LOCATION%\graphics" "%LAST_VERSION_LOCATION%\graphics" /S /I
