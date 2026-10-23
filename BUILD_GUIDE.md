# 构建指南 - AI键盘项目

## 📦 项目信息

**项目名称**: AI键盘 (AI Keyboard)  
**包名**: com.aikeyboard  
**版本**: 1.0.0  
**最低安卓版本**: Android 8.0 (API 26)  
**目标安卓版本**: Android 14 (API 34)

---

## 🛠️ 构建前检查

### 必需环境
- [x] Windows 10/11
- [x] JDK 17+ (Android Studio自带)
- [x] Android Studio Hedgehog (2023.1.1+)
- [x] Android SDK 26-34

### 项目依赖
```gradle
• Kotlin 1.9.20
• OkHttp 4.12.0 (网络请求)
• Gson 2.10.1 (JSON解析)
• Kotlin Coroutines 1.7.3 (异步处理)
```

---

## 📋 构建步骤

### 步骤1: 打开项目
```
1. 启动 Android Studio
2. File → Open
3. 选择: D:\百宝箱\AIKeyboard
4. 点击 OK
```

### 步骤2: 等待Gradle同步
```
• 首次打开会自动触发Gradle同步
• 底部状态栏显示: "Gradle: Sync"
• 等待时间: 3-8分钟 (取决于网络速度)
• 完成提示: "BUILD SUCCESSFUL"
```

**如果同步失败**:
```bash
# 方案1: 清理缓存
File → Invalidate Caches → Restart

# 方案2: 重新同步
File → Sync Project with Gradle Files

# 方案3: 清理项目
Build → Clean Project
```

### 步骤3: 构建Debug APK

#### 方法A: 通过菜单 (推荐)
```
1. Build → Build Bundle(s) / APK(s) → Build APK(s)
2. 等待构建 (约1-2分钟)
3. 看到通知: "APK(s) generated successfully"
4. 点击 "locate" 查看文件
```

#### 方法B: 通过命令行
```bash
cd D:\百宝箱\AIKeyboard
gradlew.bat assembleDebug
```

#### 方法C: 通过Gradle面板
```
1. 点击右侧 "Gradle" 面板
2. AIKeyboard → app → Tasks → build
3. 双击 "assembleDebug"
```

### 步骤4: 查找生成的APK

**默认路径**:
```
D:\百宝箱\AIKeyboard\app\build\outputs\apk\debug\app-debug.apk
```

**文件大小**: 约4-6 MB

---

## 🔨 构建Release APK (可选)

### 生成签名密钥 (首次)
```bash
cd D:\百宝箱\AIKeyboard
keytool -genkey -v -keystore aikeyboard.jks -keyalg RSA -keysize 2048 -validity 10000 -alias aikeyboard
```

### 配置签名 (app/build.gradle.kts)
```kotlin
android {
    signingConfigs {
        create("release") {
            storeFile = file("../aikeyboard.jks")
            storePassword = "你的密码"
            keyAlias = "aikeyboard"
            keyPassword = "你的密码"
        }
    }
    
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            proguardFiles(...)
        }
    }
}
```

### 构建Release
```bash
gradlew.bat assembleRelease
```

**输出路径**:
```
app/build/outputs/apk/release/app-release.apk
```

---

## 🐛 常见构建问题

### 问题1: SDK not found
**错误信息**:
```
SDK location not found. Define location with sdk.dir in the local.properties
```

**解决方案**:
```bash
# 创建 local.properties 文件
cd D:\百宝箱\AIKeyboard
echo "sdk.dir=C:\Users\你的用户名\AppData\Local\Android\Sdk" > local.properties
```

### 问题2: Gradle version mismatch
**错误信息**:
```
Minimum supported Gradle version is X.X.X. Current version is Y.Y.Y
```

**解决方案**:
```bash
# 修改 gradle/wrapper/gradle-wrapper.properties
distributionUrl=https\://services.gradle.org/distributions/gradle-8.4-bin.zip
```

### 问题3: Java version incompatible
**错误信息**:
```
Unsupported Java version
```

**解决方案**:
```
File → Settings → Build, Execution, Deployment → Build Tools → Gradle
Gradle JDK: 选择 Android Studio自带的 JDK 17
```

### 问题4: 依赖下载失败
**错误信息**:
```
Could not resolve com.squareup.okhttp3:okhttp:4.12.0
```

**解决方案**:
```gradle
// 在 build.gradle.kts 中添加阿里云镜像
repositories {
    maven("https://maven.aliyun.com/repository/public")
    maven("https://maven.aliyun.com/repository/google")
    google()
    mavenCentral()
}
```

### 问题5: 构建缓存损坏
**解决方案**:
```bash
# Windows命令
cd D:\百宝箱\AIKeyboard
rmdir /s /q .gradle
rmdir /s /q app\build
gradlew.bat clean
```

---

## 📊 构建输出分析

### Debug APK 组成
```
app-debug.apk (约5MB)
├── classes.dex (约2.5MB)     # Kotlin/Java字节码
├── resources.arsc (约100KB)   # 资源索引
├── res/ (约200KB)             # XML资源
├── lib/ (约2MB)               # 原生库
└── META-INF/ (约50KB)         # 签名信息
```

### 依赖大小分析
```
OkHttp:     ~600KB
Gson:       ~250KB
Coroutines: ~150KB
其他:       ~1MB
```

---

## ⚡ 加速构建技巧

### 1. 启用Gradle守护进程
编辑 `gradle.properties`:
```properties
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true
```

### 2. 配置内存
编辑 `gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx4096m -XX:MaxMetaspaceSize=512m
```

### 3. 使用国内镜像
编辑 `build.gradle.kts`:
```kotlin
repositories {
    maven { url = uri("https://maven.aliyun.com/repository/google") }
    maven { url = uri("https://maven.aliyun.com/repository/public") }
    google()
    mavenCentral()
}
```

### 4. 增量构建
```kotlin
android {
    buildFeatures {
        buildConfig = true
    }
}
```

---

## 🎯 构建验证

### 验证APK完整性
```bash
# 查看APK信息
aapt dump badging app-debug.apk

# 检查签名
jarsigner -verify -verbose -certs app-debug.apk

# 查看APK内容
unzip -l app-debug.apk
```

### 验证功能完整性
- [ ] AndroidManifest.xml包含输入法服务
- [ ] 包含所有必需的权限
- [ ] 资源文件完整
- [ ] Kotlin代码编译无误
- [ ] 依赖库正确打包

---

## 📦 交付清单

构建完成后，你应该有:
```
✅ app-debug.apk (可安装到手机测试)
✅ mapping.txt (ProGuard混淆映射，如果启用)
✅ 构建日志 (Build Output面板)
```

---

## 🚀 下一步

构建成功后:
1. 将APK复制到手机
2. 参考 `使用说明.txt` 进行安装
3. 参考 `QUICKSTART.md` 进行配置
4. 查看 `README.md` 了解更多功能

---

## 📞 技术支持

**构建失败?**
1. 查看 "Build" 面板的详细错误信息
2. 参考上面的"常见构建问题"章节
3. 截图错误信息并反馈

**需要帮助?**
- 查看 `README.md` 的"故障排除"章节
- 查看 `PROJECT_STATUS.md` 的"已知问题"

---

**最后更新**: 2026-10-23  
**构建系统**: Gradle 8.4 + AGP 8.2.0  
**目标平台**: Android 8.0 - 14
