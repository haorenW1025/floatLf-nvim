# floatLf-nvim

A simple neovim plugin that make you use the amazing file manager [lf](https://github.com/gokcehan/lf) in neovim as you expected.

- Open lf in neovim floating window with all your setting available.
- Open files without nested in split or tab.

## Demo

![floatLf](./floatLf_demo.gif)


## Why lf?

- lf is a very fast and light-weighted file manager.
- Use lf in neovim can be better than using other file explorer plugins because it simply has all your bindings and also can integrate with other programs very well.
- lf can accept shell command, which makes it very easy to combine with neovim-remote to prevent opening file in nested session in neovim.

## Prerequisite

- Only support neovim(because the main control part of this plugin is written in lua)
- requires [neovim-remote](https://github.com/mhinz/neovim-remote) and make sure you can find the  `nvr` executable. Install it easily with:
```bash
pip3 install neovim-remote
```

## Install

- Install with any plugin manager by using the path on GitHub.
```Plug 'haorenW1025/floatLf-nvim'```

## Usage

- Use `:Lf_Toggle` to open lf window in floating window
- Just use your lf binding to go around and manipulate files.
- `<c-o>`, `<c-x>`, `<c-v>` and `<c-t>` in lf can open file in current window, split, vertical split and tab.
- Press `q` to quit out of lf window.

## Configuration

- By default, lf will still be open if you open any files, you can change that by
```
let g:floatLf_autoclose = 1
```

- You can change the key mapping in lf by
```
let g:floatLf_lf_close = 'q'
let g:floatLf_lf_open = '<c-o>'
let g:floatLf_lf_split = '<c-x>'
let g:floatLf_lf_vsplit = '<c-v>'
let g:floatLf_lf_tab = '<c-t>'
```
- Note that these mapping will only be mapped locally to lf buffer so it won't affect other terminal buffer.

- The floating window has no border by default, enable it by
```
let g:floatLf_border = 1
```

- Modify your border type by
```
let g:floatLf_topleft_border = "╔"
let g:floatLf_topright_border = "╗"
let g:floatLf_botleft_border = "╚"
let g:floatLf_botright_border = "╝"
let g:floatLf_vertical_border = "║"
let g:floatLf_horizontal_border = "═"
```

## Todo
- Support terminal size option.
- Maybe support other file manager?
