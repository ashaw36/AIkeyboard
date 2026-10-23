# 🎹 AI键盘 (AI Keyboard)

<div align="center">

![Android](https://img.shields.io/badge/Platform-Android-green.svg)
![Kotlin](https://img.shields.io/badge/Language-Kotlin-purple.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Min SDK](https://img.shields.io/badge/Min%20SDK-26%20(Android%208.0)-orange.svg)
![Build](https://img.shields.io/github/actions/workflow/status/your-username/AIKeyboard/build-apk.yml?branch=master)

一款基于DeepSeek AI的Android输入法，提供智能改写、续写和翻译功能。

[功能特性](#-功能特性) • [快速开始](#-快速开始) • [构建指南](#-构建指南) • [使用说明](#-使用说明)

</div>

---

## ✨ 功能特性

### 🚀 核心功能
- ✅ **基础输入** - 完整的英文字母键盘
- ✅ **AI改写** - 7种文本风格（正式、随意、简洁、扩展、学术、创意、修正）
- ✅ **AI续写** - 智能文本补全
- ✅ **AI翻译** - 中英文互译
- ✅ **实时处理** - 基于DeepSeek API的快速响应

### 🎨 界面设计
- 简洁优雅的iOS风格设计
- 支持深色/浅色主题
- 流畅的动画效果
- 直观的设置界面

### 🔧 技术特性
- Kotlin + Jetpack Compose
- 协程异步处理
- OkHttp网络请求
- SharedPreferences本地存储

---

## 📱 快速开始

### 系统要求
- Android 8.0 (API 26) 或更高版本
- 网络连接（用于AI功能）
- DeepSeek API Key（[免费注册](https://platform.deepseek.com)）

### 安装方式

#### 方法1：下载预构建APK（推荐）
1. 访问 [Releases](../../releases) 页面
2. 下载最新的 `app-debug.apk`
3. 在手机上安装
4. 允许"未知来源"安装

#### 方法2：从Actions构建
1. 访问 [Actions](../../actions) 标签
2. 选择最新成功的构建
3. 下载 `Artifacts` 中的APK
4. 解压并安装

#### 方法3：本地构建
```bash
# 克隆仓库
git clone https://github.com/your-username/AIKeyboard.git
cd AIKeyboard

# 构建APK
./gradlew assembleDebug

# APK位置
# app/build/outputs/apk/debug/app-debug.apk
```

---

## 🎯 使用说明

### 首次配置

1. **安装并打开应用**
2. **点击"启用键盘"**
   - 跳转到系统设置
   - 启用"AI键盘"
3. **获取DeepSeek API Key**
   - 访问：https://platform.deepseek.com
   - 注册并创建API Key
4. **填写API Key**
   - 粘贴到应用设置中
   - 点击"测试连接"验证
5. **开始使用**
   - 在任意输入框长按
   - 选择"AI键盘"作为输入法

### AI功能使用

- **改写文本**：选中文本后，选择改写风格
- **续写文本**：输入部分内容，AI自动补全
- **翻译文本**：一键中英互译

---

## 🛠️ 构建指南

### 开发环境要求
- Android Studio Hedgehog | 2023.1.1 或更高
- JDK 17 或更高
- Gradle 8.4
- Android SDK 34

### 本地构建步骤

```bash
# 1. 克隆仓库
git clone https://github.com/your-username/AIKeyboard.git
cd AIKeyboard

# 2. (可选) 配置local.properties
echo "sdk.dir=/path/to/android/sdk" > local.properties

# 3. 构建Debug版本
./gradlew assembleDebug

# 4. 构建Release版本（需要签名）
./gradlew assembleRelease

# 5. 运行测试
./gradlew test

# 6. 清理构建
./gradlew clean
```

### GitHub Actions自动构建

每次推送代码到 `master` 分支或创建Pull Request时，GitHub Actions会自动：
1. 检出代码
2. 设置JDK 17环境
3. 构建Debug APK
4. 上传APK作为Artifact

配置文件：`.github/workflows/build-apk.yml`

---

## 📁 项目结构

```
AIKeyboard/
├── app/
│   ├── src/
│   │   └── main/
│   │       ├── java/com/aikeyboard/
│   │       │   ├── ai/              # AI服务层
│   │       │   │   ├── AIServiceManager.kt
│   │       │   │   ├── DeepSeekClient.kt
│   │       │   │   └── models/
│   │       │   ├── ime/             # 输入法服务
│   │       │   │   └── AIKeyboardService.kt
│   │       │   ├── storage/         # 数据存储
│   │       │   │   └── PreferencesManager.kt
│   │       │   └── ui/              # UI层
│   │       │       └── settings/
│   │       └── res/                 # 资源文件
│   └── build.gradle.kts
├── .github/
│   └── workflows/
│       └── build-apk.yml            # CI/CD配置
├── gradle/
│   └── wrapper/
├── gradlew
├── gradlew.bat
├── settings.gradle.kts
└── build.gradle.kts
```

---

## 🔧 技术栈

| 类别 | 技术 |
|------|------|
| **语言** | Kotlin |
| **UI框架** | Android Views |
| **异步处理** | Kotlin Coroutines |
| **网络请求** | OkHttp 4.12.0 |
| **JSON解析** | Gson 2.10.1 |
| **构建工具** | Gradle 8.4 |
| **最低SDK** | API 26 (Android 8.0) |
| **目标SDK** | API 34 (Android 14) |

---

## 🤝 贡献指南

欢迎提交Issue和Pull Request！

### 开发流程
1. Fork本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启Pull Request

### 代码规范
- 遵循Kotlin官方编码规范
- 使用有意义的变量和函数命名
- 添加必要的注释
- 保持代码简洁可读

---

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

---

## 🙏 致谢

- [DeepSeek](https://www.deepseek.com/) - 提供AI API服务
- [OkHttp](https://square.github.io/okhttp/) - HTTP客户端库
- [Gson](https://github.com/google/gson) - JSON处理库

---

## 📮 联系方式

- 提交Issue：[GitHub Issues](../../issues)
- 讨论区：[GitHub Discussions](../../discussions)

---

<div align="center">

**如果这个项目对你有帮助，请点个⭐Star支持一下！**

Made with ❤️ by AI Keyboard Team

</div>
