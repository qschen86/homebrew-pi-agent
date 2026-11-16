# pi-agent Homebrew Tap

Apple Silicon macOS 15+ 的本机 AI 工作台，使用用户自己的模型账号和本机数据。当前为预发布验收版。

```sh
brew tap qschen86/pi-agent
brew install qschen86/pi-agent/pi-agent
brew services start pi-agent
pi-agent open
```

查看状态：`pi-agent status`，版本：`pi-agent --version`。
停止服务：`brew services stop pi-agent`。卸载程序：`brew uninstall qschen86/pi-agent/pi-agent`，保留用户实例。

数据位于 `~/Library/Application Support/pi-agent/instance/`。请勿将本机服务直接暴露到公网。
源码、发行资源及许可资料：[qschen86/pi-agent](https://github.com/qschen86/pi-agent)。

首次任务及完整使用体验仍在验收，暂不承诺 Linux、远程访问或跨版本数据迁移。
