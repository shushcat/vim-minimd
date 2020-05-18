# minimd

A [Markdown](https://commonmark.org/) syntax and filetype plugin for Vim that aims to make writing and outlining pleasant.

- Jumping between and folding headers is fast
- There isn't very much highlighting
- Complete lack of configurability
- The complexity of this plugin is strictly limited by my reluctance to learn Vimscript

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

## Exporting with Pandoc

If you would like to export your Markdown file in another format, [Pandoc](https://pandoc.org/) can probably do what you want; you can easily set keybindings to facilitate repeated exports.  For instance, the sequence `<Leader>ep` can be set to export a PDF of the current Markdown file by adding the line `autocmd FileType minimd nmap <Leader>ep :!pandoc -f markdown -o example.pdf '%'` to your `vimrc`.  See [the Pandoc manual](https://pandoc.org/MANUAL.html) for an overview of its many options.

## To Do

- [ ] Skip comments in code blocks when navigating and folding
- [ ] Non-greedy link highlights for multiple links on a single line
