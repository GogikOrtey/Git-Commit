@echo off
chcp 65001 >nul

:menu
cls
color 07
echo Вас приветствует спкрипт устранения проблем с git^!
echo.
echo 1. Откатить изменения на момент последнего коммита
echo 2. Откатить изменения на момент предпоследнего коммита
echo 3. Загрузить последнюю версию этого репозитория из GitHub
echo 4. Показать логи этого репозитория (текущей ветки)
echo.
set /p choice=Введите номер операции, которую вы хотите выполнить: 
if "%choice%"=="1" goto undo_last_commit
if "%choice%"=="2" goto undo_second_last_commit
if "%choice%"=="3" goto pull_latest
if "%choice%"=="4" goto show_logs
goto menu

:undo_last_commit
echo Вы собираетесь откатить изменения на момент последнего коммита. Это удалит все изменения после последнего коммита.
set /p confirm=Если вы хотите продолжить, введите 1: 
if "%confirm%"=="1" (
    echo.
    echo git reset --hard HEAD~0
    git reset --hard HEAD~0 || (
        goto error
    )
    color 20
    pause
)
goto menu

:undo_second_last_commit
echo Вы собираетесь откатить изменения на момент предпоследнего коммита. Это удалит все изменения после предпоследнего коммита.
set /p confirm=Если вы хотите продолжить, введите 1: 
if "%confirm%"=="1" (
    echo.
    echo git reset --hard HEAD~1
    git reset --hard HEAD~1 || (
        goto error
    )
    color 20
    pause
)
goto menu

:pull_latest
echo Вы собираетесь загрузить последнюю версию этого репозитория из GitHub. Это может перезаписать некоторые из ваших локальных изменений.
set /p confirm=Если вы хотите продолжить, введите 1: 
if "%confirm%"=="1" (
    echo.
    echo git pull
    git pull || (
        goto error_pulling
    )
    color 20
    pause
)
goto menu

:show_logs
git log
pause
goto menu

:error
color 47
echo.
echo При выполнении данной операции произошла ошибка^!
pause







:error_pulling

color 60
echo. 
echo Кажется, возникла ошибка, связанная с тем, что данные на локальном, и удалённом репозитории отличаются
echo Вы можете выбрать, какую команду хотите выполнить:
echo. 1. Полностью перезаписать этот локальный репозиторий последней версией из GitHub
echo. 2. Сохранить свои изменения и объединить их с изменениями на GitHub
echo.
set /p choice2=Введите номер операции, которую вы хотите выполнить: 
echo.

if "%choice2%"=="2" (            
    echo Для этого, используйте команды git merge или git rebase
    echo Прочтите подробную справку самостоятельно.
    echo.
    pause
)

if "%choice2%"=="1" (
    color 07
    echo git fetch origin
    git fetch origin
    echo git reset --hard origin/main
    git reset --hard origin/main
    echo git pull
    git pull
    echo.
    echo Операция успешно выполнена
    color 20
    pause
)