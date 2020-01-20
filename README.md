# minimd

A [Markdown](https://commonmark.org/) syntax and filetype plugin for Vim which aims to make writing and outlining pleasant.

- Jumping between and folding headers is fast
- There isn't very much highlighting
- Complete lack of configurability
- The complexity of this plugin is strictly limited by my unwillingness to become skilled at Vimscript

## Usage

| Key         | Action                                 |
| ----------- | -------------------------------------- |
| `Space`     | Fold or unfold current header (alias   |
|             | for `za`---see `:h folding`)           |
| `Tab`       | Next header                            |
| `Shift-Tab` | Previous header                        |
| `=`         | Promote header                         |
| `-`         | Demote header                          |
| `Enter`     | Add a checkbox to bulleted or numbered |
|             | list items, then toggle the checkboxes |
|             | between `[ ]` and `[X]`                |

## Pandoc Integration

#### Keybindings

| Key            | Action                                         |
| -------------- | ---------------------------------------------- |
| `<Leader>html` | Export to `out.html` in the current directory. |
| `<Leader>pdf`  | Export to `out.pdf` in the current directory.  |

#### Pandoc Options

Options can be passed to Pandoc, both globally and per-filetype, by defining `g:pandoc_options`, `g:pandoc_options_html`, or `g:pandoc_options_latex` in your `vimrc`.  Options are additive; all `g:pandoc_options` and `g:pandoc_options_html` options will be used when exporting to HTML.  So, for example, if you wanted to number your headers and use your very favorite bibliography, you might include the line

    let g:pandoc_options = "-N --bibliography=~/my.bib"

in your `vimrc`.

## To Do

- [ ] Skip comments in code blocks when navigating and folding
- [ ] Revise the Pandoc interface so that it does not leave me feeling quite so dissatisfied
