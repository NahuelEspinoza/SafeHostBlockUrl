::SafeHost  BlockUrl 3.5
::by Carlos
::Accepts parameter by the name of a text file with a list of urls
 
@echo off
setlocal
color 0a
echo #############################
echo #                           #
echo #   " SafeHost BlockUrl "   #
echo #          v3.5             #
echo #############################
echo #     Made in Argentina     #
echo #############################
echo #         by. Naes          #
echo #############################
color 0b
echo
::echo Add url: Agregar URL.
::echo Del url: Eliminar URL.
::echo Show urls: Mostrar URLs.
::echo Exit: Salir.
::echo Options: Opciones.
::echo Enter option: Ingrese opción.
::echo Enter Url to del: Ingrese URL a eliminar.
::echo Is that correct? [y/n/cancel]: ¿Es eso correcto? [s/n/cancel].
::echo You joined address to del: Usted unió la dirección a eliminar.
::echo The url has been deleted: La URL ha sido eliminada.
::echo Enter Url to add: Ingrese URL a agregar.
::echo You joined address to add: Usted unió la dirección a agregar.
::echo The url has been added: La URL ha sido agregada.

 
set FILE=%SystemRoot%\system32\drivers\etc\hosts
set IP=0.0.0.0
set argfile=%~1
set findstr="%WinDir%\system32\findstr.exe"
set find="%WinDir%\system32\find.exe"
 
:start
call :logo
call :mode
exit
 
:lock
call :logo
set option=
echo Options:
echo - 1 Add url
echo - 2 Del url
echo - 3 Show urls
echo - 4 Exit
echo.
set /p option=Enter option:
if not defined option (goto lock)
if ["%option%"]==["1"] (goto add)
if ["%option%"]==["2"] (goto del)
if ["%option%"]==["3"] (goto show)
if ["%option%"]==["4"] (goto exit)
goto lock
set option | %find% """" >NUL 2>&1 && goto lock
set option | %find% " " >NUL 2>&1 && goto lock
set option | %findstr% "| & ^ > < # $ ' ` . ; , / \  + - ~ ! ) ( ] [ } { :  style="color: #b100b1; font-weight: bold;">? *" >NUL 2>&1 && goto lock
echo %option% | find "=" >NUL 2>&1 && goto lock
if not [{carlitos.dll}]==[{%option%}] (echo off) 2>NUL
if "%errorlevel%"=="9009" (goto lock)
goto lock
 
:show
echo.
echo LIST URL BLOCK
echo.
type "%FILE%" | %findstr% /b /v "#" | sort | more
echo.
pause
goto lock
goto:eof
 
:del
echo.
set delurl=
set /p delurl="Enter Url to del: "
if not defined delurl (goto del)
set delurl | %find% """" >NUL 2>&1 && goto del
set delurl | %find% " " >NUL 2>&1 && goto del
set delurl | %findstr% "| & ^ > < # $ ' ` ; , \  + ~ ! ) ( ] [ } { ? *" >NUL 2>&1 && goto del
echo %delurl% | find "=" >NUL 2>&1 && goto del
if not [{carlitos.dll}]==[{%delurl%}] (echo off) 2>NUL
if "%errorlevel%"=="9009" (goto del)
goto yesoryes
 
:yesoryes
echo.
echo You joined address to del: %delurl%
set confirm=
set /p confirm="Is that correct? [y/n/cancel]: "
if not defined confirm (goto yesoryes)
set confirm | %find% """" >NUL 2>&1 && goto yesoryes
set confirm | %find% " " >NUL 2>&1 && goto yesoryes
set confirm | %findstr% "| & ^ > < # $ ' ` . ; , / \  + - ~ ! ) ( ] [ } { :  style="color: #b100b1; font-weight: bold;">? *" >NUL 2>&1 && goto yesoryes
echo %confirm% | find "=" >NUL 2>&1 && goto yesoryes
if not [{carlitos.dll}]==[{%confirm%}] (echo off) 2>NUL
if "%errorlevel%"=="9009" (goto yesoryes)
if /i "%confirm%"=="y" (goto find)
if /i "%confirm%"=="n" (goto del)
if /i "%confirm%"=="cancel" (goto lock)
goto yesoryes
 
:find
type "%FILE%" | %findstr% /i "%delurl%$" >nul && (
cd.>"%FILE%.bak" ||goto message
type "%FILE%" | %findstr% /i /v "%delurl%$">"%FILE%.bak"
del/f/q/a "%FILE%" >nul ||goto message
ren "%FILE%.bak" "hosts" >nul ||goto message
echo The url has been deleted.
) || (echo The url not found.)
pause
goto lock
 
:add
echo.
set url=
set /p url="Enter Url to add: "
if not defined url (goto add)
set url | %find% """" >NUL 2>&1 && goto add
set url | %find% " " >NUL 2>&1 && goto add
set url | %findstr% "| & ^ > < # $ ' ` ; , \  + ~ ! ) ( ] [ } { ? *" >NUL 2>&1 && goto add
echo %url% | find "=" >NUL 2>&1 && goto add
if not [{carlitos.dll}]==[{%url%}] (echo off) 2>NUL
if "%errorlevel%"=="9009" (goto add)
goto yesorno
 
:yesorno
echo.
echo You joined address to add: %url%
set confirm=
set /p confirm="Is that correct? [y/n/cancel]: "
if not defined confirm (goto yesorno)
set confirm | %find% """" >NUL 2>&1 && goto yesorno
set confirm | %find% " " >NUL 2>&1 && goto yesorno
set confirm | %findstr% "| & ^ > < # $ ' ` . ; , / \  + - ~ ! ) ( ] [ } { :  style="color: #b100b1; font-weight: bold;">? *" >NUL 2>&1 && goto yesorno
echo %confirm% | find "=" >NUL 2>&1 && goto yesorno
if not [{carlitos.dll}]==[{%confirm%}] (echo off) 2>NUL
if "%errorlevel%"=="9009" (goto yesorno)
if /i "%confirm%"=="y" (goto verify_0)
if /i "%confirm%"=="n" (goto add)
if /i "%confirm%"=="cancel" (goto lock)
goto yesorno
 
:attrib
if not exist "%FILE%" (echo.>>"%FILE%"||goto message)
attrib -r -h -s "%FILE%">NUL||goto message)
goto:eof
 
:mode
if defined argfile (if exist "%argfile%" (goto argmode))
goto lock
goto:eof
 
:argmode
for /f %%a in ('type "%argfile%"') do (set url=%%a&call:verify_1&set url=)
goto exit
 
:verify_0
if /i "%url:~0,4%"=="www." (goto with0)
goto without0
 
:verify_1
set url | %find% """" >NUL 2>&1 && goto:eof
set url | %find% " " >NUL 2>&1 && goto:eof
set url | %findstr% "| & ^ > < # $ ' ` ; , \  + ~ ! ) ( ] [ } { ? *" >NUL 2>&1 && goto:eof
echo %url% | find "=" >NUL 2>&1 && goto:eof
if not [{carlitos.dll}]==[{%url%}] (echo off) 2>NUL
if "%errorlevel%"=="9009" (goto:eof)
if /i "%url:~0,4%"=="www." (goto with1)
goto without1
 
goto:eof
 
:with0
call :with1
goto again
 
:without0
call :without1
goto again
 
:with1
call :attrib
echo %IP%    %url:~4%>>"%FILE%"||goto message
echo %IP%    www.%url:~4%>>"%FILE%"||goto message
echo The url has been added.
goto:eof
 
:without1
call :attrib
echo %IP%    %url%>>"%FILE%"||goto message
echo %IP%    www.%url%>>"%FILE%"||goto message
echo The url has been added.
goto:eof
 
:again
echo.
set again=
set /p again="Add other url? [y/n]"
if /i "%again%"=="y" (goto add)
if /i "%again%"=="n" (goto lock)
goto again
 
:logo
cls
echo *****************************
echo ** SafeHost BlockUrl v3.5  **
echo ******** by. Naes ***********
echo *****************************
echo.
call:attrib
goto:eof
 
:message
echo You do not have sufficient privileges.
pause
goto exit
 
:exit
endlocal
exit
 
::SafeHost BlockUrl 3.5
::by. Naes 
::Made in Arg. 