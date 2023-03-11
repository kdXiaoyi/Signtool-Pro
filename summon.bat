@echo off
title Signtool Pro - SUMMON
mode CON: COLS=80 LINES=30
cls
goto check/main

:check/main
echo ^> ����һ��ǩ���ļ�
echo ===============================================================================
echo.
echo         ���ڼ�顭��
echo.
echo  Made by kdXiaoyi.
echo ===============================================================================
timeout /t 3 >nul
if not exist lib\cert2spc.exe (
    set lostFile=cert2spc.exe
    goto check/lost
)
if not exist lib\makecert.exe (
    set lostFile=makecert.exe
    goto check/lost
)
if not exist lib\pvk2pfx.exe (
    set lostFile=pvk2pfx.exe
    goto check/lost
)
if not exist lib\prepare.exe (
    set lostFile=prepare.exe
    goto check/lost
)
goto SUMMON/name

:check/lost
cls
echo ^> ����һ��ǩ���ļ�
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

:summon/name
lib\prepare.exe
cls
echo ^> ����һ��ǩ���ļ�
echo ===============================================================================
echo.
echo         ����д֤����
echo.
echo  Made by kdXiaoyi.
echo ===============================================================================
set /p name=#^> 
if "%name%"=="" (
    echo.
    echo ֤�������Ϸ�
    pause>nul
    goto summon/name
)
goto summon/creative.iKey.input

:summon/creative.iKey.input
md CERT
cls
rem ˽Կ��д
echo ^> ����һ��ǩ���ļ�
echo ===============================================================================
echo.
echo         ����д˽Կ
echo.
echo   [!] ͨ��˽Կ�����⹫�������������
echo   [!] �Ժ󽫻�����֤˽Կ
echo.
echo  Made by kdXiaoyi.
echo ===============================================================================
lib\Makecert.exe -sv cert\PVK.pvk -r -n "CN=%name%" cert\CER.cer
echo Backcode:%errorlevel%
timeout /t 1 >nul
goto summon/creative.spc.out

:summon/creative.spc.out
cls
rem ����������֤��
echo ^> ����һ��ǩ���ļ�
echo ===============================================================================
echo.
echo         ����������֤��...
echo.
echo.
echo  Made by kdXiaoyi.
echo ===============================================================================
lib\Cert2spc.exe cert\CER.cer cert\SPC.spc
echo Backcode:%errorlevel%
timeout /t 1 >nul
goto summon/creative.pfx.out

:summon/creative.pfx.out
cls
rem ����PFX֤���ļ�
echo ^> ����һ��ǩ���ļ�
echo ===============================================================================
echo.
echo         ����PFX֤�顭��
echo.
echo   [!] Ϊ�˱�֤��ȫ�ԣ�����Ҫ��֤���ղ���д��˽Կ
echo.
echo  Made by kdXiaoyi.
echo ===============================================================================
lib\pvk2pfx.exe -pvk cert\PVK.pvk -spc cert\SPC.spc -pfx cert\PFX.pfx -f >>nul
echo Backcode:%errorlevel%
timeout /t 1 >nul
goto summon/finish

:summon/finish
cls
echo ^> ����һ��ǩ���ļ�
echo ===============================================================================
echo.
echo    ��ϲ! ���ѳɹ�����һ��ǩ���ļ���
echo.
echo   ����һ������ǩ���ļ���
echo   CER.cer ^| DER    ^| ����˽Կ����������������Ϣ�͹�Կ   ���Թ���
echo   PFX.pfx ^| PKCS12 ^| ����˽Կ�͹�Կ�Լ���������Ϣ       �Ͻ�����
echo   SPC.spc ^| SPC    ^| ���ڱ��湫Կ��   ΢�����
echo   PVK.pvk ^| SPC    ^| ���ڱ���˽Կ��   ΢�����
echo.
echo   [!] ������ǩ֤��ͨ�����������豸���Σ���Ҫ���뵽[�����εĸ�֤��䷢����]�洢�⡣
echo.
echo  �ڵȴ����������Խ����򵼲���֤��Ŀ¼��
echo.
echo  Made by kdXiaoyi.
echo ===============================================================================
timeout /t 10 /NOBREAK>>nul
echo �����ڿ��԰�������������򵼡�
pause>nul
explorer.exe /root,%cd%\cert
exit /b 0