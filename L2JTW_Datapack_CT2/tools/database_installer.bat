@echo off
REM ##############################################
REM ## L2JDP Database Installer - (by DrLecter) ##
REM ##############################################
REM ## Interactive script setup -  (by TanelTM) ##
REM ##############################################
REM Copyright (C) 2008 L2J DataPack
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
REM #l2j-datapack @ irc://irc.freenode.net

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
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
if not exist %config_file% goto configure
ren %config_file% vars.bat
call vars.bat
ren vars.bat %config_file%
call :colors 17
if /i %config_version% == 1 goto ls_section
set upgrade_mode=2
echo It seems to be the first time you run this version of
echo database_installer but I found a settings file already.
echo I'll hopefully ask this questions just once.
echo.
echo 更新設定選項：
echo.
echo (1) 導入＆繼續使用舊的設定：將使用所有原本的資料並且進行更新作業
echo.
echo (2) 導入＆並使用新的設定值：導入新的資料並且將會重新設定資料
echo.
echo (3) 導入全新的資料：所有的資料將會被移除並且導入新的資料
echo.
echo (4) 查看存取的設定值

echo (5) 退出
echo.
set /P upgrade_mode="輸入數字，之後請按 Enter（預設值為「%upgrade_mode%」）: "
if %upgrade_mode%==1 goto ls_section
if %upgrade_mode%==2 goto configure
if %upgrade_mode%==3 goto configure
if %upgrade_mode%==4 (cls&type %config_file%&pause&goto loadconfig)
if %upgrade_mode%==5 goto :eof
goto loadconfig

:colors
if /i "%cmode%"=="n" (
if not "%1"=="17" (     color F ) else ( color )
) else ( color %1 )
goto :eof

:configure
call :colors 17
title L2JDP installer - Setup
cls
set config_version=1
if NOT %upgrade_mode% == 2 (
set fresh_setup=1
set mysqlBinPath=%ProgramFiles%\MySQL\MySQL Server 5.0\bin

:_MySQL51
if not exist "%ProgramFiles%\MySQL\MySQL Server 5.1\bin\mysql.exe" goto _MySQL60
set mysqlBinPath=%ProgramFiles%\MySQL\MySQL Server 5.1\bin

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
echo 1-MySql 程式
echo --------------------
echo 請設定 mysql.exe 和 mysqldump.exe 的位置
echo.
if "%mysqlBinPath%" == "" (
set mysqlBinPath=use path
echo 無法自動偵測位置
) else (
echo 請嘗試此設定值是否可行
echo.
echo %mysqlPath%
)
if not "%mysqlBinPath%" == "use path" call :binaryfind
echo.
path|find "MySQL">NUL
if %errorlevel% == 0 (
echo 上面是找到的 MySQL 位置，此位置將會被設為預設值，如果想換位置請修改...
set mysqlBinPath=use path
) else (
echo 無法找到 mysql 正確位置，請輸入 mysql.exe 的正確位置...
echo.
echo 如果還是不確定這到底是什麼意思和如何操作，請到相關網站查詢或者可以至 L2JTW 官方網站發問或尋找相關資訊
)
echo.
echo 請輸入 mysql.exe 的正確位置：
set /P mysqlBinPath="(default %mysqlBinPath%): "
cls
echo.
echo 2-登入伺服器設定
echo --------------------
echo 此作業將會連線至你所指定的 MySQL 伺服器，並且進行導入作業
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
echo.
echo 3-遊戲伺服器設定
echo --------------------
set /P gsuser="使用者名稱（預設值「%gsuser%」）: "
set /P gspass="使用者密碼（預設值「%gspass%」）: "
set /P gsdb="資料庫（預設值「%gsdb%」）: "
set /P gshost="位置（預設值「%gshost%」）: "
echo.
echo 4-其他設定
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
echo set gsuser=%gsuser%>> %config_file%
echo set gspass=%gspass%>> %config_file%
echo set gsdb=%gsdb%>> %config_file%
echo set gshost=%gshost%>> %config_file%
echo set logdir=%logdir%>> %config_file%
echo set backup=%backup%>> %config_file%
echo.
echo 設定成功！
echo 你的設定值將會儲存在「%config_file%」，所有的帳號密碼將以明碼顯示
echo.
echo 請按任意鍵繼續 . . .
pause> nul
goto loadconfig

:ls_section
cls
call :colors 17
set cmdline=
set stage=1
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
echo.
echo 嘗試進行備份登入伺服器的資料庫...
set cmdline="%mysqldumpPath%" --add-drop-table -h %lshost% -u %lsuser% --password=%lspass% %lsdb% ^> "%backup%\loginserver_backup.sql" 2^> NUL
%cmdline%
if %ERRORLEVEL% == 0 goto lsdbok
REM if %safe_mode% == 1 goto omfg
:ls_err1
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
echo.
echo 備份失敗！
echo 原因是因為資料庫不存在
echo 可以嘗試幫你建立 %lsdb%，或者你想繼續
echo.
:ls_ask1
set lsdbprompt=y
echo 嘗試建立登入伺服器的資料庫：
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
if /i %lsdbprompt%==n goto gs_backup
if /i %lsdbprompt%==r goto configure
if /i %lsdbprompt%==q goto end
goto ls_ask1

:omfg
cls
call :colors 57
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
echo.
echo 執行時出現錯誤：
echo.
echo "%cmdline%"
echo.
echo 建議檢查一下資料以確保所有數值都正常
echo.
if %stage% == 1 set label=ls_err1
if %stage% == 2 set label=ls_err2
if %stage% == 3 set label=gs_backup
if %stage% == 4 set label=gs_err1
if %stage% == 5 set label=gs_err2
if %stage% == 6 set label=horrible_end
if %stage% == 7 set label=horrible_end
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
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
echo.
echo Trying to create a Login Server database...
set cmdline="%mysqlPath%" -h %lshost% -u %lsuser% --password=%lspass% -e "CREATE DATABASE %lsdb%" 2^> NUL
%cmdline%
if %ERRORLEVEL% == 0 goto logininstall
if %safe_mode% == 1 goto omfg
:ls_err2
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
echo 資料庫建立失敗
echo.
echo 可能的原因：
echo 1-所提供的資料錯誤，使用者名稱/使用者密碼/其他相關資料
echo 2-使用者 %lsuser% 沒有足夠的權限操作資料庫 
echo 3-資料庫可能已經存在
echo.
echo 請重新檢查設定並且修正出錯的地方
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
if /i %omfgprompt%==c goto gs_backup
if /i %omfgprompt%==q goto horrible_end
if /i %omfgprompt%==r goto configure
goto ls_ask2

:lsdbok
call :colors 17
title L2JDP installer - Login Server database setup - WARNING!!!
echo.
:asklogin
if %fresh_setup%==0 (
set loginprompt=s
set msg=預設值-省略
) else (
set loginprompt=x
set msg=沒有預設值
)
echo 登入伺服器的資料庫安裝類型：
echo.
echo (f)完整：將移除所有資料，重新導入新的資料進去
echo.
echo (s)省略：跳過此選項
echo.
echo (r)重新設定
echo.
echo (q)退出
echo.
set /p loginprompt=請選擇（%msg%）:
if /i %loginprompt%==f goto logininstall
if /i %loginprompt%==s goto gs_backup
if /i %loginprompt%==r goto configure
if /i %loginprompt%==q goto end
goto asklogin

:logininstall
set stage=3
call :colors 17
set cmdline=
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
echo 正在移除登入伺服器的資料，然後導入新的資料...
set cmdline="%mysqlPath%" -h %lshost% -u %lsuser% --password=%lspass% -D %lsdb% ^< login_install.sql 2^> NUL
%cmdline%
if not %ERRORLEVEL% == 0 goto omfg
set full=1
goto gs_backup

:gs_backup
call :colors 17
set cmdline=
if %full% == 1 goto fullinstall
set stage=4
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
echo.
echo 正在備份原本的資料庫
set cmdline="%mysqldumpPath%" --add-drop-table -h %gshost% -u %gsuser% --password=%gspass% %gsdb% ^> "%backup%\gameserver_backup.sql" 2^> NUL
%cmdline%
if %ERRORLEVEL% == 0 goto gsdbok
if %safe_mode% == 1 goto omfg
:gs_err1
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
echo.
echo 備份失敗！
echo 資料庫並不存在
echo 是否需要建立 %gsdb% 的資料庫
echo.
:askgsdb
set gsdbprompt=y
echo 是否要建立遊戲伺服器的資料庫？
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
set stage=5
set cmdline=
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
echo 嘗試建立遊戲伺服器的資料庫...
set cmdline="%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -e "CREATE DATABASE %gsdb%" 2^> NUL
%cmdline%
if %ERRORLEVEL% == 0 goto fullinstall
if %safe_mode% == 1 goto omfg
:gs_err2
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
echo.
echo 遊戲伺服器的資料庫建立出錯
echo.
echo 可能的原因：
echo 1-提供的資料不明確
echo 2-使用者 %gsuser% 的權限不足 
echo 3-資料庫已存在
echo.
echo 請查明原因後再繼續執行，或者直接進行重新設置
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
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
echo.
:asktype
set installtype=u
echo 遊戲伺服器的資料庫安裝：
echo.
echo (f)完整：將刪除所有原本的資料
echo.
echo (u)更新：將保留所有的資料，並且進行更新作業
echo.
echo (s)省略
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
set stage=6
set cmdline=
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
echo 移除所有遊戲資料庫的資料...
set cmdline="%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% ^< full_install.sql 2^> NUL
%cmdline%
if not %ERRORLEVEL% == 0 goto omfg
set full=1
echo.
echo 遊戲資料庫移除完成
goto upgradeinstall

:upgradeinstall
set stage=6
set cmdline=
if %full% == 1 (
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
echo 安裝新的遊戲資料庫...
) else (
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
echo 更新遊戲資料庫...
)
if %logging% == 0 set output=NUL
set dest=ls
for %%i in (
accounts.sql
account_data.sql
gameservers.sql
) do call :dump %%i
set dest=gs
for %%i in (
access_levels.sql
admin_command_access_rights.sql
armor.sql
armorsets.sql
auction.sql
auction_bid.sql
auction_watch.sql
auto_chat.sql
auto_chat_text.sql
boxaccess.sql
boxes.sql
castle.sql
castle_door.sql
castle_doorupgrade.sql
castle_functions.sql
castle_manor_procure.sql
castle_manor_production.sql
castle_siege_guards.sql
char_creation_items.sql
char_templates.sql
character_friends.sql
character_hennas.sql
character_macroses.sql
character_quests.sql
character_raid_points.sql
character_recipebook.sql
character_recommends.sql
character_shortcuts.sql
character_skills.sql
character_skills_save.sql
character_subclasses.sql
characters.sql
clan_data.sql
clan_privs.sql
clan_skills.sql
clan_subpledges.sql
clan_wars.sql
clanhall.sql
clanhall_functions.sql
class_list.sql
cursed_weapons.sql
dimensional_rift.sql
droplist.sql
enchant_skill_trees.sql
etcitem.sql
fish.sql
fishing_skill_trees.sql
fort_door.sql
fort_doorupgrade.sql
fort_siege_guards.sql
fort.sql
fortsiege_clans.sql
forums.sql
four_sepulchers_spawnlist.sql
games.sql
global_tasks.sql
grandboss_data.sql
grandboss_list.sql
helper_buff_list.sql
henna.sql
henna_trees.sql
heroes.sql
item_attributes.sql
items.sql
itemsonground.sql
locations.sql
lvlupgain.sql
mapregion.sql
merchant_areas_list.sql
merchant_buylists.sql
merchant_lease.sql
merchant_shopids.sql
merchants.sql
minions.sql
npc.sql
npc_buffer.sql
npcskills.sql
olympiad_nobles.sql
pets.sql
pets_stats.sql
pledge_skill_trees.sql
posts.sql
quest_global_data.sql
raidboss_spawnlist.sql
random_spawn.sql
random_spawn_loc.sql
seven_signs.sql
seven_signs_festival.sql
seven_signs_status.sql
siege_clans.sql
skill_learn.sql
skill_spellbooks.sql
skill_trees.sql
spawnlist.sql
teleport.sql
topic.sql
transform_skill_trees.sql
walker_routes.sql
weapon.sql
zone_vertices.sql
mods_wedding.sql
chatdata.sql
messagetable.sql
npcAIData.sql
npcCharData.sql
lastimperialtomb_spawnlist.sql
l2jtw_addon_0.sql
l2jtw_addon_1.sql
l2jtw_addon_2.sql
) do call :dump %%i
echo 完成...
echo.
goto custom

:dump
set cmdline=
if /i %full% == 1 (set action=Installing) else (set action=Upgrading)
echo %action% %1>>"%output%"
echo %action% %~nx1
if "%dest%"=="ls" set cmdline="%mysqlPath%" -h %lshost% -u %lsuser% --password=%lspass% -D %lsdb% ^< ..\sql\%1 2^>^>"%output%"
if "%dest%"=="gs" set cmdline="%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% ^< ..\sql\%1 2^>^>"%output%"
%cmdline%
if %logging%==0 if NOT %ERRORLEVEL%==0 call :omfg2 %1
goto :eof

:omfg2
cls
call :colors 47
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
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
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
set logging=1
if %full% == 1 (
  set output=%logdir%\install-%~nx1.log
) else (
  set output=%logdir%\upgrade-%~nx1.log
)
echo.
echo 建立訊息檔案...
echo.
echo 檔案為 %output%
echo.
echo 如果你已經有此檔案，請進行備份，不然系統將覆蓋過去
echo.
echo 請按任意鍵開始進行
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
cd ..\sql\
set charprompt=y
set /p charprompt=安裝「職業名稱中文化」: (y) 確定 或 (N) 取消？（預設值-確定）:
if /i %charprompt%==y "%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < char_templates_tw.sql 2>>NUL
echo.
set cstprompt=n
set /p cstprompt=安裝 custom 自訂資料表: (y) 確定 或 (N) 取消 或 (q) 退出？（預設值-取消）:
if /i %cstprompt%==y goto cstinstall
if /i %cstprompt%==n goto newbie_helper
if /i %cstprompt%==q goto end
goto newbie_helper
:cstinstall
echo 安裝 custom 自訂內容
cd ..\sql\custom\
echo @echo off> temp.bat
if exist errors.txt del errors.txt
for %%i in (*.sql) do echo "%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% ^< %%i 2^>^> custom_errors.txt >> temp.bat
call temp.bat> nul
del temp.bat
move custom_errors.txt %workdir%
title L2JTW Datapack 安裝 - 遊戲伺服器資料庫設定 - custom 自訂資料表程序完成
cls
echo custom 自訂資料表加入資料庫完成
echo 所有錯誤資訊將放入「custom_errors.txt」
echo.
echo 請注意，如果要使這些自訂資料表能夠啟用
echo 你必須修改 config 設定文件才會生效
echo.
pause
cd %workdir%
goto newbie_helper
title L2JDP installer - Game Server database setup - L2J Mods
cls
echo L2J provides a basic infraestructure for some non-retail features
echo (aka L2J mods) to get enabled with a minimum of changes.
echo.
echo Some of these mods would require extra tables in order to work
echo and those tables could be created now if you wanted to.
echo.
cd ..\sql\mods\
REM echo L2J mods that needed extra tables to work properly, should be
REM echo listed here. To do so copy & paste the following 4 lines and
REM echo change them properly:
REM echo 外掛：結婚
set modprompt=n
set /p modprompt="安裝「結婚外掛」資料表: (y) 確定 或 (N) 取消？"
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
set stage=7
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
if %full% == 1 goto end
echo.
echo sql/updates 的資料夾是用來更新資料庫格式
echo.
echo 如果不想了解更新了什麼，可以直接進行更新
:asknb
set nbprompt=a
echo.
echo 現在要如何進行？
echo.
echo (a)自動：將進入資料夾內導出所有 sql 檔案，並且導入到資料庫
echo.
echo (s)省略：全部都由手動安裝
echo.
set /p nbprompt=請選擇（預設值-自動）:
if /i %nbprompt%==a goto nbinstall
if /i %nbprompt%==s goto end
goto asknb
:nbinstall
cd ..\sql\updates\
echo @echo off> temp.bat
if exist errors.txt del errors.txt
for %%i in (*.sql) do echo "%mysqlPath%" -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% ^< %%i 2^>^> errors.txt >> temp.bat
call temp.bat> nul
del temp.bat
move errors.txt %workdir%
cd %workdir%
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
echo 自動處理進行完畢，所有錯誤資訊將放入「errors.txt」
echo.
echo 有時出現一些錯誤，像是表格重複，這種事情不用理會
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
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
echo 發生錯誤，請查詢相關問題，尋找幫助
echo.
echo 1- 利用相關網站查詢
echo    (http://l2jdp.com/trac/wiki)
echo 2- L2JTW 官方網站查詢
echo    (http://www.l2jtw.com/)
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
set dpvf="..\gameserver\config\l2jdp-version.properties"
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
title L2JTW Datapack 安裝 - For：L2JTW 4.5 Server
cls
echo.
echo L2JTW Datapack 安裝程序 - For：L2JTW 4.5 Server
echo (C) 2007 L2JTW Datapack 開發人員
echo.
echo 感謝使用 L2JTW 伺服器
echo 相關資訊可以在 http://www.l2jtw.com 查詢到
echo.
pause
color
