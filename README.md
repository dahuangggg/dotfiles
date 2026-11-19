# dotfiles

[中文](#中文) | [English](#english)

---

## 中文

个人 macOS 配置文件集合，涵盖 Zsh、Yazi、Ghostty、Zed、Starship、Neovim、Kitty 和 Rime（鼠须管），附带可预览、可选择、自动备份的安装脚本。

### 状态

早期项目，不再维护。

### 功能

- `install.py`：默认仅预览变更；`--apply` 才写入文件，被替换的文件备份到 `~/.local/state/dotfiles/backups/<timestamp>/`；相同文件跳过；拒绝符号链接的目标目录。
- `--only` 只安装部分应用（`zsh yazi ghostty zed starship nvim kitty rime`），`--target` 指定目标 home 目录。
- Zsh：模块化配置（别名、函数、vi 模式按键、fzf 搜索、插件加载、Starship 提示符），首次启动从 GitHub 拉取 4 个插件；Yazi `y` 包装函数；手动代理开关（默认端口 6152/6153）。
- Neovim：lazy.nvim 插件管理（`lazy-lock.json` 锁定版本），LSP（lua_ls、clangd、jdtls、pyright）、补全、格式化、调试、Copilot 等；速查见 `config/nvim/README.md`。
- Yazi：自定义 Lua 布局，内置 catppuccin-mocha、kanagawa、gruvbox-dark 主题（保留各自许可证）。
- Rime / 鼠须管：雾凇拼音方案、多种双拼与 T9 方案、公开词库、Lua 扩展、OpenCC 数据和外观/按键设置；不包含个人词库与同步数据。
- Ghostty、Kitty、Zed、Starship 的外观和快捷键配置。
- 机器相关配置和凭据放在 `~/.zshrc.local` / `~/.zprofile.local`，不纳入仓库。

### 技术栈

Zsh、Lua（Neovim / Yazi / Rime）、YAML（Rime）、TOML（Starship / Yazi）、JSON（Zed）、Python 3（安装脚本）、Homebrew（`Brewfile`）。目标平台为 macOS。

### 快速开始

先安装 Homebrew，然后：

```sh
git clone https://github.com/dahuangggg/dotfiles.git
cd dotfiles
brew bundle --file Brewfile
python3 install.py            # 预览
python3 install.py --apply    # 写入并备份
```

只安装部分应用：

```sh
python3 install.py --only zsh starship ghostty
python3 install.py --apply --only zsh starship ghostty
```

Rime：`brew install --cask squirrel` 后执行 `python3 install.py --apply --only rime`（安装到 `~/Library/Rime/`），在 macOS 输入法中启用鼠须管，选择「重新部署」，再选择「雾凇拼音」方案。安装脚本不会自动部署，也不会修改系统输入源。

Neovim 首次启动会通过 lazy.nvim 和 Mason 安装插件与语言工具（`:Lazy restore` 按锁文件恢复）；Java 需要 JDK 21，Copilot 需要单独执行 `:Copilot setup`。

恢复：将打印出的备份目录中的对应文件复制回原路径即可。

### 目录结构

```text
.
├── Brewfile      # Homebrew 应用与命令行依赖
├── install.py    # 预览 / 选择性安装 / 备份
├── home/         # .zshrc、.zprofile、.zshenv
└── config/       # zsh、nvim、yazi、ghostty、zed、starship、kitty、rime
```

### 许可证

仓库根目录未提供许可证。Rime 配置保留上游许可证 `config/rime/LICENSE`，Yazi 主题保留各自目录下的许可证。

---

## English

Personal macOS configuration for Zsh, Yazi, Ghostty, Zed, Starship, Neovim, Kitty and Rime (Squirrel), with an installer that previews changes, installs selectively and backs up replaced files.

### Status

Early project, no longer actively maintained.

### Features

- `install.py`: previews by default; `--apply` writes files and backs up replaced ones under `~/.local/state/dotfiles/backups/<timestamp>/`. Identical files are skipped; symlinked destination directories are rejected.
- `--only` installs a subset (`zsh yazi ghostty zed starship nvim kitty rime`); `--target` sets the destination home directory.
- Zsh: modular config (aliases, functions, vi-mode bindings, fzf search, plugin loader, Starship prompt). Four plugins are cloned from GitHub on first start. Includes the Yazi `y` wrapper and manual proxy helpers (ports 6152/6153 by default).
- Neovim: lazy.nvim with a committed `lazy-lock.json`; LSP (lua_ls, clangd, jdtls, pyright), completion, formatting, debugging, Copilot. Cheat sheet in `config/nvim/README.md`.
- Yazi: custom Lua layout plus catppuccin-mocha, kanagawa and gruvbox-dark flavors (with their licenses).
- Rime / Squirrel: Rime Ice schemas, double-pinyin and T9 variants, public dictionaries, Lua modules, OpenCC data and Squirrel appearance/key settings. Personal dictionaries and sync data are excluded.
- Appearance and keybindings for Ghostty, Kitty, Zed and Starship.
- Machine-specific settings and credentials belong in `~/.zshrc.local` / `~/.zprofile.local`, outside the repo.

### Tech stack

Zsh, Lua (Neovim / Yazi / Rime), YAML (Rime), TOML (Starship / Yazi), JSON (Zed), Python 3 (installer), Homebrew (`Brewfile`). Targets macOS.

### Getting started

Install Homebrew first, then:

```sh
git clone https://github.com/dahuangggg/dotfiles.git
cd dotfiles
brew bundle --file Brewfile
python3 install.py            # preview
python3 install.py --apply    # write and back up
```

Install only some applications:

```sh
python3 install.py --only zsh starship ghostty
python3 install.py --apply --only zsh starship ghostty
```

Rime: `brew install --cask squirrel`, then `python3 install.py --apply --only rime` (installs into `~/Library/Rime/`). Enable Squirrel in macOS Input Sources, choose Deploy from its menu, and select Rime Ice (雾凇拼音). The installer does not deploy Rime or change input sources.

On first launch Neovim installs plugins and language tools via lazy.nvim and Mason (`:Lazy restore` restores locked revisions). Java tooling needs JDK 21; Copilot needs `:Copilot setup`.

To restore a replaced file, copy it back from the printed backup directory.

### Directory structure

```text
.
├── Brewfile      # Homebrew apps and CLI dependencies
├── install.py    # preview / selective install / backups
├── home/         # .zshrc, .zprofile, .zshenv
└── config/       # zsh, nvim, yazi, ghostty, zed, starship, kitty, rime
```

### License

No top-level license. The Rime bundle keeps its upstream license in `config/rime/LICENSE`; Yazi flavors keep their own licenses.
