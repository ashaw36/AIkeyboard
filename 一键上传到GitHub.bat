@echo off
chcp 65001 >nul
echo.
echo ========================================
echo    AI键盘 - 一键上传到GitHub
echo ========================================
echo.

cd /d "%~dp0"

echo [1/7] 检查Git状态...
git status >nul 2>&1
if errorlevel 1 (
    echo [信息] 初始化Git仓库...
    git init
    git branch -M master
)

echo [2/7] 添加文件到Git...
git add .

echo [3/7] 创建提交...
git commit -m "Initial commit: AI Keyboard Android App"

echo.
echo ========================================
echo    请输入你的GitHub用户名
echo ========================================
set /p username=GitHub用户名:

echo.
echo [4/7] 创建GitHub仓库...
gh repo create AIKeyboard --public --source=. --remote=origin --push

if errorlevel 1 (
    echo.
    echo [警告] GitHub CLI未登录，使用手动方式...
    echo.
    echo 请在GitHub上手动创建仓库 'AIKeyboard'
    echo 然后按任意键继续...
    pause >nul

    echo.
    echo [5/7] 添加远程仓库...
    git remote add origin https://github.com/%username%/AIKeyboard.git

    echo [6/7] 推送代码到GitHub...
    git push -u origin master
) else (
    echo [5-6/7] 已通过gh cli推送
)

echo.
echo [7/7] 等待GitHub Actions构建...
echo.
echo ========================================
echo    ✅ 代码已上传到GitHub！
echo ========================================
echo.
echo 仓库地址: https://github.com/%username%/AIKeyboard
echo Actions地址: https://github.com/%username%/AIKeyboard/actions
echo.
echo 请在浏览器中打开Actions地址查看构建进度
echo 约10分钟后可以下载APK
echo.
echo 按任意键在浏览器中打开...
pause >nul

start https://github.com/%username%/AIKeyboard/actions

echo.
echo ========================================
echo    后续步骤
echo ========================================
echo.
echo 1. 等待构建完成（约10分钟）
echo 2. 点击显示 ✅ 的构建
echo 3. 滚动到底部找到 Artifacts
echo 4. 下载 app-debug
echo 5. 解压得到APK文件
echo.
pause
