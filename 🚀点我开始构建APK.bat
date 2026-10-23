@echo off
chcp 65001 >nul
cls

echo.
echo     ╔══════════════════════════════════════════════════════╗
echo     ║                                                      ║
echo     ║         🚀 AI键盘 - 一键构建APK                      ║
echo     ║                                                      ║
echo     ╚══════════════════════════════════════════════════════╝
echo.
echo.
echo     你有两个选择：
echo.
echo     ┌──────────────────────────────────────────────────────┐
echo     │                                                      │
echo     │  [1] 完全自动构建（推荐）                            │
echo     │      • 自动下载所有需要的工具                        │
echo     │      • 完全自动化，无需任何准备                      │
echo     │      • 约15-25分钟                                   │
echo     │                                                      │
echo     └──────────────────────────────────────────────────────┘
echo.
echo     ┌──────────────────────────────────────────────────────┐
echo     │                                                      │
echo     │  [2] 快速构建（需要Java环境）                        │
echo     │      • 如果已安装Java 17+或Android Studio           │
echo     │      • 约5分钟                                       │
echo     │                                                      │
echo     └──────────────────────────────────────────────────────┘
echo.
echo     ┌──────────────────────────────────────────────────────┐
echo     │                                                      │
echo     │  [3] 查看详细说明文档                                │
echo     │                                                      │
echo     └──────────────────────────────────────────────────────┘
echo.
echo     ┌──────────────────────────────────────────────────────┐
echo     │                                                      │
echo     │  [0] 退出                                            │
echo     │                                                      │
echo     └──────────────────────────────────────────────────────┘
echo.
echo.

set /p choice=     请选择 [1/2/3/0]: 

if "%choice%"=="1" (
    cls
    echo.
    echo     正在启动完全自动构建...
    echo.
    call "%~dp0完全自动构建.bat"
    goto end
)

if "%choice%"=="2" (
    cls
    echo.
    echo     正在启动快速构建...
    echo.
    
    :: 先检查Java
    java -version >nul 2>&1
    if errorlevel 1 (
        echo.
        echo     ✗ 未检测到Java环境
        echo.
        echo     请选择选项1（完全自动构建）
        echo     或先安装Java/Android Studio
        echo.
        pause
        goto end
    )
    
    call "%~dp0quick_build.bat"
    goto end
)

if "%choice%"=="3" (
    start "" "%~dp0如何获得APK.txt"
    start "" "%~dp0一键构建APK指南.md"
    goto end
)

if "%choice%"=="0" (
    exit
)

echo.
echo     无效的选择，请重新运行
pause

:end
