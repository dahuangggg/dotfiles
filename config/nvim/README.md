# 我的 Neovim 速查手册

配置入口：`~/.config/nvim/init.lua`。插件由 `lazy.nvim` 管理，版本记录在 `lazy-lock.json`。

> `<leader>` 是空格键。例如 `<leader>tt` 就是依次按：空格、`t`、`t`。

## 每天最常用

| 场景 | 按键 |
| --- | --- |
| 文件树 | `<leader>b` |
| 找文件 / 搜文字 | `<C-p>` / `<C-f>` |
| Buffer 列表 | `<leader>fb` |
| 代码结构 | `<leader>o` |
| 保存 / 格式化 | `<leader>w` / `<leader>lf` |
| 诊断详情 | `<leader>d` |
| 关闭 Buffer / 退出窗口 | `<leader>c` / `<leader>q` |
| 打开 / 隐藏底部终端 | `<leader>tt` |
| 查看快捷键提示 | 按 `<leader>` 后稍等，或 `<leader>?` |
| Python 启动 / 继续调试 | `<leader>rc` |

`<leader>q` 是退出当前窗口；只剩一个窗口时会退出整个 Neovim。它不是“返回”。

## 场景一：跳转后怎么回来

| 操作 | 按键 |
| --- | --- |
| 跳到定义 | `gd` |
| 回到跳转前 | `<C-o>` |
| 再向前跳转 | `<C-i>` |
| 新分屏跳到定义 | `gD` |
| 文件树打开新文件后切回上一个文件 | `<C-^>`，通常就是 `Ctrl-6` |
| 查看所有打开过的文件 | `<leader>fb` |
| 回到上一个窗口 | `<C-w>p` |

常用 LSP：`K` 看文档，`grr` 查引用，`gri` 查实现，`grn` 重命名，`gra` 代码操作。

## 场景二：代码自动折叠

LSP 接入后会启用代码折叠；默认层级为 0，所以文件可能自动收起。

| 操作 | 按键 |
| --- | --- |
| 完全展开 | `zR` |
| 全部折叠 | `zM` |
| 切换当前折叠 | `za` |
| 展开 / 关闭当前折叠 | `zo` / `zc` |

文件打开时默认完全展开；需要时再使用以上快捷键手动折叠。
| 完全开启 / 关闭折叠功能 | `zi` |

## 场景三：打开和使用终端

按 `<leader>tt`，会在底部打开 12 行高的 ToggleTerm 并进入输入模式；再按一次可隐藏。

| 操作 | 按键 |
| --- | --- |
| 退出终端输入模式 | 连按两次 `Esc` |
| 从终端去上方代码 | `Esc Esc`，再按 `<C-k>` |
| 从代码去下方终端 | `<C-j>`，再按 `i` |
| 隐藏终端 | `Esc Esc`，再按 `<leader>tt` |

## 场景四：LeetCode Python

工作目录：

```bash
cd ~/test/lc
nvim solutions/lc0139_word_break.py
```

固定运行循环：

1. `<leader>w` 保存。
2. `<C-j>` 去终端，按 `i`。
3. 执行命令，之后用 `↑ Enter` 重跑。
4. `Esc Esc`，再按 `<C-k>` 回代码。

```bash
python3 solutions/lc0139_word_break.py < cases/0139.txt
```

zsh 的 `r` 是“重新执行上一条历史命令”，不是固定的 LeetCode 命令：

```bash
r           # 重跑上一条命令
r python3   # 重跑最近一条以 python3 开头的命令
```

至少验证：题目样例、边界输入、一个能攻击当前思路的反例。退出码 0 只代表程序没崩溃，不代表答案正确。

提交到 LeetCode 时，一般只复制必要的 `import` 和 `class Solution`；本地输入解析与 `__main__` 不提交。

### 单步 Debug

使用 `nvim-dap + debugpy`：

1. `<leader>w` 保存，在目标行按 `<leader>rb` 加断点。
2. `<leader>rc` 启动当前 Python 文件；调试界面会自动打开。
3. 程序需要输入时，在集成终端粘贴测试数据。
4. 用 `<leader>rn` 单步、`<leader>ri` 进入函数、`<leader>ro` 跳出函数。
5. 程序自然结束后调试界面会保留，方便查看输出；按 `<leader>ru` 手动隐藏。程序仍在运行时按 `<leader>rt` 停止并关闭界面。

| DAP 按键 | 用途 |
| --- | --- |
| `<leader>rb` / `<leader>rB` | 普通断点 / 条件断点 |
| `<leader>rc` / `<leader>rl` | 启动或继续 / 重跑上次配置 |
| `<leader>rn` / `<leader>ri` / `<leader>ro` | 跳过 / 进入 / 跳出 |
| `<leader>rr` / `<leader>ru` | REPL / 调试界面 |
| `<leader>rt` | 停止调试并关闭界面 |

DAP 不会自动套用 `< cases/0139.txt`。想快速核对完整样例时，仍在 ToggleTerm 运行重定向命令；想观察中间变量时，用 DAP 并手动粘贴输入。

算法题也可以临时加入：

```python
print(f"{i=}, {j=}, piece={s[j:i]!r}, dp={dp}")
```

定位问题后记得删除调试输出。

## 场景五：窗口和分界线

`<C-h/j/k/l>` 在左、下、上、右窗口之间移动。也可以直接用鼠标拖动分界线。

| 操作 | 按键或命令 |
| --- | --- |
| 当前窗口变高 / 变矮 | `<C-w>+` / `<C-w>-` |
| 当前窗口变宽 / 变窄 | `<C-w>>` / `<C-w><` |
| 一次调整 5 行 | `5<C-w>+` 或 `5<C-w>-` |
| 平均分配所有窗口 | `<C-w>=` |
| 精确高度 / 宽度 | `:resize 15` / `:vertical resize 80` |
| 垂直 / 水平分屏 | `<leader>sv` / `<leader>sh` |
| 关闭当前分屏 | `<leader>sc` |

终端里调整窗口前，先按 `Esc Esc`。

## 当前插件

共 27 个插件和依赖：

| 分类 | 插件 | 用途 |
| --- | --- | --- |
| 管理 | `lazy.nvim` | 安装、更新和锁定插件 |
| 查找 | `telescope.nvim`、`plenary.nvim` | 文件、文字、Buffer、帮助搜索 |
| 文件树 | `neo-tree.nvim`、`nui.nvim`、`nvim-web-devicons` | 文件浏览、UI 和图标 |
| 补全 | `blink.cmp`、`friendly-snippets` | LSP、路径和代码片段补全 |
| AI 补全 | `copilot.vim` | GitHub Copilot 行内代码建议 |
| 编辑 | `nvim-autopairs` | 自动括号；注释使用 Neovim 内置功能 |
| 快捷键 | `which-key.nvim` | 按下 `<leader>` 后显示可用按键 |
| 语法 | `nvim-treesitter` | 更准确的语法高亮和代码结构解析 |
| LSP | `mason.nvim`、`mason-lspconfig.nvim`、`nvim-lspconfig`、`mason-tool-installer.nvim` | 安装并启动语言服务器和工具 |
| 格式化 | `conform.nvim` | 调用各语言格式化器 |
| 调试 | `nvim-dap`、`nvim-dap-python`、`nvim-dap-ui`、`nvim-nio` | Python 断点、单步、变量和调用栈 |
| 终端 | `toggleterm.nvim` | 可反复打开和隐藏的底部终端 |
| Git | `gitsigns.nvim` | 修改块、暂存、撤销、Blame |
| 外观 | `gruvbox.nvim`、`tokyonight.nvim`、`catppuccin`、`lualine.nvim` | 主题和状态栏 |

默认主题是透明背景的 Gruvbox。临时切换主题：

```vim
:colorscheme tokyonight
:colorscheme catppuccin
```

## 语言支持

| 语言 | LSP | 格式化 |
| --- | --- | --- |
| Lua | `lua_ls` | `stylua` |
| Python | `pyright` | `ruff` |
| Java | `jdtls`（需要 Java 21） | `google-java-format` |
| C/C++ | `clangd` | `clang-format` |

补全：`<C-Space>` 打开，`Tab/Shift-Tab` 或 `<C-n>/<C-p>` 选择，`<C-y>` 接受，`Enter` 正常换行，`<C-e>` 关闭。

Copilot：`<leader>tc` 开关建议；灰色行内建议出现后按 `<C-j>` 接受，`<C-]>` 忽略，`Alt-]` / `Alt-[` 切换建议。首次使用执行 `:Copilot setup` 登录。

注释：`gcc` 当前行；选中后 `gc`；`gco` 在下一行创建注释。

Git 常用：`]h/[h` 切换修改块，`<leader>hp` 预览，`<leader>hs` 暂存，`<leader>hr` 撤销。

## 检查和排错

| 命令 | 用途 |
| --- | --- |
| `:Lazy` | 插件状态和更新 |
| `:Mason` | LSP、格式化工具安装状态 |
| `:TSUpdate` | 更新已安装的 Treesitter 解析器 |
| `:LspInfo` | 当前文件连接了哪个 LSP |
| `:ConformInfo` | 当前文件使用哪个格式化器 |
| `:checkhealth` | 整体健康检查 |
| `:messages` | 最近的通知和错误 |

终端检查配置能否启动：

```bash
nvim --headless '+qa'
```

主要配置位置：`lua/config/` 放编辑器配置，`lua/plugins/` 放插件配置，`lsp/` 放语言服务器配置。
