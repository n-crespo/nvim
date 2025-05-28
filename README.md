![image](./images/image.png)

# Neovim Configuration

<details>
  <summary> Table of Contents</summary>

<!--toc:start-->
- [Neovim Configuration](#neovim-configuration)
  - [Cool Things](#cool-things)
  - [Dependencies](#dependencies)
  - [Install](#install)
    - [Homebrew](#homebrew)
  - [Usage](#usage)
<!--toc:end-->

</details>

My Neovim configuration based on the [LazyVim](https://www.lazyvim.org)
distribution, with custom features to extend or remove functionality.

Comes in two varieties:

- `lite` (default).
- `main` (fully featured, enables support for more languages)

> Set the environment variable `NVIM_MAIN_CONFIG = 1` to switch to the main config.

## Cool Things

- my [keymaps](./lua/config/keymaps.lua)
  - `<CR>`: follow links/toggle checkboxes, includes `gf`, `gx` functionality
  - `<S-CR>` follow link in new tab
  - `B`, `E`: wrap friendly version of `0` and `$`
  - `<C-l>`: auto fix last spelling error in insert mode
  - `<C-S-C>`: show word/char count
  - `<C-S-S>`: clean `^M` (Windows artifacts)
- [my auto commands](./lua/config/autocmds.lua)
  - remove trailing white space on save
  - cursor line in active window only
  - auto save without formatting
- [nvim-spider](./lua/plugins/spider.lua): `w`, `e`, and `b` motions
- my custom [color scheme](./colors/macro.lua) (borrowed/extended)
- my snacks.nvim [picker](./lua/plugins/picker.lua) integration with zoxide
- my custom [lualine](./lua/plugins/lualine.lua)
- [mini.files](./lua/plugins/mini-files.lua)
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

```bash
sudo apt-get install -y neovim
sudo apt-get install python3-neovim
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
