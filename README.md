![image](./images/image.png)

My Neovim configuration based on the [LazyVim](https://www.lazyvim.org)
distribution, with custom features to extend or remove functionality.

Comes in two varieties:

- `lite` (default)
- `full` (fully featured, enables support for more languages)

> Set the environment variable `NVIM_FULL_CONFIG=1` to switch to the full config.

## Cool Things

- my [keymaps](./lua/config/keymaps.lua)
  - `<CR>`: follow links/toggle checkboxes, includes `gf`, `gx` functionality
  - `<S-CR>` follow link in new tab
  - `B`, `E`: wrap-friendly version of `0` and `$`
  - `<C-l>`: auto-fix last spelling error in insert mode
  - `<C-S-C>`: show word/char count
  - `<C-S-S>`: clean `^M` (Windows artifacts)
- [my auto commands](./lua/config/autocmds.lua)
  - remove trailing whitespace on save
  - cursor line in active window only
  - auto save without formatting
- [nvim-spider](./lua/plugins/spider.lua): `w`, `e`, and `b` motions
- my custom [color scheme](./colors/macro.lua) (borrowed/extended)
- my [snacks.picker](./lua/plugins/picker.lua) integration with zoxide
- my custom [lualine](./lua/plugins/lualine.lua)
- [mini.files](./lua/plugins/mini-files.lua)
- ~31ms startup time

## Install

```bash
brew install neovim # add --HEAD to install nightly (optional)
```

### Dependencies

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

## Usage

Clone the repository and install the plugins:

```bash
# will not override current config
git clone git@github.com:n-crespo/nvim-config ~/.config/n-crespo/nvim-config
#                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#                           change this path to ~/.config/nvim to override current config
NVIM_APPNAME=n-crespo/nvim-config/ nvim --headless +"Lazy! sync" +qa
```

Open Neovim (if using custom install path):

```bash
NVIM_APPNAME=n-crespo/nvim-config/ nvim
```
