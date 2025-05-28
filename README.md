![image](./images/image.png)

# Neovim Configuration

<details>
  <summary> Table of Contents</summary>

<!--toc:start-->
- [Neovim Configuration](#neovim-configuration)
  - [Dependencies](#dependencies)
  - [Install](#install)
    - [Debian](#debian)
    - [Homebrew](#homebrew)
  - [Usage](#usage)
<!--toc:end-->

</details>

My Neovim configuration based on the [LazyVim](https://www.lazyvim.org)
distribution, with custom features to extend or remove unneeded functionality.

Comes in two varieties: `main` and `lite` (default). Set the environment variable
`NVIM_MAIN_CONFIG = 1` to enable the main config. `main` enables more language
features and features that may be slow on older machines/servers.

Some cool things in here are:

- my custom (borrowed/extended) [color scheme](./colors/macro.lua)
- my custom [lualine](./lua/plugins/lualine.lua) config
- [my auto commands](./lua/config/autocmds.lua)
  - remove trailing white space on save
  - only show cursor line in active window (like reticle.nvim but in 15 LOC)
  - reliable auto save without formatting
- my [keymaps](./lua/config/keymaps.lua)
  - following all types of links/toggle checkboxes with `<CR>`, (replaces `gf`, `gx`)
    - `<S-CR>` to open in new tab
  - wrap friendly `B` and `E` motions to replace `0` and `$`
  - auto fix last spelling error in insert mode: `<C-l>`
  - word/char count: `<C-S-C>`
  - clean `^M` Windows artifacts: `<C-S-S>`
- [mini.files](./lua/plugins/mini-files.lua), the best explorer
- [nvim-spider](./lua/plugins/spider.lua) for better `w`, `e`, and `b` motions
- my snacks.nvim [picker](./lua/plugins/picker.lua) and [terminal](./lua/plugins/terminal.lua) config
  - with great integration with zoxide
- ~31ms startup time

## Dependencies

> [!IMPORTANT]
> see [my full dotfiles](https://www.github.com/n-crespo/dotfiles) for other system requirements

- `neovim` (>= 0.11 preferred)
- `gcc`
- `python`
- `go`
- `lazygit`
- `clang`
- `node`
- `ripgrep`/`rg`
- `wslu` (if using WSL)
- `xclip` (if using WSL)
- `npm` (for some language servers)

## Install

### Debian

```bash
sudo apt-get install -y neovim
sudo apt-get install python3-neovim
```

For nightly (optional):

```bash
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim # just do this line to get stable version
```

### Homebrew

```bash
brew install neovim # add --HEAD to install nightly (optional)
```

## Usage

Clone the repository and install the plugins:

```bash
# this will not override any current neovim configuration files
git clone git@github.com:n-crespo/nvim-config ~/.config/n-crespo/nvim-config
#                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#             change this install path to ~/.config/nvim to override current config
NVIM_APPNAME=n-crespo/nvim-config/ nvim --headless +"Lazy! sync" +qa
```

Open Neovim (if using custom install path):

```bash
NVIM_APPNAME=n-crespo/nvim-config/ nvim
```
