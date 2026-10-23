@echo off
chcp 65001 >nul
echo ╔════════════════════════════════════════════════════════╗
echo ║        AI键盘 - 自动构建脚本 v1.0                      ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo 本脚本将自动完成以下操作:
echo [1] 检查并安装Java环境
echo [2] 下载Android命令行工具
echo [3] 安装必要的SDK组件
echo [4] 构建APK安装包
echo.
echo 预计耗时: 15-20分钟
echo 需要网络: 约下载500MB数据
echo.
pause

:: 创建工作目录
set "WORK_DIR=%~dp0build_tools"
set "JAVA_DIR=%WORK_DIR%\jdk"
set "SDK_DIR=%WORK_DIR%\android-sdk"
set "CMDLINE_DIR=%WORK_DIR%\cmdline-tools"

echo.
echo ════════════════════════════════════════════════════════
echo 步骤1: 检查Java环境
echo ════════════════════════════════════════════════════════

:: 检查Java
java -version >nul 2>&1
if %errorlevel% == 0 (
    echo ✓ 已检测到Java环境
    for /f "tokens=3" %%i in ('java -version 2^>^&1 ^| findstr /i "version"') do set JAVA_VERSION=%%i
    echo   版本: %JAVA_VERSION%
) else (
    echo ✗ 未检测到Java环境
    echo.
    echo 正在准备下载Java 17...
    echo.
    echo ════════════════════════════════════════════════════════
    echo 需要手动下载Java
    echo ════════════════════════════════════════════════════════
    echo.
    echo 请按照以下步骤操作:
    echo.
    echo 1. 打开浏览器访问:
    echo    https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.exe
    echo.
    echo 2. 下载完成后双击安装
    echo.
    echo 3. 安装完成后重新运行本脚本
    echo.
    pause
    exit /b 1
)

echo.
echo ════════════════════════════════════════════════════════
echo 步骤2: 下载Android命令行工具
echo ════════════════════════════════════════════════════════

if not exist "%WORK_DIR%" mkdir "%WORK_DIR%"
if not exist "%SDK_DIR%" mkdir "%SDK_DIR%"

set "CMDLINE_ZIP=%WORK_DIR%\commandlinetools-win-11076708_latest.zip"
set "CMDLINE_URL=https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"

if exist "%CMDLINE_ZIP%" (
    echo ✓ 命令行工具已下载
) else (
    echo 正在下载Android命令行工具 (约150MB)...
    echo URL: %CMDLINE_URL%
    echo.

    :: 使用PowerShell下载
    powershell -Command "& {Write-Host '开始下载...'; $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri '%CMDLINE_URL%' -OutFile '%CMDLINE_ZIP%'; Write-Host '下载完成!'}"

    if %errorlevel% neq 0 (
        echo ✗ 下载失败
        echo.
        echo 请手动下载:
        echo 1. 访问: https://developer.android.com/studio#command-line-tools-only
        echo 2. 下载 "commandlinetools-win" 版本
        echo 3. 保存到: %CMDLINE_ZIP%
        echo 4. 重新运行本脚本
        pause
        exit /b 1
    )
)

echo.
echo ════════════════════════════════════════════════════════
echo 步骤3: 解压工具
echo ════════════════════════════════════════════════════════

if exist "%CMDLINE_DIR%\cmdline-tools" (
    echo ✓ 已解压
) else (
    echo 正在解压...
    powershell -Command "Expand-Archive -Path '%CMDLINE_ZIP%' -DestinationPath '%CMDLINE_DIR%' -Force"
    if %errorlevel% neq 0 (
        echo ✗ 解压失败
        pause
        exit /b 1
    )
    echo ✓ 解压完成
)

:: 设置环境变量
set "ANDROID_SDK_ROOT=%SDK_DIR%"
set "ANDROID_HOME=%SDK_DIR%"
set "PATH=%CMDLINE_DIR%\cmdline-tools\bin;%SDK_DIR%\platform-tools;%PATH%"

echo.
echo ════════════════════════════════════════════════════════
echo 步骤4: 安装SDK组件
echo ════════════════════════════════════════════════════════

echo 正在安装必要的SDK组件...
echo (这可能需要5-10分钟，请耐心等待)
echo.

:: 接受许可证
echo y | "%CMDLINE_DIR%\cmdline-tools\bin\sdkmanager.bat" --sdk_root="%SDK_DIR%" --licenses >nul 2>&1

:: 安装必要组件
echo 安装 platform-tools...
call "%CMDLINE_DIR%\cmdline-tools\bin\sdkmanager.bat" --sdk_root="%SDK_DIR%" "platform-tools"

echo 安装 build-tools 34.0.0...
call "%CMDLINE_DIR%\cmdline-tools\bin\sdkmanager.bat" --sdk_root="%SDK_DIR%" "build-tools;34.0.0"

echo 安装 platforms android-34...
call "%CMDLINE_DIR%\cmdline-tools\bin\sdkmanager.bat" --sdk_root="%SDK_DIR%" "platforms;android-34"

echo 安装 platforms android-26...
call "%CMDLINE_DIR%\cmdline-tools\bin\sdkmanager.bat" --sdk_root="%SDK_DIR%" "platforms;android-26"

echo.
echo ✓ SDK组件安装完成

echo.
echo ════════════════════════════════════════════════════════
echo 步骤5: 配置项目
echo ════════════════════════════════════════════════════════

:: 创建local.properties
echo sdk.dir=%SDK_DIR:\=\\%> "%~dp0local.properties"
echo ✓ 已配置SDK路径

echo.
echo ════════════════════════════════════════════════════════
echo 步骤6: 构建APK
echo ════════════════════════════════════════════════════════

cd /d "%~dp0"

:: 检查gradlew
if not exist "gradlew.bat" (
    echo ✗ gradlew.bat 不存在
    echo 请确保项目完整
    pause
    exit /b 1
)

echo 正在构建Debug APK...
echo (首次构建需要下载依赖，约5-10分钟)
echo.

call gradlew.bat assembleDebug

if %errorlevel% == 0 (
    echo.
    echo ╔════════════════════════════════════════════════════════╗
    echo ║                  ✓ 构建成功！                          ║
    echo ╚════════════════════════════════════════════════════════╝
    echo.
    echo APK位置:
    echo %~dp0app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo 文件大小:
    for %%A in ("%~dp0app\build\outputs\apk\debug\app-debug.apk") do echo %%~zA 字节
    echo.
    echo ════════════════════════════════════════════════════════
    echo 下一步: 将APK传到手机安装
    echo ════════════════════════════════════════════════════════
    echo.

    :: 打开APK所在文件夹
    explorer "%~dp0app\build\outputs\apk\debug"

) else (
    echo.
    echo ╔════════════════════════════════════════════════════════╗
    echo ║                  ✗ 构建失败                            ║
    echo ╚════════════════════════════════════════════════════════╝
    echo.
    echo 请查看上面的错误信息
    echo 或查阅 BUILD_GUIDE.md 的故障排除章节
)

echo.
pause
