# 🛠️ LeviBox: 在 Linux 上快速运行 LeviLamina 🚀

[English] (https://github.com/dmblock/levibox)
[简体中文] (https://github.com/dmblock/levibox/blob/main/README_CN.md)

欢迎来到 **LeviBox** 项目！这是一个方便的工具，可以在没有 Docker 和无根权限的 Linux 系统上，使用 **proot** 快速运行 ，其次，您也可以在大部分面板服上运行[LeviLamina](https://github.com/LiteLDev/LeviLamina) 🎉。

## 📦 简介

LeviBox 利用 Linux 容器技术，为您提供一个简单的运行脚本，只需几个简单的步骤，您就可以启动 LeviLamina。无论您的系统权限如何，LeviBox 都能帮您轻松搞定！💪

## 🔥 特点

- **无须 Docker**: 在没有安装 Docker 的情况下运行应用。
- **无根权限支持**: 适用于没有 root 权限的用户。
- **简单易用**: 只需下载并运行脚本，快速启动。

## 📥 安装步骤

1. **下载最新版本**  
   访问 [Releases](https://github.com/dmblock/levibox/releases)，下载最新的 `levibox.zip` 文件 📥。

2. **解压文件**  
   将下载的文件解压到您希望安装 LeviLamina 的目录 🗂️。

3. **运行脚本**  
   打开终端，导航到解压目录，执行以下命令启动 LeviLamina:  
   ```bash
   bash levibox/run.sh
   ```

## ⚙️ 注意事项

- 确保您的系统中已安装 `bash`。
- 请根据需要调整脚本中的相关配置。
- 如果遇到报错wine: Call from 00006FFFFFC1CF77 to unimplemented function msvcp140_atomic_wait.dll.__std_atomic_wait_get_deadline, aborting,请把plugins/LeviLamina/config/Config.json中的enableStatistics的值改为false，并重启。
- 如果遇到其他报错，重启即可解决

## 🤝 贡献

欢迎您为 LeviBox 项目贡献代码！如果您有任何建议或错误报告，请随时通过 GitHub 提交问题或拉取请求。

## 📫 联系我们

如需进一步信息或帮助，请访问 [GitHub 主页](https://github.com/dmblock/levibox) 或通过 Issues 联系我们！我们非常乐意提供帮助！😊

---

感谢您使用 LeviBox，祝您使用愉快！🎊
