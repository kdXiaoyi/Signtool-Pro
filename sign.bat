@echo off&goto start
:USERS
::::::�����Զ���һЩ����

rem tU���ڶ���ʱ�����ȡ��ַ��������д��
set tU=http://ca.signfiles.com/TSAServer.aspx

rem tUb Ϊ����ʱ�����ַ��������д��
set tUb2=http://tsa.starfieldtech.com
set tUb3=http://timestamp.gobalsign.com/scripts/timestamp.dll
set tUb4=
::::::users.sub.end
goto menu.exec.path

:start
title Signtool Pro - SIGN
mode CON: COLS=80 LINES=30
if not exist lib\signtool.exe (
    set lostFile=signtool.exe
    goto lost
)
if not exist lib\prepare.exe (
    set lostFile=prepare.exe
    goto lost
)
::::::��ΪһЩBUG��ban
rem if exist "%1" (
rem    set exec=%1
rem    goto menu.pfx.path
rem )
goto users

:lost
cls
echo ^> ǩ���ļ�
echo ===============================================================================
echo.
echo         ����δ���ҵ��ļ�
echo    File [%LostFile%] has been lost.
echo    ������ȫ����ѹ������
echo.
echo  Made by kdXiaoyi.
echo ===============================================================================
pause>nul
exit /b 1

:menu.exec.path
cls
set exec=test.exe
echo ^> ǩ���ļ�
echo ===============================================================================
echo.
echo         ������Ҫǩ�����ļ�·����(�������)
echo         ��Ҳ���Խ��ļ����뱾���ں󰴻س�����
echo.%1
echo  Made by kdXiaoyi.
echo ===============================================================================
set /p exec=#^> 
if not exist %exec% (
    echo.
    echo ��Ч·��
    pause>nul
    goto menu.exec.path
)
if exist "%exec%" set exec="%exec%"
goto menu.pfx.path

:menu.pfx.path
cls
echo ^> ǩ���ļ�
echo ===============================================================================
echo.
echo         ������֤��·����(�������)
echo         ��Ҳ���Խ��ļ����뱾���ں󰴻س�����
echo.
echo   [!] ��pfx֤�����[cert\]Ŀ¼�²�����Ϊ[sign.pfx]����һ����ֱ��������
echo.
echo  Made by kdXiaoyi.
echo ===============================================================================
if exist "CERT\sign.pfx" (
    echo  ��⵽SIGN֤�顣
    set pfx=cert\sign.pfx
    goto sign_password
)
set /p pfx=#^> 
if not exist %pfx% (
    echo.
    echo ��Ч·��
    pause>nul
    goto menu.pfx.path
)
goto sign_password

:sign_password
cls
echo ^> ǩ���ļ�
echo ===============================================================================
echo.
echo         ����ǩ���ļ�����
echo.
echo   [!] Ϊ�˱�֤��ȫ�ԣ�����Ҫ��֤˽Կ
echo.
echo  Made by kdXiaoyi.
echo ===============================================================================
rem ��ʾ����˽Կ
set /p passwd=����˽Կ��û�������գ���ʾ���룩��
goto sign_sign

:sign_sign
cls
rem ǩ��ʱ��������
lib\prepare.exe
set bad=0
cls
echo ^> ǩ���ļ�
echo ===============================================================================
echo.
echo         ����ǩ���ļ�����
echo.
echo   [!] Ϊ�˱�֤��ȫ�ԣ�����Ҫ��֤˽Կ
echo.
echo  Made by kdXiaoyi.
echo ===============================================================================
echo ����˽Կ��û�������գ��������룩��******
if "%passwd%"=="" (lib\signtool.exe sign /v /f "%pfx%" %exec%) else (echo ���ṩ˽Կ��&lib\signtool.exe sign /p "%passwd%" /v /f "%pfx%" %exec%)
if "%errorlevel%"=="1" (
    rem /// TO DO ///
    echo ===============================================================================
    echo.
    echo         ǩ��ʧ�ܡ���鿴�����Ѱ�Ҵ���
    echo.
    echo ===============================================================================
    pause>nul
    set bad=1
)

rem ��ʱ���
lib\signtool timestamp /v /t %tU% %exec%
if "%errorlevel%"=="1" (
    echo ===============================================================================
    echo.
    echo         �Ӹ�ʱ�����1��ʧ�ܡ���鿴�����Ѱ�Ҵ���
    echo.
    echo ===============================================================================
    pause>nul
) else (
	echo ===============================================================================
	echo.
	echo         ʱ�����1���ѼӸǡ�
	echo.
	echo ===============================================================================
)
if not "%tUb2%"=="" (
	lib\signtool timestamp /v /t %tUb2% %exec%
	if "%errorlevel%"=="1" (
		echo ===============================================================================
		echo.
		echo         �Ӹ�ʱ�����2��ʧ�ܡ���鿴�����Ѱ�Ҵ���
		echo.
		echo ===============================================================================
		pause>nul
	) else (
		echo ===============================================================================
		echo.
		echo         ʱ�����2���ѼӸǡ�
		echo.
		echo ===============================================================================
	)
)
if not "%tUb3%"=="" (
	lib\signtool timestamp /v /t %tUb3% %exec%
	if "%errorlevel%"=="1" (
		echo ===============================================================================
		echo.
		echo         �Ӹ�ʱ�����3��ʧ�ܡ���鿴�����Ѱ�Ҵ���
		echo.
		echo ===============================================================================
		pause>nul
	) else (
		echo ===============================================================================
		echo.
		echo         ʱ�����3���ѼӸǡ�
		echo.
		echo ===============================================================================
	)
)
if not "%tUb4%"=="" (
	lib\signtool timestamp /v /t %tUb4% %exec%
	if "%errorlevel%"=="1" (
		echo ===============================================================================
		echo.
		echo         �Ӹ�ʱ�����4��ʧ�ܡ���鿴�����Ѱ�Ҵ���
		echo.
		echo ===============================================================================
		pause>nul
	) else (
		echo ===============================================================================
		echo.
		echo         ʱ�����4���ѼӸǡ�
		echo.
		echo ===============================================================================
	)
)

rem ������
if not "%bad%"=="1" (
    echo.
    echo ǩ�������ѳɹ�ִ�С�
    echo 0=���ļ�Ŀ¼���˳�    1=�˳���    2=��ǩ��һ������
    echo.
) else (
    echo.
    echo.
    echo δ�����ǩ������
    echo 0=���ļ�Ŀ¼���˳�    1=�˳���    2=��ǩ��һ������
    echo.
)
echo ===============================================================================
choice /C 012 /N /M [0/1/2]^> 
if "%errorlevel%"=="1" explorer.exe /select,"%exec%"
if "%errorlevel%"=="3" goto menu.exec.path
exit /b 0