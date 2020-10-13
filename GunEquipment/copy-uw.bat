SET MOD_NAME=GunEquipment
SET MOD_TITLE=Gun Equipment
SET MOD_DEPENDENCIES="(?) Krastorio2 >= 1.0.0"
SET MOD_AUTHOR=DeznekCZ
SET MOD_AUTHOR_CONTACT=www.facebook.com/DeznekCZ
SET MOD_HOMEAPAGE=
SET MOD_DESCRIPTION=Mode add automatic guns applyable to equipment grid.

SET FACTORIO_VERSION=1.0
SET FACTORIO_VERSION_MIN=1.0.0

SET PREVIOUS_VERSION=0.0.13
SET LAST_VERSION=0.0.14

SET MOD_LOCATION=%1
SET PREVIOUS_VERSION_LOCATION=%APPDATA%\Factorio\mods\%MOD_NAME%_%PREVIOUS_VERSION%
SET LAST_VERSION_LOCATION=%APPDATA%\Factorio\mods\%MOD_NAME%_%LAST_VERSION%

IF exist "%PREVIOUS_VERSION_LOCATION%\" RD /S /Q "%PREVIOUS_VERSION_LOCATION%"
IF exist "%LAST_VERSION_LOCATION%\"     RD /S /Q "%LAST_VERSION_LOCATION%"

XCOPY "%MOD_LOCATION%\src" "%LAST_VERSION_LOCATION%" /S /I
@rem XCOPY "%MOD_LOCATION%\graphics" "%LAST_VERSION_LOCATION%\graphics" /S /I
@rem XCOPY "%MOD_LOCATION%\migrations" "%LAST_VERSION_LOCATION%\migrations" /S /I

SET JSON=%LAST_VERSION_LOCATION%/info.json

echo {                                                                            >> %JSON%
echo   "name":             "%MOD_NAME%",                                          >> %JSON%
echo   "version":          "%LAST_VERSION%",                                      >> %JSON%
echo   "title":            "%MOD_TITLE%",                                         >> %JSON%
echo   "author":           "%MOD_AUTHOR%",                                        >> %JSON%
echo   "contact":          "%MOD_AUTHOR_CONTACT%",                                >> %JSON%
echo   "homepage":         "%MOD_HOMEAPAGE%",                                     >> %JSON%
echo   "description":      "%MOD_DESCRIPTION%",                                   >> %JSON%
echo   "factorio_version": "%FACTORIO_VERSION%",                                  >> %JSON%
@rem echo   "dependencies":     ["base >= %FACTORIO_VERSION_MIN%" ]                    >> %JSON%
echo   "dependencies":     ["base >= %FACTORIO_VERSION_MIN%", %MOD_DEPENDENCIES%] >> %JSON%
echo }                                                                            >> %JSON%

DEL %LAST_VERSION_LOCATION%.zip
"C:\Program Files\7-Zip\7z.exe" a %LAST_VERSION_LOCATION%.zip %LAST_VERSION_LOCATION%
