# 🛠️ LeviBox: Run LeviLamina 🚀 quickly on Linux

[English] (https://github.com/dmblock/levibox)
[简体中文] (https://github.com/dmblock/levibox/blob/main/README_CN.md)

Welcome to the **LeviBox** project! This is a handy tool that can be run quickly with **proot** on Linux systems without Docker and no root privileges, and secondly, you can also run [LeviLamina] (https://github.com/LiteLDev/LeviLamina) 🎉 on most panel servers.

## 📦 Introduction

LeviBox leverages Linux container technology to provide you with a simple script to run, and in just a few simple steps, you can start LeviLamina. Regardless of your system permissions, LeviBox has you covered! 💪

## 🔥 Features

- No Docker required: Run the app without Docker installed.
- **No Root Support**: For users who do not have root privileges.
- **Easy to use**: Just download and run the script and get started quickly.

## 📥 Installation Steps

1. **Download Latest Version**
Visit [Releases] (https://github.com/dmblock/levibox/releases) to download the latest 'levibox.zip' file 📥.

2. **Unzip the file**
Extract the downloaded file to the directory 🗂️ where you want to install LeviLamina.

3. **Run Script**
Open Terminal, navigate to the extraction directory, and run the following command to launch LeviLamina:
```bash
bash levibox/run.sh
```

## ⚙️ Precautions

- Make sure you have 'bash' installed on your system.
- Adjust the configuration in the script as needed.
- If an error 'wine: Call from 00006FFFFFC1CF77 to unimplemented function msvcp140_atomic_wait.dll.__std_atomic_wait_get_deadline, aborting' occurs, Please change the value of enableStatistics in plugins/LeviLamina/config/Config.json to false and restart.
- If you encounter other errors, restarting will resolve the issue.

## 🤝 Contribute

You are welcome to contribute to the LeviBox project! If you have any suggestions or bug reports, feel free to submit an issue or pull request via GitHub.

## 📫 Contact us

For further information or assistance, please visit the [GitHub homepage] (https://github.com/dmblock/levibox) or contact us via Issues! We're more than happy to help! 😊

---

Thank you for using LeviBox and have fun! 🎊
