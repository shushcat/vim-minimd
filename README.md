# minimd

Minimd is a small plugin for writing long [Markdown](https://commonmark.org/) documents in Vim.  It is mostly a simple implementation of the header visibility cycling idea from [Org Mode](https://orgmode.org/) for Emacs, which makes it easy to keep track of the contents of long documents by displaying outlines based on the headlines in those documents.  Its main features are

- Fast section folding, even for very long documents;
- Display of unfolded headers as outlines of their contents;
- A header motion command that ignores code blocks (so doesn't mistake `#` comments for headers);
- Basic task management with checkbox toggling, along with `ACTV`, `TODO`, and `DONE` keywords;
- A word count, from Vim's fast builtin `wordcount()` function, in the status line, set to update only when toggling between insert and normal modes.

## Demonstration

![](http://johnob.sdf.org/resources/minimd_demo.gif)

## Usage

| Normal Mode Key            | Action                                 | 
| ---------------            | ------                                 | 
| `Space`                    | Fold or unfold the current header.     | 
| _n_`Space`                 | Fold all headers of level _n_.         | 
| `Tab` or `]h`              | Jump to next header.                   | 
| _n_`Tab` or _n_`]h`        | Jump to next header of level _n_.      | 
| `Shift-Tab` or `[h`        | Jump to previous header.               | 
| _n_`Shift-Tab` or _n_`[h`  | Jump to previous header of level _n_.  | 
| `=`                        | Promote header (`#` → `##`).           | 
| `-`                        | Demote header (`##` → `#`).            | 
| `Enter`                    | Add and toggle checkboxes in lists     | 
|                            | (`-` → `- [ ]` → `- [x]` → `- [ ]`).   | 

The header promotion and demotion commands act on all enclosed headers when invoked on a fold.

As always in Vim, you can execute any command from Insert mode by prefixing it with `Ctrl-o`; so, for example, you would toggle a checkbox without leaving Insert mode by typing `Ctrl-o` followed by `Enter`.  For more on executing Normal mode commands from Insert mode, consult `:help i_CTRL-o`.

### Customization

This plugin can be used with [Vim's default Markdown syntax](https://github.com/tpope/vim-markdown) by adding the line `let g:default_markdown_syntax = 1` to your `vimrc`.

The default mappings for this plugin's folding, motion, header promotion and demotion, and task toggling commands are as follows.

    nmap <silent><buffer> <Space> :<C-u>MiniMDToggleFold<CR>
    nmap <silent><buffer> <Tab> :<C-u>MiniMDNext<CR>
    nmap <silent><buffer> <S-Tab> :<C-u>MiniMDPrev<CR>
    nmap <silent><buffer> ]h :<C-u>MiniMDNext<CR>
    nmap <silent><buffer> [h :<C-u>MiniMDPrev<CR>
    nnoremap <silent><buffer> = :MiniMDPromote<CR>
    nnoremap <silent><buffer> - :MiniMDDemote<CR>
    nmap <silent><buffer> <CR> :MiniMDTaskToggle<CR>
    vmap <silent><buffer> <CR> :MiniMDTaskToggle<CR>

Note that, according to `:help v:count`, the mappings for `MiniMDToggleFold`, `MiniMDNext`, and `MiniMDPrev` must be prefixed with `<C-u>` in order for the functions wrapped by those commands to accept numeric arguments.  So if, e.g., you wanted to add another mapping for the folding command, you would do so with a line like the following:

    nmap z :<C-u>MiniMDToggleFold<CR>

## Exporting with Pandoc

If you would like to export your Markdown file to another format, [Pandoc](https://pandoc.org/) can probably do what you want; you can easily set keybindings to facilitate repeated exports.  For instance, the sequence `<Leader>ep` could be set to export a PDF of the current Markdown file by adding the line `autocmd FileType minimd nmap <Leader>ep :!pandoc -f markdown -o example.pdf '%'` to your `vimrc`.  See [the Pandoc manual](https://pandoc.org/MANUAL.html) for an overview of its many options.
