# minimd

## Synopsis

A markdown syntax and filetype plugin for vim which aims to make writing and outlining pleasant.

- Navigation between and manipulation of headers is fast and easy
- Only headers, list items, citations, and code are highlighted
- Minimal configuration requirements

## Usage

### Headers

#### Folding

| Key       | Action                          |
| --------- | ------------------------------- |
| `<Space>` | Fold or unfold current header   |

For more information, see `:h folding`.

#### Jumping

| Key       | Action          |
| --------- | --------------- |
| `<Tab>`   | Next header     |
| `<S-Tab>` | Previous header |

#### Promotion and Demotion

| Key |  Action        |
| --- | -------------- |
| `=` | Promote header |
| `-` | Demote header  |


### Tasks

| Key       |  Action                       |
| --------- | ----------------------------- |
| `<CR>`    | Toggle task completion status |

This works with list items written in Github Style Markdown.  Unnumbered list items are converted to tasks as in `- ` to `- [ ] `, and tasks are toggled between `- [ ] ` and `- [X] `.

### Pandoc Integration

#### Keybindings

| Key            | Action                                         |
| -------------- | ---------------------------------------------- |
| `<Leader>html` | Export to `out.html` in the current directory. |
| `<Leader>pdf`  | Export to `out.pdf` in the current directory.  |

#### Pandoc Options

Options can be passed to Pandoc, either globally or per-filetype, by defining `g:pandoc_options`, `g:pandoc_options_html`, and `g:pandoc_options_latex` in your `.vimrc`.  So, for example, if you would like to number your headers and specify a bibliography, you might write:

    let g:pandoc_options = "-N --bibliography=~/my.bib"

Where `my.bib` is a BibTeX bibliography in your home directory.
