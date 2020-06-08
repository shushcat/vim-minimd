# minimd

A [Markdown](https://commonmark.org/) syntax and filetype plugin for Vim that aims to make writing and outlining pleasant.

- Section folding is manual, but is based on syntax, so is fast even for large files.
- Header navigation is also based on syntax so avoids problems such as mistakenly jumping to comments in code blocks.
- The complexity and configurability of this plugin are both strictly limited by my reluctance to learn Vimscript.

## Usage

| Key         | Action                                 |
| ----------- | -------------------------------------- |
| `Space`     | Fold or unfold the current header.     |
| `Tab`       | Jump to next header.                   |
| `Shift-Tab` | Jump to previous header.               |
| `=`         | Promote header (`#` → `##`).           |
| `-`         | Demote header (`##` → `#`).            |
| `Enter`     | Add and toggle checkboxes in lists     |
|             | (`-` → `- [ ]` → `- [X]` → `- [ ]`).   |

## Exporting with Pandoc

If you would like to export your Markdown file to another format, [Pandoc](https://pandoc.org/) can probably do what you want; you can easily set keybindings to facilitate repeated exports.  For instance, the sequence `<Leader>ep` can be set to export a PDF of the current Markdown file by adding the line `autocmd FileType minimd nmap <Leader>ep :!pandoc -f markdown -o example.pdf '%'` to your `vimrc`.  See [the Pandoc manual](https://pandoc.org/MANUAL.html) for an overview of its many options.

## To Do

- [ ] Make sure settings, including those for the status line, don't leak
- [ ] Conditionally trigger `syntax sync fromstart`
