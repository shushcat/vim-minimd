# minimd

Minimd is a small plugin for writing long [Markdown](https://commonmark.org/) documents in Vim.  It is mostly a simple implementation of the header visibility cycling idea from [Org Mode](https://orgmode.org/) for Emacs, which makes it easy to keep track of the contents of long documents by displaying outlines based on the headlines in those documents.

- Section folding uses Vim's `foldmethod=manual` to fold by section, so is fast even for very long documents.
- Unfolded headers are displayed as outlines of their contents.
- Header motion commands ignore comments in code blocks.
- Basic task management with checkbox toggling.
- A fast word count function that shows its results in the status line.

## Demonstration

![](http://johnob.sdf.org/resources/minimd_demo.gif)

## Usage

 | Normal Mode Key    | Action                                 | 
 | ---------------    | -------------------------------------- | 
 | `Space`            | Fold or unfold the current header.     | 
 | `Tab` or `]`       | Jump to next header.                   | 
 | `Shift-Tab` or `[` | Jump to previous header.               | 
 | `=`                | Promote header (`#` → `##`).           | 
 | `-`                | Demote header (`##` → `#`).            | 
 | `Enter`            | Add and toggle checkboxes in lists     | 
 |                    | (`-` → `- [ ]` → `- [x]` → `- [ ]`).   | 

To execute any command from Insert mode, prefix it with `Ctrl-o`; so, for example, you would toggle a checkbox without leaving Insert mode by typing `Ctrl-o` followed by `Enter`.  For more on executing a single Normal mode command from Insert mode, consult Vim's help: `:help i_CTRL-o`.

## Exporting with Pandoc

If you would like to export your Markdown file to another format, [Pandoc](https://pandoc.org/) can probably do what you want; you can easily set keybindings to facilitate repeated exports.  For instance, the sequence `<Leader>ep` can be set to export a PDF of the current Markdown file by adding the line `autocmd FileType minimd nmap <Leader>ep :!pandoc -f markdown -o example.pdf '%'` to your `vimrc`.  See [the Pandoc manual](https://pandoc.org/MANUAL.html) for an overview of its many options.
