# AI键盘 - Android输入法应用

一个基于DeepSeek AI的智能Android输入法，支持文本改写、润色和续写功能。

## 功能特性

- ✨ **智能改写**: 多种改写风格（润色、正式化、精简等）
- 🤖 **AI续写**: 根据上下文智能续写内容
- 🔄 **翻译功能**: 中英文互译
- 🎨 **iOS风格界面**: 优雅的键盘UI设计
- 🔐 **隐私安全**: API Key本地存储，不上传服务器
- ⚙️ **灵活配置**: 支持自定义API地址和模型

## 环境要求

### 开发环境
- Android Studio Hedgehog (2023.1.1) 或更高版本
- JDK 17
- Android SDK 26 (Android 8.0) 或更高

### 运行要求
- Android 8.0 (API 26) 或更高版本
- 互联网连接（用于API请求）

## 快速开始

### 1. 配置开发环境

1. 下载并安装 [Android Studio](https://developer.android.com/studio)
2. 首次启动会自动下载所需的SDK组件
3. 等待Gradle同步完成（约5-10分钟）

### 2. 构建APK

在Android Studio中:
1. 打开项目: File → Open → 选择 `D:\百宝箱\AIKeyboard`
2. 等待Gradle同步完成
3. 点击菜单: Build → Build Bundle(s) / APK(s) → Build APK(s)
4. 等待构建完成（约2-3分钟）
5. APK文件位置: `app/build/outputs/apk/release/app-release-unsigned.apk`

### 3. 安装到手机

#### 方法一: USB连接
```bash
# 开启手机USB调试
# 连接手机到电脑
# 在Android Studio中点击Run按钮
```

#### 方法二: 直接安装APK
1. 将生成的APK文件传输到手机
2. 在手机上打开文件管理器
3. 点击APK文件安装

### 4. 配置键盘

1. 打开"AI键盘"应用
2. 点击"点击启用键盘"按钮，在系统设置中启用
3. 在应用中填写DeepSeek API Key
4. 点击"测试连接"验证配置
5. 在任意输入框长按，选择"AI键盘"作为输入法

## API配置

### 获取DeepSeek API Key

1. 访问 [DeepSeek平台](https://platform.deepseek.com/)
2. 注册/登录账号
3. 在控制台创建API Key
4. 复制API Key到应用设置中

### 自定义API

如果使用其他OpenAI兼容的API服务:

1. API地址: 填写完整的base URL (如: `https://api.example.com`)
2. API Key: 填写对应服务的密钥
3. 模型: 填写支持的模型名称

## 使用说明

### 基础输入
- 标准QWERTY键盘布局
- 支持大小写切换
- 删除键长按连续删除

### AI功能 (开发中)
- **改写**: 选中文本后点击"AI"按钮，选择改写风格
- **续写**: 光标定位后点击"续写"按钮
- **翻译**: 选中文本后选择翻译语言

## 项目结构

```
AIKeyboard/
├── app/
│   ├── src/main/
│   │   ├── java/com/aikeyboard/
│   │   │   ├── ai/                  # AI服务层
│   │   │   │   ├── models/          # 数据模型
│   │   │   │   ├── DeepSeekClient.kt
│   │   │   │   └── AIServiceManager.kt
│   │   │   ├── ime/                 # 输入法核心
│   │   │   │   └── AIKeyboardService.kt
│   │   │   ├── ui/                  # 界面层
│   │   │   │   └── settings/
│   │   │   └── storage/             # 数据存储
│   │   ├── res/                     # 资源文件
│   │   │   ├── layout/              # 布局
│   │   │   ├── values/              # 字符串、颜色等
│   │   │   ├── xml/                 # 键盘定义
│   │   │   └── drawable/            # 图标
│   │   └── AndroidManifest.xml
│   └── build.gradle.kts
├── gradle/                          # Gradle配置
└── README.md
```

## 依赖项

项目仅使用3个轻量级依赖:
- **OkHttp** (网络请求)
- **Gson** (JSON解析)
- **Kotlin Coroutines** (异步处理)

总大小约5MB，无需复杂框架。

## 开发状态

### ✅ 已完成
- [x] 项目架构搭建
- [x] 基础键盘功能
- [x] DeepSeek API集成
- [x] 设置界面
- [x] API配置存储

### 🚧 开发中
- [ ] AI功能菜单UI
- [ ] 文本改写功能
- [ ] 续写功能
- [ ] 翻译功能
- [ ] 暗色主题适配

### 📋 计划中
- [ ] 候选词面板
- [ ] 历史记录
- [ ] 快捷短语
- [ ] 皮肤主题

## 故障排除

### 问题: Gradle同步失败
解决: 
1. 检查网络连接
2. 在Android Studio中: File → Invalidate Caches → Restart
3. 删除项目根目录的 `.gradle` 文件夹后重新打开项目

### 问题: 构建失败 - SDK未找到
解决:
1. 打开SDK Manager (Tools → SDK Manager)
2. 确保已安装 Android SDK 26 和最新的 Build Tools
3. 重新同步Gradle

### 问题: API连接失败
解决:
1. 检查API Key是否正确
2. 确认手机网络连接正常
3. 检查API地址格式是否正确

### 问题: 键盘无法启用
解决:
1. 前往系统设置 → 语言和输入法 → 虚拟键盘
2. 找到"AI键盘"并启用
3. 在任意输入框切换输入法

## 隐私说明

- API Key仅存储在本地设备
- 所有文本处理请求仅发送至配置的AI服务端点
- 不收集或上传用户输入内容
- 不包含任何追踪或分析代码

## 许可证

本项目仅用于学习和个人使用。

## 更新日志

### v1.0.0 (2026-10-23)
- 初始版本发布
- 基础键盘功能
- DeepSeek AI集成
- 设置界面

## 贡献

欢迎提交Issue和Pull Request!

## 联系方式

如有问题或建议，请通过以下方式联系:
- 提交GitHub Issue
- 邮件: [您的邮箱]
