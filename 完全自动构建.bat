@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: ═══════════════════════════════════════════════════════════════
:: AI键盘 - 完全自动化构建系统 v1.0
:: ═══════════════════════════════════════════════════════════════

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║        AI键盘 - 一键自动构建APK                            ║
echo ║                                                            ║
echo ║   本脚本将自动完成所有操作：                               ║
echo ║   • 下载Java开发环境（约200MB）                            ║
echo ║   • 下载Android SDK工具（约150MB）                         ║
echo ║   • 安装必要的SDK组件（约300MB）                           ║
echo ║   • 构建APK安装包                                          ║
echo ║                                                            ║
echo ║   预计总耗时：15-25分钟                                    ║
echo ║   需要下载：约650MB数据                                    ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo 请确保：
echo   ✓ 电脑已连接互联网
echo   ✓ 有足够的磁盘空间（至少2GB）
echo   ✓ 关闭了杀毒软件（避免拦截下载）
echo.
echo 按任意键开始，或关闭窗口取消...
pause >nul

:: ═══════════════════════════════════════════════════════════════
:: 1. 环境准备
:: ═══════════════════════════════════════════════════════════════

echo.
echo ════════════════════════════════════════════════════════════
echo  第1步：准备工作环境
echo ════════════════════════════════════════════════════════════
echo.

set "PROJECT_DIR=%~dp0"
set "BUILD_TOOLS=%PROJECT_DIR%build_tools"
set "JAVA_DIR=%BUILD_TOOLS%\jdk-17"
set "CMDLINE_DIR=%BUILD_TOOLS%\cmdline-tools"
set "SDK_DIR=%BUILD_TOOLS%\android-sdk"

echo 创建工作目录...
if not exist "%BUILD_TOOLS%" mkdir "%BUILD_TOOLS%"

cd /d "%PROJECT_DIR%"

:: ═══════════════════════════════════════════════════════════════
:: 2. 下载Java
:: ═══════════════════════════════════════════════════════════════

echo.
echo ════════════════════════════════════════════════════════════
echo  第2步：下载Java 17（约200MB）
echo ════════════════════════════════════════════════════════════
echo.

set "JAVA_ZIP=%BUILD_TOOLS%\openjdk-17.zip"
set "JAVA_URL=https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_windows-x64_bin.zip"

if exist "%JAVA_DIR%\bin\java.exe" (
    echo ✓ Java已安装，跳过下载
) else (
    echo 正在下载Java 17...
    echo 来源：OpenJDK官方镜像
    echo.

    powershell -Command "& { ^
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; ^
        $ProgressPreference = 'SilentlyContinue'; ^
        Write-Host '下载中...'; ^
        try { ^
            Invoke-WebRequest -Uri '%JAVA_URL%' -OutFile '%JAVA_ZIP%' -TimeoutSec 600; ^
            Write-Host '✓ 下载完成'; ^
        } catch { ^
            Write-Host '✗ 下载失败：' $_.Exception.Message; ^
            exit 1; ^
        } ^
    }"

    if !errorlevel! neq 0 (
        echo.
        echo ✗ Java下载失败
        echo.
        echo 请手动下载：
        echo 1. 访问：https://adoptium.net/
        echo 2. 选择 "JDK 17" → "Windows x64" → "ZIP"
        echo 3. 下载后解压到：%JAVA_DIR%
        echo 4. 重新运行本脚本
        pause
        exit /b 1
    )

    echo.
    echo 正在解压Java...
    powershell -Command "Expand-Archive -Path '%JAVA_ZIP%' -DestinationPath '%BUILD_TOOLS%\temp_java' -Force"

    :: 找到解压后的Java目录
    for /d %%i in ("%BUILD_TOOLS%\temp_java\jdk-*") do (
        move "%%i" "%JAVA_DIR%" >nul
    )
    rmdir /s /q "%BUILD_TOOLS%\temp_java" 2>nul
    del "%JAVA_ZIP%" 2>nul

    echo ✓ Java安装完成
)

:: 设置Java环境
set "JAVA_HOME=%JAVA_DIR%"
set "PATH=%JAVA_DIR%\bin;%PATH%"

echo.
echo 验证Java安装...
"%JAVA_HOME%\bin\java.exe" -version
if !errorlevel! neq 0 (
    echo ✗ Java验证失败
    pause
    exit /b 1
)
echo ✓ Java环境正常

:: ═══════════════════════════════════════════════════════════════
:: 3. 下载Android命令行工具
:: ═══════════════════════════════════════════════════════════════

echo.
echo ════════════════════════════════════════════════════════════
echo  第3步：下载Android SDK工具（约150MB）
echo ════════════════════════════════════════════════════════════
echo.

set "CMDLINE_ZIP=%BUILD_TOOLS%\commandlinetools.zip"
set "CMDLINE_URL=https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"

if exist "%CMDLINE_DIR%\cmdline-tools\bin\sdkmanager.bat" (
    echo ✓ SDK工具已安装，跳过下载
) else (
    echo 正在下载Android命令行工具...
    echo 来源：Google官方
    echo.

    powershell -Command "& { ^
        $ProgressPreference = 'SilentlyContinue'; ^
        Write-Host '下载中...'; ^
        try { ^
            Invoke-WebRequest -Uri '%CMDLINE_URL%' -OutFile '%CMDLINE_ZIP%' -TimeoutSec 600; ^
            Write-Host '✓ 下载完成'; ^
        } catch { ^
            Write-Host '✗ 下载失败：' $_.Exception.Message; ^
            exit 1; ^
        } ^
    }"

    if !errorlevel! neq 0 (
        echo.
        echo ✗ SDK工具下载失败
        echo.
        echo 请检查网络连接或访问：
        echo https://developer.android.com/studio#command-line-tools-only
        pause
        exit /b 1
    )

    echo.
    echo 正在解压SDK工具...
    powershell -Command "Expand-Archive -Path '%CMDLINE_ZIP%' -DestinationPath '%CMDLINE_DIR%' -Force"
    del "%CMDLINE_ZIP%" 2>nul

    echo ✓ SDK工具安装完成
)

:: 设置Android环境
set "ANDROID_HOME=%SDK_DIR%"
set "ANDROID_SDK_ROOT=%SDK_DIR%"

:: ═══════════════════════════════════════════════════════════════
:: 4. 安装SDK组件
:: ═══════════════════════════════════════════════════════════════

echo.
echo ════════════════════════════════════════════════════════════
echo  第4步：安装Android SDK组件（约300MB）
echo ════════════════════════════════════════════════════════════
echo.
echo 这可能需要5-10分钟，请耐心等待...
echo.

set "SDKMANAGER=%CMDLINE_DIR%\cmdline-tools\bin\sdkmanager.bat"

:: 接受许可证
echo 接受SDK许可证...
echo y | "%SDKMANAGER%" --sdk_root="%SDK_DIR%" --licenses >nul 2>&1

:: 安装必要组件
echo [1/4] 安装 platform-tools...
call "%SDKMANAGER%" --sdk_root="%SDK_DIR%" "platform-tools" >nul
if !errorlevel! neq 0 echo   ✗ 失败 && goto sdk_error
echo   ✓ 完成

echo [2/4] 安装 build-tools 34.0.0...
call "%SDKMANAGER%" --sdk_root="%SDK_DIR%" "build-tools;34.0.0" >nul
if !errorlevel! neq 0 echo   ✗ 失败 && goto sdk_error
echo   ✓ 完成

echo [3/4] 安装 platforms android-34...
call "%SDKMANAGER%" --sdk_root="%SDK_DIR%" "platforms;android-34" >nul
if !errorlevel! neq 0 echo   ✗ 失败 && goto sdk_error
echo   ✓ 完成

echo [4/4] 安装 platforms android-26...
call "%SDKMANAGER%" --sdk_root="%SDK_DIR%" "platforms;android-26" >nul
if !errorlevel! neq 0 echo   ✗ 失败 && goto sdk_error
echo   ✓ 完成

echo.
echo ✓ 所有SDK组件安装完成
goto sdk_continue

:sdk_error
echo.
echo ✗ SDK组件安装失败
echo 请检查网络连接
pause
exit /b 1

:sdk_continue

:: ═══════════════════════════════════════════════════════════════
:: 5. 配置项目
:: ═══════════════════════════════════════════════════════════════

echo.
echo ════════════════════════════════════════════════════════════
echo  第5步：配置项目
echo ════════════════════════════════════════════════════════════
echo.

:: 创建local.properties
echo sdk.dir=%SDK_DIR:\=\\%> "%PROJECT_DIR%local.properties"
echo ✓ SDK路径已配置

:: 设置环境变量供Gradle使用
set "PATH=%SDK_DIR%\platform-tools;%PATH%"

:: ═══════════════════════════════════════════════════════════════
:: 6. 构建APK
:: ═══════════════════════════════════════════════════════════════

echo.
echo ════════════════════════════════════════════════════════════
echo  第6步：构建APK（约5-10分钟）
echo ════════════════════════════════════════════════════════════
echo.
echo 首次构建需要下载Gradle和依赖库...
echo 请耐心等待，不要关闭窗口
echo.

:: 确保gradlew.bat可执行
if not exist "%PROJECT_DIR%gradlew.bat" (
    echo ✗ gradlew.bat 不存在
    echo 请确保项目完整
    pause
    exit /b 1
)

:: 开始构建
cd /d "%PROJECT_DIR%"
call gradlew.bat assembleDebug

if !errorlevel! == 0 (
    echo.
    echo ╔════════════════════════════════════════════════════════════╗
    echo ║                                                            ║
    echo ║               ✓ 构建成功！APK已生成                        ║
    echo ║                                                            ║
    echo ╚════════════════════════════════════════════════════════════╝
    echo.

    set "APK_PATH=%PROJECT_DIR%app\build\outputs\apk\debug\app-debug.apk"

    echo APK信息：
    echo ───────────────────────────────────────────────────────────
    echo 位置：!APK_PATH!
    echo.

    if exist "!APK_PATH!" (
        for %%A in ("!APK_PATH!") do (
            set /a SIZE_KB=%%~zA/1024
            set /a SIZE_MB=%%~zA/1024/1024
            echo 大小：!SIZE_MB! MB ^(!SIZE_KB! KB^)
        )
        echo.
        echo ═══════════════════════════════════════════════════════════
        echo  下一步：将APK传到手机
        echo ═══════════════════════════════════════════════════════════
        echo.
        echo 方式1：微信
        echo   • 发送给"文件传输助手"
        echo   • 手机上打开微信接收
        echo.
        echo 方式2：QQ
        echo   • 发送给"我的电脑"
        echo   • 手机上打开QQ接收
        echo.
        echo 方式3：USB数据线
        echo   • 连接手机到电脑
        echo   • 复制APK到手机
        echo.
        echo 方式4：蓝牙
        echo   • 通过蓝牙传输
        echo.
        echo ═══════════════════════════════════════════════════════════
        echo.
        echo 正在打开APK所在文件夹...
        start "" "%PROJECT_DIR%app\build\outputs\apk\debug"
    ) else (
        echo ✗ APK文件未找到
    )

) else (
    echo.
    echo ╔════════════════════════════════════════════════════════════╗
    echo ║                                                            ║
    echo ║                    ✗ 构建失败                              ║
    echo ║                                                            ║
    echo ╚════════════════════════════════════════════════════════════╝
    echo.
    echo 请检查上面的错误信息
    echo.
    echo 常见问题：
    echo  • 网络连接问题 → 检查网络
    echo  • 磁盘空间不足 → 清理磁盘
    echo  • 防火墙拦截   → 临时关闭杀毒软件
    echo.
    echo 详细故障排除请查看：BUILD_GUIDE.md
)

echo.
echo ═══════════════════════════════════════════════════════════════
echo  构建工具已安装到：
echo  %BUILD_TOOLS%
echo.
echo  下次构建只需运行：quick_build.bat
echo  （无需重新下载工具）
echo ═══════════════════════════════════════════════════════════════
echo.
pause
