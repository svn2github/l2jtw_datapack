@echo off
REM 防止從聖翼使命更新到芙蕾雅後,因DP的大變動而造成GS出錯
IF EXIST "C:\L2JTW-SVN\L2JTW_GameServer_Gracia" RD /S /Q "C:\L2JTW-SVN\L2JTW_GameServer_Gracia"
IF EXIST "C:\L2JTW-SVN\L2JTW_GameServer_Gracia" RMDIR /S /Q "C:\L2JTW-SVN\L2JTW_GameServer_Gracia"
IF EXIST "..\gameserver\data\stats\armor"   RD /S /Q "..\gameserver\data\stats\armor"
IF EXIST "..\gameserver\data\stats\etcitem" RD /S /Q "..\gameserver\data\stats\etcitem"
IF EXIST "..\gameserver\data\stats\weapon"  RD /S /Q "..\gameserver\data\stats\weapon"
IF EXIST "..\gameserver\data\stats\skills\??00-??99.xml"  DEL /Q "..\gameserver\data\stats\skills\??00-??99.xml"
IF EXIST "..\gameserver\data\stats\armor"   RMDIR /S /Q "..\gameserver\data\stats\armor"
IF EXIST "..\gameserver\data\stats\etcitem" RMDIR /S /Q "..\gameserver\data\stats\etcitem"
IF EXIST "..\gameserver\data\stats\weapon"  RMDIR /S /Q "..\gameserver\data\stats\weapon"
REM ##############################################
REM ## L2JDP Database Installer - (by DrLecter) ##
REM ##############################################
REM ## Interactive script setup -  (by TanelTM) ##
REM ##############################################
REM Copyright (C) 2010 L2J DataPack
REM This program is free software; you can redistribute it and/or modify 
REM it under the terms of the GNU General Public License as published by 
REM the Free Software Foundation; either version 2 of the License, or (at
REM your option) any later version.
REM
REM This program is distributed in the hope that it will be useful, but 
REM WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
REM or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
REM for more details.
REM
REM You should have received a copy of the GNU General Public License along 
REM with this program; if not, write to the Free Software Foundation, Inc., 
REM 675 Mass Ave, Cambridge, MA 02139, USA. Or contact the Official L2J
REM DataPack Project at http://www.l2jdp.com, http://www.l2jdp.com/forum or
REM #l2j @ irc://irc.freenode.net

set config_file=vars.txt
set config_version=0

set workdir="%cd%"
set full=0
set stage=0
set logging=0

set upgrade_mode=0
set backup=.
set logdir=.
set safe_mode=1
set cmode=c
set fresh_setup=0

:loadconfig
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
if not exist %config_file% goto configure
ren %config_file% vars.bat
call vars.bat
ren vars.bat %config_file%
call :colors 17
if /i %config_version% == 2 goto ls_section
set upgrade_mode=2
echo 您似乎是第一次使用這個版本的 database_installer
echo 但是我發現安裝資料庫的設定檔已經存在
echo 因此我將問您幾個問題，引導您繼續安裝
echo.
echo 更新設定選項：
echo.
echo (1) 導入＆繼續使用舊的設定：將使用原本舊的資料並且進行更新作業
echo.
echo (2) 導入＆使用新的設定：導入新的資料並且重新設定資料
echo.
echo (3) 導入全新的資料：所有舊的資料將會移除並且導入新的資料
echo.
echo (4) 查看存取的設定值
echo.
echo (5) 退出
echo.
set /P upgrade_mode="輸入數字後，請按 Enter（預設值為「%upgrade_mode%」）: "
if %upgrade_mode%==1 goto ls_section
if %upgrade_mode%==2 goto configure
if %upgrade_mode%==3 goto configure
if %upgrade_mode%==4 (cls&type %config_file%&pause&goto loadconfig)
if %upgrade_mode%==5 goto :eof
goto loadconfig

:colors
if /i "%cmode%"=="n" (
if not "%1"=="17" (	color F ) else ( color )
) else ( color %1 )
goto :eof

:configure
call :colors 17
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
set config_version=2
if NOT %upgrade_mode% == 2 (
set fresh_setup=1
set mysqlBinPath=%ProgramFiles%\MySQL\MySQL Server 5.0\bin

:_MySQL51
if not exist "%ProgramFiles%\MySQL\MySQL Server 5.1\bin\mysql.exe" goto _MySQL55
set mysqlBinPath=%ProgramFiles%\MySQL\MySQL Server 5.1\bin

:_MySQL55
if not exist "%ProgramFiles%\MySQL\MySQL Server 5.5\bin\mysql.exe" goto _MySQL60
set mysqlBinPath=%ProgramFiles%\MySQL\MySQL Server 5.5\bin

:_MySQL60
if not exist "%ProgramFiles%\MySQL\MySQL Server 6.0\bin\mysql.exe" goto _AppServ
set mysqlBinPath=%ProgramFiles%\MySQL\MySQL Server 6.0\bin

:_AppServ
if not exist "%SystemDrive%\AppServ\MySQL\bin\mysql.exe" goto _other
set mysqlBinPath=%SystemDrive%\AppServ\MySQL\bin

:_other
set lsuser=root
set lspass=
set lsdb=l2jdb
set lshost=localhost
set cbuser=root
set cbpass=
set cbdb=l2jcb
set cbhost=localhost
set gsuser=root
set gspass=
set gsdb=l2jdb
set gshost=localhost
set cmode=c
set backup=.
set logdir=.
)
set mysqlPath=%mysqlBinPath%\mysql.exe
echo 新的設定值：
echo.
echo 1.MySql 程式
echo --------------------
echo 請設定 mysql.exe 和 mysqldump.exe 的位置
echo.
if "%mysqlBinPath%" == "" (
set mysqlBinPath=use path
echo 沒有找到 MySQL 的位置
) else (
echo 請測試以下所找到的 MySQL 位置，是否可以進行導入作業
echo.
echo %mysqlPath%
)
if not "%mysqlBinPath%" == "use path" call :binaryfind
echo.
path|find "MySQL">NUL
if %errorlevel% == 0 (
echo 上面是找到的 MySQL，此位置將會被設為預設值，如果想換位置請修改...
set mysqlBinPath=use path
) else (
echo 無法找到 MySQL，請輸入 mysql.exe 的位置...
echo.
echo 如果不確定這是什麼意思和如何操作，請到相關網站查詢或者至 L2JTW 官方網站發問或尋找相關資訊
)
echo.
echo 請輸入 mysql.exe 的位置：
set /P mysqlBinPath="(default %mysqlBinPath%): "
cls
echo.
echo 2.登入伺服器設定
echo --------------------
echo 此作業將會連線至所指定的 MySQL 伺服器，並且進行導入作業
echo.
set /P lsuser="使用者名稱（預設值「%lsuser%」）: "
:_lspass
set /P lspass="使用者密碼（預設值「%lspass%」）: "
if "%lspass%"=="" goto _lspass
set /P lsdb="資料庫（預設值「%lsdb%」）: "
set /P lshost="位置（預設值「%lshost%」）: "
if NOT "%lsuser%"=="%gsuser%" set gsuser=%lsuser%
if NOT "%lspass%"=="%gspass%" set gspass=%lspass%
if NOT "%lsdb%"=="%gsdb%" set gsdb=%lsdb%
if NOT "%lshost%"=="%gshost%" set gshost=%lshost%
if NOT "%lsuser%"=="%cbuser%" set cbuser=%lsuser%
if NOT "%lspass%"=="%cbpass%" set cbpass=%lspass%
if NOT "%lsdb%"=="%cbdb%" set cbdb=l2jcb
if NOT "%lshost%"=="%cbhost%" set cbhost=%lshost%
echo.
cls
echo.
echo 3-討論版伺服器設定
echo --------------------
echo 此作業將會連線至「討論版專用」的 MySQL 伺服器，並且進行導入作業
echo.
set /P cbuser="使用者名稱（預設值「%cbuser%」）: "
:_cbpass
set /P cbpass="使用者密碼（預設值「%cbpass%」）: "
if "%cbpass%"=="" goto _cbpass
set /P cbdb="資料庫（預設值「%cbdb%」）: "
set /P cbhost="位置（預設值「%cbhost%」）: "
echo.
echo 4.遊戲伺服器設定
echo --------------------
set /P gsuser="使用者名稱（預設值「%gsuser%」）: "
set /P gspass="使用者密碼（預設值「%gspass%」）: "
set /P gsdb="資料庫（預設值「%gsdb%」）: "
set /P gshost="位置（預設值「%gshost%」）: "
echo.
echo 5.其他設定
echo --------------------
set /P cmode="顏色模式 (c)為顏色 或 (n)為無顏色（預設值「%cmode%」）: "
set /P backup="備份位置（預設值「%backup%」）: "
set /P logdir="Logs訊息位置（預設值「%logdir%」）: "
:safe1
set safemode=y
set /P safemode="Debug 模式（y/n， 預設值「%safemode%」）: "
if /i %safemode%==y (set safe_mode=1&goto safe2)
if /i %safemode%==n (set safe_mode=0&goto safe2)
goto safe1
:safe2
echo.
if "%mysqlBinPath%" == "use path" (
set mysqlBinPath=
set mysqldumpPath=mysqldump
set mysqlPath=mysql
) else (
set mysqldumpPath=%mysqlBinPath%\mysqldump.exe
set mysqlPath=%mysqlBinPath%\mysql.exe
)
echo @echo off > %config_file%
echo set config_version=%config_version% >> %config_file%
echo set cmode=%cmode%>> %config_file%
echo set safe_mode=%safe_mode% >> %config_file%
echo set mysqlPath=%mysqlPath%>> %config_file%
echo set mysqlBinPath=%mysqlBinPath%>> %config_file%
echo set mysqldumpPath=%mysqldumpPath%>> %config_file%
echo set lsuser=%lsuser%>> %config_file%
echo set lspass=%lspass%>> %config_file%
echo set lsdb=%lsdb%>> %config_file%
echo set lshost=%lshost% >> %config_file%
echo set cbuser=%cbuser%>> %config_file%
echo set cbpass=%cbpass%>> %config_file%
echo set cbdb=%cbdb%>> %config_file%
echo set cbhost=%cbhost% >> %config_file%
echo set gsuser=%gsuser%>> %config_file%
echo set gspass=%gspass%>> %config_file%
echo set gsdb=%gsdb%>> %config_file%
echo set gshost=%gshost%>> %config_file%
echo set logdir=%logdir%>> %config_file%
echo set backup=%backup%>> %config_file%
echo.
echo 設定成功！
echo 你的設定值將會儲存在「%config_file%」，所有的帳號密碼將以明文顯示
echo.
echo 請按任意鍵繼續 . . .
pause> nul
goto loadconfig

:ls_section
cls
call :colors 17
set cmdline=
set stage=1
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo.
echo 正在備份登入伺服器的資料庫...
set cmdline="%mysqldumpPath%" --add-drop-table -h %lshost% -u %lsuser% --password=%lspass% %lsdb% ^> "%backup%\loginserver_backup.sql" 2^> NUL
%cmdline%
if %ERRORLEVEL% == 0 goto lsdbok
REM if %safe_mode% == 1 goto omfg
:ls_err1
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo.
echo 備份失敗！
echo 原因是因為資料庫不存在
echo 現在可以幫你建立 %lsdb%，或者繼續其它設定
echo.
:ls_ask1
set lsdbprompt=y
echo 建立登入伺服器的資料庫？
echo.
echo (y)確定
echo.
echo (n)取消
echo.
echo (r)重新設定
echo.
echo (q)退出
echo.
set /p lsdbprompt=請選擇（預設值-確定）:
if /i %lsdbprompt%==y goto lsdbcreate
if /i %lsdbprompt%==n goto cb_backup
if /i %lsdbprompt%==r goto configure
if /i %lsdbprompt%==q goto end
goto ls_ask1

:omfg
cls
call :colors 57
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo.
echo 執行時出現錯誤：
echo.
echo "%cmdline%"
echo.
echo 建議檢查一下設定的資料，以確保所有輸入的數值沒有錯誤！
echo.
if %stage% == 1 set label=ls_err1
if %stage% == 2 set label=ls_err2
if %stage% == 3 set label=cb_backup
if %stage% == 4 set label=cb_err1
if %stage% == 5 set label=cb_err2
if %stage% == 6 set label=gs_backup
if %stage% == 7 set label=gs_err1
if %stage% == 8 set label=gs_err2
if %stage% == 9 set label=horrible_end
if %stage% == 10 set label=horrible_end
:omfgask1
set omfgprompt=q
echo (c)繼續
echo.
echo (r)重新設定
echo.
echo (q)退出
echo.
set /p omfgprompt=請選擇（預設值-退出）:
if  /i %omfgprompt%==c goto %label%
if  /i %omfgprompt%==r goto configure
if  /i %omfgprompt%==q goto horrible_end
goto omfgask1

:lsdbcreate
call :colors 17
set cmdline=
set stage=2
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo.
echo 正在建立登入伺服器的資料庫...
set cmdline="%mysqlPath%" -h %lshost% -u %lsuser% --password=%lspass% -e "CREATE DATABASE %lsdb%" 2^> NUL
%cmdline%
if %ERRORLEVEL% == 0 goto logininstall
if %safe_mode% == 1 goto omfg
:ls_err2
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo 登入伺服器的資料庫建立失敗！
echo.
echo 可能的原因：
echo 1.輸入的資料錯誤，例如：使用者名稱/使用者密碼/其他相關資料
echo 2.使用者「%lsuser%」的權限不足 
echo 3.資料庫已存在
echo.
echo 請檢查設定並且修正，或者直接重新設定
echo.
:ls_ask2
set omfgprompt=q
echo (c)繼續
echo.
echo (r)重新設定
echo.
echo (q)退出
echo.
set /p omfgprompt=請選擇（預設值-退出）:
if /i %omfgprompt%==c goto cb_backup
if /i %omfgprompt%==q goto horrible_end
if /i %omfgprompt%==r goto configure
goto ls_ask2

:lsdbok
call :colors 17
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo.
:asklogin
if %fresh_setup%==0 (
set loginprompt=s
set msg=預設值-省略
) else (
set loginprompt=x
set msg=沒有預設值
)
echo 登入伺服器的資料庫安裝：
echo.
echo (f)完整：將移除所有舊的資料，重新導入新的資料
echo.
echo (s)省略：跳過此選項
echo.
echo (r)重新設定
echo.
echo (q)退出
echo.
set /p loginprompt=請選擇（%msg%）:
if /i %loginprompt%==f goto logininstall
if /i %loginprompt%==s goto cb_backup
if /i %loginprompt%==r goto configure
if /i %loginprompt%==q goto end
goto asklogin

:logininstall
set stage=3
call :colors 17
set cmdline=
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo 正在移除登入伺服器的資料庫，然後導入新的資料庫...
set cmdline="%mysqlPath%" -h %lshost% -u %lsuser% --password=%lspass% -D %lsdb% ^< login_install.sql 2^> NUL
%cmdline%
if not %ERRORLEVEL% == 0 goto omfg
set full=1
goto cb_backup

:cb_backup
cls
call :colors 17
set cmdline=
REM [Update by rocknow] if %full% == 1 goto communityinstall
set stage=4
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo.
echo 正在備份「討論版專用」的資料庫...
set cmdline="%mysqldumpPath%" --add-drop-table -h %cbhost% -u %cbuser% --password=%cbpass% %cbdb% ^> "%backup%\cbserver_backup.sql" 2^> NUL
%cmdline%
if %ERRORLEVEL% == 0 goto cbdbok
REM if %safe_mode% == 1 goto omfg
:cb_err1
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo.
echo 備份失敗！
echo 原因是因為「討論版專用」的資料庫不存在
echo 現在可以幫你建立 %cbdb%，或者繼續其它設定
echo.
:cb_ask1
set cbdbprompt=y
echo 建立「討論版專用」的資料庫？
echo.
echo (y)確定
echo.
echo (n)取消
echo.
echo (r)重新設定
echo.
echo (q)退出
echo.
set /p cbdbprompt=請選擇（預設值-確定）:
if /i %cbdbprompt%==y goto cbdbcreate
if /i %cbdbprompt%==n goto gs_backup
if /i %cbdbprompt%==r goto configure
if /i %cbdbprompt%==q goto end
goto cb_ask1

:cbdbcreate
call :colors 17
set cmdline=
set stage=5
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo.
echo 正在建立「討論版專用」的資料庫...
set cmdline="%mysqlPath%" -h %cbhost% -u %cbuser% --password=%cbpass% -e "CREATE DATABASE %cbdb%" 2^> NUL
%cmdline%
if %ERRORLEVEL% == 0 goto communityinstall
if %safe_mode% == 1 goto omfg
:cb_err2
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo 「討論版專用」的資料庫建立失敗！
echo.
echo 可能的原因：
echo 1.輸入的資料錯誤，例如：使用者名稱/使用者密碼/其他相關資料
echo 2.使用者「%cbuser%」的權限不足 
echo 3.資料庫已存在
echo.
echo 請檢查設定並且修正，或者直接重新設定
echo.
:cb_ask2
set omfgprompt=q
echo (c)繼續
echo.
echo (r)重新設定
echo.
echo (q)退出
echo.
set /p omfgprompt=請選擇（預設值-退出）:
if /i %omfgprompt%==c goto gs_backup
if /i %omfgprompt%==q goto horrible_end
if /i %omfgprompt%==r goto configure
goto cb_ask2

:cbdbok
call :colors 17
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo.
:askcommunity
if %fresh_setup%==0 (
set communityprompt=u
set msg=預設值-更新
) else (
set communityprompt=x
set msg=沒有預設值
)
echo 「討論版專用」的資料庫安裝：
echo.
echo (f)完整：將移除所有舊的資料，重新導入新的資料
echo.
echo (u)更新：將保留所有舊的資料，並且進行更新作業
echo.
echo (s)省略：跳過此選項
echo.
echo (r)重新設定
echo.
echo (q)退出
echo.
set /p communityprompt=請選擇（%msg%）: 
if /i %communityprompt%==f goto communityinstall
if /i %communityprompt%==u goto upgradecbinstall
if /i %communityprompt%==s goto gs_backup
if /i %communityprompt%==r goto configure
if /i %communityprompt%==q goto end
goto askcommunity

:communityinstall
set stage=6
call :colors 17
set cmdline=
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo 正在移除「討論版專用」的資料庫，然後導入新的資料庫...
set cmdline="%mysqlPath%" -h %cbhost% -u %cbuser% --password=%cbpass% -D %cbdb% ^< community_install.sql 2^> NUL
%cmdline%
if not %ERRORLEVEL% == 0 goto omfg
set full=1
goto upgradecbinstall

:upgradecbinstall
set stage=6
set cmdline=
if %full% == 1 (
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo 安裝新的「討論版專用」資料庫...
) else (
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo 更新「討論版專用」資料庫...
)
if %logging% == 0 set output=NUL
set dest=cb
for %%i in (..\cb_sql\*.sql) do call :dump %%i

echo done...
echo.
goto gs_backup

:gs_backup
cls
call :colors 17
set cmdline=
if %full% == 1 goto fullinstall
set stage=7
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo.
echo 正在備份遊戲伺服器的資料庫...
set cmdline="%mysqldumpPath%" --add-drop-table -h %gshost% -u %gsuser% --password=%gspass% %gsdb% ^> "%backup%\gameserver_backup.sql" 2^> NUL
%cmdline%
if %ERRORLEVEL% == 0 goto gsdbok
rem if %safe_mode% == 1 goto omfg
:gs_err1
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo.
echo 備份失敗！
echo 原因是因為資料庫不存在
echo 現在可以幫你建立 %gsdb%，或者繼續其它設定
echo.
:askgsdb
set gsdbprompt=y
echo 建立遊戲伺服器的資料庫？
echo.
echo (y)確定
echo.
echo (n)取消
echo.
echo (r)重新設定
echo.
echo (q)退出
echo.
set /p gsdbprompt=請選擇（預設值-確定）:
if /i %gsdbprompt%==y goto gsdbcreate
if /i %gsdbprompt%==n goto horrible_end
if /i %gsdbprompt%==r goto configure
if /i %gsdbprompt%==q goto end
goto askgsdb

:gsdbcreate
call :colors 17
set stage=8
set cmdline=
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo 正在建立遊戲伺服器的資料庫...
set cmdline="%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -e "CREATE DATABASE %gsdb%" 2^> NUL
%cmdline%
if %ERRORLEVEL% == 0 goto fullinstall
if %safe_mode% == 1 goto omfg
:gs_err2
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo.
echo 遊戲伺服器的資料庫建立失敗！
echo.
echo 可能的原因：
echo 1.輸入的資料錯誤，例如：使用者名稱/使用者密碼/其他相關資料
echo 2.使用者「%gsuser%」的權限不足 
echo 3.資料庫已存在
echo.
echo 請檢查設定並且修正，或者直接重新設定
echo.
:askgsdbcreate
set omfgprompt=q
echo (r)重新執行並且進行設定
echo.
echo (q)退出
echo.
set /p omfgprompt=請選擇（預設值-退出）:
if /i %omfgprompt%==r goto configure
if /i %omfgprompt%==q goto horrible_end
goto askgsdbcreate

:gsdbok
call :colors 17
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo.
:asktype
set installtype=u
echo 遊戲伺服器的資料庫安裝：
echo.
echo (f)完整：將移除所有舊的資料，重新導入新的資料
echo.
echo (u)更新：將保留所有舊的資料，並且進行更新作業
echo.
echo (s)省略：跳過此選項
echo.
echo (q)退出
echo.
set /p installtype=請選擇（預設值-更新）:
if /i %installtype%==f goto fullinstall
if /i %installtype%==u goto upgradeinstall
if /i %installtype%==s goto custom
if /i %installtype%==q goto end
goto asktype

:fullinstall
call :colors 17
set stage=9
set cmdline=
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo 正在移除遊戲伺服器的資料庫，然後導入新的資料庫...
set cmdline="%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% ^< full_install.sql 2^> NUL
%cmdline%
if not %ERRORLEVEL% == 0 goto omfg
set full=1
echo.
echo 遊戲資料庫移除完成
goto upgradeinstall

:upgradeinstall
set stage=9
set cmdline=
if %full% == 1 (
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo 安裝新的遊戲資料庫...
) else (
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo 更新遊戲資料庫...
)
if %logging% == 0 set output=NUL
set dest=ls
for %%i in (..\sql\login\*.sql) do call :dump %%i
set dest=gs
for %%i in (..\sql\server\*.sql) do call :dump %%i

echo 完成...
echo.
goto custom

:dump
set cmdline=
if /i %full% == 1 (set action=安裝) else (set action=更新)
echo %action% %1>>"%output%"
echo %action% %~nx1
if "%dest%"=="ls" set cmdline="%mysqlPath%" -h %lshost% -u %lsuser% --password=%lspass% -D %lsdb% ^< %1 2^>^>"%output%"
if "%dest%"=="cb" set cmdline="%mysqlPath%" -h %cbhost% -u %cbuser% --password=%cbpass% -D %cbdb% ^< %1 2^>^>"%output%"
if "%dest%"=="gs" set cmdline="%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% ^< %1 2^>^>"%output%"
%cmdline%
if %logging%==0 if NOT %ERRORLEVEL%==0 call :omfg2 %1
goto :eof

:omfg2
cls
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
echo.
echo 出現錯誤：
echo %mysqlPath% -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb%
echo.
echo 檔案 %~nx1
echo.
echo 處理方式？
echo.
:askomfg2
set ntpebcak=c
echo (l)建立訊息檔案方便查詢
echo.
echo (c)繼續
echo.
echo (r)重新設定
echo.
echo (q)退出
echo.
set /p ntpebcak=請選擇（預設值-繼續）:
if  /i %ntpebcak%==c (call :colors 17 & goto :eof)
if  /i %ntpebcak%==l (call :logginon %1 & goto :eof)
if  /i %ntpebcak%==r (call :configure & exit)
if  /i %ntpebcak%==q (call :horrible_end & exit)
goto askomfg2

:logginon
cls
call :colors 17
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
set logging=1
if %full% == 1 (
  set output=%logdir%\install-%~nx1.log
) else (
  set output=%logdir%\upgrade-%~nx1.log
)
echo.
echo 建立訊息檔案...
echo.
echo 檔案為「%output%」
echo.
echo 如果此檔案已存在，請進行備份，否則將會覆蓋過去
echo.
echo 請按任意鍵開始進行 . . .
pause>NUL
set cmdline="%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% ^<..\sql\%1 2^>^>"%output%"
date /t >"%output%"
time /t >>"%output%"
%cmdline%
echo 建立訊息資料...
call :colors 17
set logging=0
set output=NUL
goto :eof

:custom
cd ..\sql\server\
set charprompt=y
set /p charprompt=安裝「技能/物品/職業/NPC說話」中文化: (y) 確定 或 (N) 取消？（預設值-確定）:
if /i %charprompt%==y "%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < skill_tw.sql 2>>NUL
if /i %charprompt%==y "%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < item_tw.sql 2>>NUL
if /i %charprompt%==y "%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < char_templates_tw.sql 2>>NUL
if /i %charprompt%==y "%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < auto_chat_text_tw.sql 2>>NUL
echo 安裝 skill_tw.sql
echo 安裝 item_tw.sql
echo 安裝 char_templates_tw.sql
echo 安裝 auto_chat_text_tw.sql
echo 完成...
echo.
echo ☆注意：部分系統安裝中文化會失敗，導致遊戲中出現亂碼
echo 　　　　如果遇到這種情形，請再手動導入 SQL 裡面的
echo 　　　　skill_tw.sql / item_tw.sql / messagetable /
echo 　　　　auto_chat_text_tw / char_templates_tw 這 5 個 SQL
echo.
set cstprompt=y
set /p cstprompt=安裝 custom 自訂資料表: (y) 確定 或 (N) 取消 或 (q) 退出？（預設值-確定）:
if /i %cstprompt%==y goto cstinstall
if /i %cstprompt%==n goto newbie_helper
if /i %cstprompt%==q goto end
goto newbie_helper
:cstinstall
echo 安裝 custom 自訂內容
cd ..\sql\server\custom\
echo @echo off> temp.bat
if exist errors.txt del errors.txt
for %%i in (*.sql) do echo "%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% ^< %%i 2^>^> custom_errors.txt >> temp.bat
call temp.bat> nul
del temp.bat
move custom_errors.txt %workdir%
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo custom 自訂資料表加入資料庫完成
echo 所有錯誤資訊將放入「custom_errors.txt」
echo.
echo 請注意，如果要使這些自訂資料表能夠啟用
echo 你必須修改 config 的檔案設定
echo.
pause
cd %workdir%
title L2JDP installer - Game Server database setup - L2J Mods
cls
echo L2J provides a basic infraestructure for some non-retail features
echo (aka L2J mods) to get enabled with a minimum of changes.
echo.
echo Some of these mods would require extra tables in order to work
echo and those tables could be created now if you wanted to.
echo.
cd ..\sql\server\mods\
REM L2J mods that needed extra tables to work properly, should be 
REM listed here. To do so copy & paste the following 4 lines and
REM change them properly:
REM MOD: Wedding.
set modprompt=n
set /p modprompt="安裝「結婚模組」資料表: (y) 確定 或 (N) 取消？"
if /i %modprompt%==y "%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < mods_wedding.sql 2>>NUL

title L2JDP installer - Game Server database setup - L2J Mods setup complete
cls
echo Database structure for L2J mods finished.
echo.
echo Remember that in order to get these additions actually working 
echo you need to edit your configuration files. 
echo.
pause
cd %workdir%
goto newbie_helper


:newbie_helper
call :colors 17
set stage=10
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
if %full% == 1 goto end
echo.
echo sql/server/updates 的資料夾是用來更新資料庫格式
echo.
echo 請直接按下 Enter 進行更新
:asknb
set nbprompt=a
echo.
echo 現在要如何進行？
echo.
echo (a)自動：進入 sql/updates 的資料夾內，導入更新資料庫格式的 sql
echo.
echo (s)省略：全部都由手動安裝
echo.
set /p nbprompt=請選擇（預設值-自動）:
if /i %nbprompt%==a goto nblsinstall
if /i %nbprompt%==l goto nblsinstall
if /i %nbprompt%==c goto nbcbinstall
if /i %nbprompt%==g goto nbgsinstall
if /i %nbprompt%==s goto end
goto asknb
:nblsinstall
cd ..\sql\login\updates\
echo @echo off> temp.bat
if exist lserrors.txt del lserrors.txt
for %%i in (*.sql) do echo "%mysqlPath%" -h %lshost% -u %lsuser% --password=%lspass% -D %lsdb% ^< %%i 2^>^> lserrors.txt >> temp.bat
call temp.bat> nul
del temp.bat
move lserrors.txt %workdir%
cd %workdir%
if /i %nbprompt%==l goto nbfinished
:nbcbinstall
cd ..\cb_sql\updates\
echo @echo off> temp.bat
if exist cberrors.txt del cberrors.txt
for %%i in (*.sql) do echo "%mysqlPath%" -h %cbhost% -u %cbuser% --password=%cbpass% -D %cbdb% ^< %%i 2^>^> cberrors.txt >> temp.bat
call temp.bat> nul
del temp.bat
move cberrors.txt %workdir%
cd %workdir%
if /i %nbprompt%==c goto nbfinished
:nbgsinstall
cd ..\sql\server\updates\
echo @echo off> temp.bat
if exist gserrors.txt del gserrors.txt
for %%i in (*.sql) do echo "%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% ^< %%i 2^>^> gserrors.txt >> temp.bat
call temp.bat> nul
del temp.bat
move gserrors.txt %workdir%
cd %workdir%
:nbfinished
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo 自動更新完畢，所有錯誤資訊將放入「errors.txt」
echo.
echo 有時會出現一些錯誤，例如表格重複，像這種訊息就不用理會
echo.
echo 「Duplicate column name」
echo.
echo 此訊息為重複的表格
echo.
echo 請多注意類似以下的訊息
echo.
echo 「Table doesn't exist」
echo.
echo 等等例子...
echo.
pause
goto end

:binaryfind
if EXIST "%mysqlBinPath%" (echo 找到的 MySQL) else (echo 沒有找到 MySQL，請在下面輸入正確的位置...)
goto :eof

:horrible_end
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo 發生錯誤，請查詢相關問題，尋找幫助
echo.
echo 1- 利用相關網站查詢
echo	(http://l2jdp.com/trac/wiki)
echo 2- L2JTW 官方網站查詢
echo	(http://www.l2jtw.com/)
echo.
echo.
echo 有任何錯誤訊息可以在討論板上發文，請勿直接找開發人員詢問
echo.
echo Datapack 版本「SVN version」:
svnversion -n 2>NUL
echo.
if %ERRORLEVEL% == 9009 (
echo   SVN 資料錯誤
echo   請下載並且安裝此程式：
echo   http://subversion.tigris.org/servlets/ProjectDocumentList?folderID=91
echo.
)
set dpvf="..\config\l2jdp-version.properties"
echo Datapack 版本：
if NOT EXIST %dpvf% (
echo   %dpvf% 檔案無法找到！
echo   請利用 Eclipse 或者 TortiseSVN 下載 Datapack，並且進行更新
) else (
type %dpvf% | find "version" 2> NUL
if not %ERRORLEVEL% == 0 (
echo   資訊出錯：
echo   %dpvf% 檔案有誤！
echo   請確定檔案保留，並且時常進行更新
echo %ERRORLEVEL%
))
echo.
rem del %config_file%
pause
goto end

:end
call :colors 17
title L2JTW Datapack 安裝 - For：L2JTW GameServer Freya Alpha
cls
echo.
echo L2JTW Datapack 安裝程序 - For：L2JTW GameServer Freya Alpha
echo (C) 2007-2010 L2JTW Datapack 開發團隊
echo.
echo 感謝使用 L2JTW 伺服器
echo 相關資訊可以在 http://www.l2jtw.com 查詢到
echo.
pause
color
