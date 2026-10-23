# 快速启动指南

## 🚀 5分钟上手指南

### 第一步: 安装Android Studio (仅首次需要)

1. 下载 [Android Studio](https://developer.android.com/studio)
2. 运行安装程序，全部选择默认选项
3. 首次启动会自动下载SDK (约等待10分钟)

### 第二步: 打开项目

1. 启动Android Studio
2. 点击 `Open` 按钮
3. 选择文件夹: `D:\百宝箱\AIKeyboard`
4. 等待Gradle同步 (底部状态栏会显示进度，约3-5分钟)

> ⚠️ 如果出现"SDK not found"错误：
> - 点击 Tools → SDK Manager
> - 确保 Android 13.0 (API 33) 已勾选
> - 点击 Apply 下载

### 第三步: 构建APK

1. 点击顶部菜单: `Build` → `Build Bundle(s) / APK(s)` → `Build APK(s)`
2. 等待构建完成 (约2分钟)
3. 看到提示: "APK(s) generated successfully"
4. 点击 `locate` 链接查看APK位置

生成的APK路径:
```
D:\百宝箱\AIKeyboard\app\build\outputs\apk\debug\app-debug.apk
```

### 第四步: 安装到小米手机

#### 方法A: USB连接（推荐）

1. **开启开发者选项**:
   - 设置 → 我的设备 → 全部参数 → 连续点击"MIUI版本"7次

2. **开启USB调试**:
   - 设置 → 更多设置 → 开发者选项 → USB调试 (开启)

3. **连接手机**:
   - 用USB线连接手机和电脑
   - 手机上点击"允许USB调试"
   - 在Android Studio中点击绿色▶️按钮
   - 选择你的手机设备
   - 应用会自动安装并打开

#### 方法B: 传输APK

1. 将APK文件复制到手机 (通过微信/QQ/蓝牙等)
2. 在手机上打开文件管理器
3. 找到APK文件并点击
4. 点击"安装"
5. 如果提示"未知来源"，允许安装

### 第五步: 配置键盘

1. **打开AI键盘应用**
2. **启用键盘**:
   - 点击"点击启用键盘"按钮
   - 会跳转到系统设置
   - 找到"AI键盘"并勾选
   - 点击"确定"允许

3. **配置API Key**:
   - 返回AI键盘应用
   - 在"API Key"栏填入你的DeepSeek API Key
   - (如果没有，去 https://platform.deepseek.com/ 注册)
   - 点击"测试连接"，看到"连接成功✓"

4. **使用键盘**:
   - 打开任意应用 (微信/备忘录等)
   - 点击输入框
   - **长按输入框**
   - 选择"输入法" → "AI键盘"

## 🎯 获取DeepSeek API Key

1. 访问: https://platform.deepseek.com/
2. 点击右上角"登录/注册"
3. 完成注册后进入控制台
4. 点击"API Keys"
5. 点击"创建新密钥"
6. 复制生成的Key (格式: sk-xxxxxxxx)
7. 粘贴到AI键盘应用的设置中

> 💡 DeepSeek提供免费额度，足够日常使用！

## ⚡ 如果遇到问题

### Gradle同步失败
```bash
# 解决方案: 清除缓存
在Android Studio中: File → Invalidate Caches → Restart
```

### 构建失败
```bash
# 解决方案: 清理项目
在Android Studio中: Build → Clean Project
然后再次 Build → Build APK
```

### 手机无法连接
```bash
# 检查驱动
1. 访问小米官网下载USB驱动
2. 或在Android Studio中: Tools → SDK Manager → SDK Tools
3. 勾选 Google USB Driver
```

### API连接失败
```
1. 检查API Key是否正确复制 (不要有空格)
2. 确认手机已连接网络
3. 尝试切换到移动数据或其他WiFi
```

## 📝 下一步

- [ ] 尝试基本输入功能
- [ ] 测试API连接
- [ ] (后续版本) 使用AI改写功能
- [ ] (后续版本) 使用AI续写功能

## 💬 需要帮助?

如果仍然有问题:
1. 查看完整README.md
2. 检查Android Studio底部的"Build"标签页查看详细错误
3. 截图错误信息发送给我

祝你使用愉快! 🎉
