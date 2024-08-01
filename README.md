# minimd

Minimd is a Vim plugin that helps with writing long [Markdown](https://commonmark.org/) documents by folding sections and showing outlines of their contents.

The basic idea is that pressing spacebar on an _unfolded_ level 1 header will fold that header, while pressing spacebar on a _folded_ level 1 header will both unfold it and fold all the level 2 headers it contains.  If you fold then unfold a level 3 header, any level 4 headers are folded, and so on.  Pressing a number followed by the spacebar folds all headers of that number, which is an outline.

Minimd also has a few other features to make working with long documents easier:

- Header motion command that ignore code blocks (so don't mistake `#` comments for headers);
- Minimal syntax highlighting (headers, code blocks, square brackets, checkboxes, and the task markers `ACTV`, `TODO`, `WAIT`, `CNCL`, and `DONE`) so as not to be too distracting and to speed up the folding a bit
- Shortcuts to simultaneously change the levels of all headers within a fold

## Demonstration

![](http://johnob.sdf.org/resources/minimd_demo.gif)

## Usage

| Normal mode key              | Action                                      | 
| ---------------              | ------                                      | 
| `Space`                      | Fold or unfold the current header.          | 
| _n_`Space`                   | Fold all headers of level _n_.              | 
| `Tab` or `]h`                | Jump to next header.                        | 
| _n_`Tab` or _n_`]h`          | Jump to next header of level _n_.           | 
| `Shift-Tab` or `[h`          | Jump to previous header.                    | 
| _n_`Shift-Tab` or _n_`[h`    | Jump to previous header of level _n_.       | 
| `=`                          | Promote header (`#` → `##`).                | 
| `-`                          | Demote header (`##` → `#`).                 | 
| `Enter`                      | Add and toggle checkboxes in lists          | 
|                              | (`-` → `- [ ]` → `- [x]` → `- [ ]`),        | 
|                              | or cycle between headline states            | 
|                              | (`#` → `# TODO` → `# DONE` → `#`).          | 
| `Escape Enter`               | Cycle between additional headline states    | 
|                              | (`#` → `# TODO` → `# ACTV` → `# WAIT`       | 
|                              | `# CNCL` → `# DONE` → `#`).                 | 

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

Note that, according to `:help v:count`, the mappings for `MiniMDToggleFold`, `MiniMDNext`, and `MiniMDPrev` must be prefixed with `<C-u>` in order for the functions wrapped by those commands to accept numeric arguments.  So if, e.g., you wanted to map the folding command to `z`, you would add a line like the following to your `.vimrc`:

    nmap z :<C-u>MiniMDToggleFold<CR>

## Exporting Files

Exports to other file types are best done with [Pandoc](https://pandoc.org) since Minimd strictly adheres to a subset of the overlap between [Pandoc's Markdown syntax](https://pandoc.org/MANUAL.html#pandocs-markdown) and [the Commonmark specification](https://spec.commonmark.org/).

You can easily set keybindings to facilitate repeated exports.  For instance, the sequence `<Leader>ep` could be set to export a PDF of the current Markdown file by adding the line `autocmd FileType minimd nmap <Leader>ep :!pandoc -f markdown -o example.pdf '%'` to your `vimrc`.  See [the Pandoc manual](https://pandoc.org/MANUAL.html) for an overview of its many options.

## Related Projects

Minimd started out as an implementation of the header visibility cycling idea from [Org Mode](https://orgmode.org/) (and of [Outline Mode](https://www.gnu.org/software/emacs/manual/html_node/emacs/Outline-Mode.html) before that) for Emacs.  If you use Emacs, you should probably use one of those, and it should probably be Org Mode.
