@echo off
chcp 65001 >nul
echo ╔════════════════════════════════════════════════════════╗
echo ║            AI键盘 - 快速构建脚本                       ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo 前提条件:
echo - 已安装Android Studio，或
echo - 已安装Java 17+
echo.
echo 按任意键开始构建...
pause >nul

echo.
echo [1/4] 检查Java环境...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ✗ 未检测到Java
    echo.
    echo 请先安装以下任一:
    echo - Android Studio (推荐)
    echo - Java JDK 17+
    echo.
    pause
    exit /b 1
)
echo ✓ Java环境正常

echo.
echo [2/4] 清理旧构建...
if exist "app\build\outputs\apk" (
    rmdir /s /q "app\build\outputs\apk" 2>nul
)

echo.
echo [3/4] 开始构建APK...
echo (首次构建会下载依赖，请耐心等待)
echo.

call gradlew.bat assembleDebug

if %errorlevel% == 0 (
    echo.
    echo ╔════════════════════════════════════════════════════════╗
    echo ║                  ✓ 构建成功！                          ║
    echo ╚════════════════════════════════════════════════════════╝
    echo.
    echo [4/4] APK文件信息:
    echo.
    set "APK_PATH=%cd%\app\build\outputs\apk\debug\app-debug.apk"
    if exist "app\build\outputs\apk\debug\app-debug.apk" (
        for %%A in ("app\build\outputs\apk\debug\app-debug.apk") do (
            set /a SIZE_MB=%%~zA/1024/1024
            echo 位置: %%~fA
            echo 大小: !SIZE_MB! MB
        )
        echo.
        echo 现在可以:
        echo 1. 通过微信/QQ发送APK到手机
        echo 2. 通过USB复制到手机
        echo 3. 使用adb install安装
        echo.
        echo 正在打开APK所在文件夹...
        explorer "app\build\outputs\apk\debug"
    )
) else (
    echo.
    echo ╔════════════════════════════════════════════════════════╗
    echo ║                  ✗ 构建失败                            ║
    echo ╚════════════════════════════════════════════════════════╝
    echo.
    echo 常见解决方案:
    echo 1. 确保已安装Java 17+
    echo 2. 确保网络连接正常
    echo 3. 尝试: gradlew.bat clean
    echo 4. 查看上面的错误信息
)

echo.
pause
