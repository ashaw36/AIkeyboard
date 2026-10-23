# 🚀 GitHub Actions 云端构建APK指南

## 📌 为什么选择GitHub Actions？

✅ **零本地配置** - 不需要在电脑上安装任何开发工具  
✅ **完全免费** - GitHub提供免费的构建服务  
✅ **自动化** - 代码一推送就自动构建  
✅ **随时随地** - 任何设备、任何网络都能下载APK  
✅ **稳定可靠** - GitHub官方服务器构建  

---

## 🎯 完整操作流程（15分钟）

### 步骤1：创建GitHub仓库（3分钟）

1. **打开GitHub网站**
   - 访问：https://github.com
   - 如果没有账号，点击"Sign up"注册（免费）

2. **创建新仓库**
   - 点击右上角的 `+` 号
   - 选择 `New repository`
   - 仓库名称：`AIKeyboard` （或任意名称）
   - 选择 `Public`（公开）或 `Private`（私有，都免费）
   - ✅ **不要**勾选"Initialize this repository with"下的任何选项
   - 点击 `Create repository`

3. **记录仓库地址**
   - 你会看到类似这样的地址：
   ```
   https://github.com/你的用户名/AIKeyboard.git
   ```

---

### 步骤2：安装Git并上传代码（5分钟）

#### 方法A：使用Git命令行（推荐）

1. **下载Git for Windows**
   - 访问：https://git-scm.com/download/win
   - 下载并安装（一路"下一步"即可）

2. **打开Git Bash**
   - 在项目文件夹右键
   - 选择 `Git Bash Here`

3. **执行以下命令**（逐行复制执行）

```bash
# 初始化Git仓库
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit: AI Keyboard project"

# 连接到GitHub（替换为你的仓库地址）
git remote add origin https://github.com/你的用户名/AIKeyboard.git

# 推送代码
git push -u origin master
```

#### 方法B：使用GitHub Desktop（图形界面）

1. **下载GitHub Desktop**
   - 访问：https://desktop.github.com
   - 下载并安装

2. **添加项目**
   - 打开GitHub Desktop
   - File → Add Local Repository
   - 选择 `D:\百宝箱\AIKeyboard`

3. **发布到GitHub**
   - 点击 `Publish repository`
   - 输入仓库名称
   - 点击 `Publish repository`

---

### 步骤3：触发构建（1分钟）

#### 方法1：自动触发（推荐）

代码推送后，GitHub Actions会**自动开始构建**！

#### 方法2：手动触发

1. 打开你的GitHub仓库页面
2. 点击顶部的 `Actions` 标签
3. 左侧选择 `Build APK`
4. 点击右侧的 `Run workflow` 按钮
5. 点击绿色的 `Run workflow` 确认

---

### 步骤4：等待构建完成（5-10分钟）

1. **查看构建进度**
   - 在 `Actions` 页面
   - 你会看到一个正在运行的工作流（黄色圆圈）
   - 点击进去可以查看实时日志

2. **构建完成标志**
   - 黄色圆圈 🟡 = 正在构建中
   - 绿色对勾 ✅ = 构建成功
   - 红色叉号 ❌ = 构建失败

---

### 步骤5：下载APK（1分钟）

1. **进入构建详情**
   - 点击构建成功的工作流（绿色对勾那个）
   
2. **下载APK**
   - 滚动到页面底部
   - 找到 `Artifacts` 部分
   - 点击 `app-debug` 下载
   - 这是一个zip文件，解压后得到 `app-debug.apk`

3. **发送到手机**
   - 微信文件传输助手
   - QQ我的电脑
   - 或任何你习惯的方式

---

## 📱 在手机上安装

1. **打开手机上的APK文件**
2. **允许安装未知来源应用**
   - 小米：设置 → 隐私保护 → 特殊权限 → 安装未知应用
   - 选择"文件管理"或你用来打开APK的应用
   - 允许该来源
3. **点击安装**
4. **安装完成**

---

## 🎯 后续使用

### 每次修改代码后

只需要重复步骤2的推送命令：

```bash
git add .
git commit -m "更新说明"
git push
```

GitHub会自动构建新的APK！

### 不想每次都手动推送？

可以使用GitHub Desktop，更加直观：
1. 打开GitHub Desktop
2. 看到修改的文件
3. 输入提交说明
4. 点击"Commit to master"
5. 点击"Push origin"

完成！

---

## 🔍 故障排除

### Q: 构建失败了怎么办？

**A:** 点击失败的工作流，查看错误日志：

1. **常见错误1**：`Execution failed for task ':app:lintVitalRelease'`
   - 解决：已经在配置中禁用了lint检查，不应出现此问题

2. **常见错误2**：`Could not find com.android.tools.build:gradle:8.1.0`
   - 解决：网络问题，点击右上角"Re-run jobs"重试

3. **常见错误3**：Permission denied
   - 解决：gradlew权限问题，已经设置为可执行，不应出现

### Q: 找不到Artifacts下载？

**A:** 确保：
1. 工作流已完成（绿色对勾）
2. 滚动到页面最底部
3. Artifacts保留时间是90天，过期会自动删除

### Q: 可以构建Release版本吗？

**A:** 可以！需要签名文件：

1. 生成签名文件（keystore）
2. 在GitHub仓库添加Secrets
3. 修改构建配置使用签名

详细步骤见下方"进阶配置"。

---

## 🚀 进阶配置

### 配置自动发布Release

编辑 `.github/workflows/build-apk.yml`，添加：

```yaml
    - name: 创建Release
      if: startsWith(github.ref, 'refs/tags/')
      uses: softprops/action-gh-release@v1
      with:
        files: app/build/outputs/apk/debug/app-debug.apk
```

然后打tag并推送：
```bash
git tag v1.0.0
git push origin v1.0.0
```

APK会自动发布到Release页面！

### 添加构建缓存

已配置 `cache: gradle`，第二次构建会快很多（约2-3分钟）。

### 构建多个变体

在workflow中添加：
```yaml
    - name: 构建所有变体
      run: ./gradlew assembleDebug assembleRelease
```

---

## 📊 GitHub Actions 额度

### 免费账号
- **公开仓库**：无限分钟 ✅
- **私有仓库**：每月2000分钟
- **存储空间**：500MB

### 每次构建消耗
- 首次：约8-10分钟
- 后续（有缓存）：约3-5分钟

**结论**：足够用！即使私有仓库，每月也能构建400+次。

---

## 🎉 总结

使用GitHub Actions构建APK：

| 优点 | 说明 |
|------|------|
| ✅ 零配置 | 不需要本地开发环境 |
| ✅ 免费 | 公开仓库无限使用 |
| ✅ 自动化 | 代码一推送就构建 |
| ✅ 稳定 | GitHub官方基础设施 |
| ✅ 便捷 | 任何设备都能下载APK |

| 缺点 | 说明 |
|------|------|
| ⏱️ 稍慢 | 首次10分钟，后续5分钟 |
| 🌐 需要网络 | 必须联网才能构建 |

---

## 🆘 需要帮助？

1. **查看工作流配置**
   - 文件：`.github/workflows/build-apk.yml`
   
2. **GitHub Actions文档**
   - https://docs.github.com/actions

3. **Android构建文档**
   - https://developer.android.com/studio/build

---

**准备好了吗？开始上传代码到GitHub吧！** 🚀
