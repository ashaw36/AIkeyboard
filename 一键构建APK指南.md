# 一键构建APK指南

## 🚀 最简单方案：使用Android Studio（推荐）

### 为什么推荐？
- ✅ 一键安装所有环境
- ✅ 图形界面，简单直观  
- ✅ 自动处理所有依赖
- ✅ 总耗时：约20分钟

### 步骤：

#### 1. 下载Android Studio（5分钟）
访问：https://developer.android.com/studio

点击下载，等待完成（约1GB）

#### 2. 安装（5分钟）
- 双击安装程序
- 全部选择"下一步"
- 等待安装完成

#### 3. 打开项目（5分钟）
```
1. 启动Android Studio
2. 点击 "Open"
3. 选择: D:\百宝箱\AIKeyboard
4. 等待Gradle自动同步（底部状态栏）
```

#### 4. 构建APK（2分钟）
```
菜单栏: Build → Build Bundle(s) / APK(s) → Build APK(s)
等待完成，看到通知"APK(s) generated successfully"
点击 "locate" 查看APK文件
```

#### 5. 发送到手机
APK位置：
```
D:\百宝箱\AIKeyboard\app\build\outputs\apk\debug\app-debug.apk
```

通过以下任一方式发送：
- 微信"文件传输助手"
- QQ发送到"我的电脑"  
- USB连接复制
- 蓝牙传输

---

## ⚡ 命令行方案（需要Java环境）

### 前提条件
必须已安装以下任一：
- Android Studio (包含Java)
- Java JDK 17或更高版本

### 检查Java
打开命令提示符（cmd），输入：
```bash
java -version
```

如果显示版本号（如java version "17.0.x"），说明已安装。

### 一键构建
1. 双击运行：`D:\百宝箱\AIKeyboard\quick_build.bat`
2. 等待构建完成（首次约5-10分钟）
3. 自动打开APK所在文件夹

---

## 📦 方案对比

| 方案 | 优点 | 缺点 | 适合人群 |
|------|------|------|----------|
| **Android Studio** | 简单直观<br>一键完成<br>适合后续开发 | 需要下载1GB+ | **推荐给所有人** |
| **命令行** | 快速<br>占用空间小 | 需要提前安装Java | 熟悉命令行的用户 |

---

## 🎯 我的推荐

### 如果你：
- **完全不懂编程** → 使用Android Studio
- **想要最快速度** → 使用Android Studio  
- **需要后续修改代码** → 使用Android Studio
- **已经有Java环境** → 使用命令行也可以

### 总结：99%的情况都推荐Android Studio

---

## ❓ 没有Java环境怎么办？

### 选项1：安装Android Studio（推荐）
- 一次性解决所有问题
- 包含完整开发环境
- 下载地址：https://developer.android.com/studio

### 选项2：只安装Java
如果你不想安装Android Studio，可以只安装Java：

1. 访问：https://www.oracle.com/java/technologies/downloads/#java17
2. 选择"Windows" → "x64 Installer"  
3. 下载并安装（约200MB）
4. 然后运行 `quick_build.bat`

---

## 🔧 云端构建方案（实验性）

### GitHub Actions自动构建
如果本地构建遇到困难，可以使用云端构建：

#### 1. 上传到GitHub
```bash
cd D:\百宝箱\AIKeyboard
git init
git add .
git commit -m "Initial commit"
gh repo create AIKeyboard --private --source=. --push
```

#### 2. 添加GitHub Actions工作流
创建 `.github/workflows/build.yml`（我已准备好）

#### 3. 推送后自动构建
GitHub会自动构建APK，在Actions标签页下载

**优点**：无需本地环境  
**缺点**：需要GitHub账号，构建时间较长

---

## 📞 遇到问题？

### Gradle同步失败
**症状**：底部显示"Sync failed"

**解决**：
```
File → Invalidate Caches → Restart
```

### 找不到SDK
**症状**：提示"SDK location not found"

**解决**：
1. Android Studio会自动提示下载
2. 点击提示中的链接
3. 等待SDK下载完成

### 构建失败
**症状**：Build Output显示错误

**解决**：
1. 查看错误信息
2. 尝试：Build → Clean Project
3. 然后重新构建

### 网络问题
**症状**：下载依赖超时

**解决**：
1. 检查网络连接
2. 尝试切换网络（WiFi/手机热点）
3. 或使用国内镜像（见BUILD_GUIDE.md）

---

## ✅ 最终推荐流程

```
1. 下载Android Studio (15分钟)
   ↓
2. 安装 (5分钟)
   ↓  
3. 打开项目 D:\百宝箱\AIKeyboard (5分钟)
   ↓
4. Build → Build APK (2分钟)
   ↓
5. 发送APK到手机 (1分钟)
   ↓
6. 安装并使用！
```

**总耗时：约30分钟**  
**难度：⭐☆☆☆☆（很简单）**

---

需要我继续准备其他内容吗？比如：
- GitHub Actions自动构建配置？
- 详细的Android Studio使用截图教程？
- 国内镜像加速配置？
