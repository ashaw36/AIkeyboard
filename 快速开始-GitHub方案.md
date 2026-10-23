# 🚀 3步获取APK - 超简单！

## 你现在要做的事（总共15分钟）

```
第1步：上传代码到GitHub      （5分钟）
第2步：等待自动构建          （10分钟，可以去喝咖啡）
第3步：下载APK              （1分钟）
```

---

## 📝 第1步：上传代码到GitHub

### 1.1 创建GitHub账号（如果没有）
- 访问：https://github.com
- 点击右上角 `Sign up`
- 填写邮箱、密码、用户名
- **免费！**

### 1.2 创建新仓库
1. 登录后，点击右上角 `+` → `New repository`
2. 仓库名随便填，比如：`AIKeyboard`
3. 选择 `Public`（公开，免费无限构建）
4. ✅ **不要勾选**任何"Initialize"选项
5. 点击 `Create repository`
6. **记住这个地址**，比如：
   ```
   https://github.com/你的用户名/AIKeyboard.git
   ```

### 1.3 安装Git并上传

#### 超简单方法：GitHub Desktop（图形界面）

1. **下载**：https://desktop.github.com
2. **安装**：一路下一步
3. **登录**：用你的GitHub账号
4. **添加项目**：
   - File → Add Local Repository
   - 选择：`D:\百宝箱\AIKeyboard`
   - 点击：`Create a repository here instead`
5. **发布**：
   - 点击：`Publish repository`
   - 确认名称和设置
   - 点击：`Publish repository`

**完成！** 代码已经上传了！

#### 命令行方法（可选）

如果你习惯用命令行：

```bash
# 1. 下载Git: https://git-scm.com/download/win
# 2. 在项目文件夹右键 → Git Bash Here
# 3. 执行以下命令：

git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/你的用户名/AIKeyboard.git
git push -u origin master
```

---

## ⏳ 第2步：等待自动构建

### 什么都不用做！

- 代码上传后，GitHub会**自动开始构建APK**
- 你可以去喝杯咖啡 ☕
- 大约10分钟后完成

### 想看进度？

1. 打开你的GitHub仓库页面
2. 点击顶部 `Actions` 标签
3. 看到一个工作流在运行：
   - 🟡 黄色圆圈 = 正在构建
   - ✅ 绿色对勾 = 完成
   - ❌ 红色叉号 = 失败（很少见）

---

## 📥 第3步：下载APK

### 3.1 找到APK

1. 在 `Actions` 页面
2. 点击那个显示 ✅ 的构建
3. 滚动到页面**最底部**
4. 找到 `Artifacts` 部分
5. 点击 `app-debug` 下载

### 3.2 解压

- 下载的是一个 `.zip` 文件
- 解压后得到：`app-debug.apk`

### 3.3 发送到手机

- 微信文件传输助手
- QQ我的电脑
- USB数据线
- 任何你方便的方式

---

## 📱 安装到手机

### 小米手机

1. **打开APK文件**
2. 如果提示"未知来源"：
   - 点击"设置"
   - 允许此来源安装应用
3. **点击安装**
4. **完成！**

### 其他Android手机

类似，都是允许未知来源安装即可。

---

## 🎉 成功！现在配置使用

### 首次打开

1. **打开"AI键盘"应用**
2. **点击"启用键盘"按钮**
   - 会跳转到系统设置
   - 找到"AI键盘"
   - 打开开关
3. **填写DeepSeek API Key**
   - 去 https://platform.deepseek.com 注册
   - 创建API Key
   - 复制粘贴到应用中
4. **点击"测试连接"**
   - 看到"连接成功"就OK了

### 开始使用

1. 打开任意输入框（微信、短信等）
2. 长按输入框
3. 选择"输入法" → "AI键盘"
4. 开始打字！

---

## 🔄 以后修改代码后

只需要重新上传代码：

### 使用GitHub Desktop
1. 打开GitHub Desktop
2. 看到修改的文件列表
3. 输入提交说明（比如："添加了新功能"）
4. 点击"Commit to master"
5. 点击"Push origin"

**完成！** GitHub会自动构建新APK。

### 使用命令行
```bash
git add .
git commit -m "更新说明"
git push
```

---

## ❓ 常见问题

### Q: 构建失败了怎么办？
**A:** 在Actions页面点击失败的工作流，查看错误信息。
常见原因：网络临时问题，点"Re-run jobs"重试即可。

### Q: 找不到Artifacts？
**A:** 确保：
1. 工作流显示 ✅ 完成
2. 滚动到页面**最底部**
3. 等待页面加载完成

### Q: APK能安装但闪退？
**A:** 检查：
1. Android版本是否 ≥ 8.0
2. 查看应用权限是否已授予
3. 查看崩溃日志（需要连接电脑用adb）

### Q: 为什么要用GitHub？
**A:** 因为：
- ✅ 完全免费
- ✅ 不需要安装任何开发工具
- ✅ 自动构建，省心省力
- ✅ 全球最大代码托管平台，稳定可靠

---

## 📚 需要更多帮助？

详细文档：
- **GitHub构建指南.md** - 完整详细教程
- **使用说明.txt** - 应用使用指南
- **README.md** - 项目技术文档

---

## 🎯 总结

```
1. 创建GitHub仓库
2. 上传代码（用GitHub Desktop超简单）
3. 等10分钟
4. 下载APK
5. 安装使用
```

**就这么简单！** 🎉

现在就开始吧：https://github.com

---

**有任何问题随时问我！** 😊
