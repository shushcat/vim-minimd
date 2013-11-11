minimd
=======

Synopsis
---------
A markdown syntax and filetype plugin for vim which aims to make writing and outlining pleasant.  For this use case, 'pleasant' means that the following requirements must be met.

### Requirements
1. It must be easy to navigate between headers.
2. Folding must work properly. 
    - Headers must be included in folds.
3. Text must soft wrap at screen boundaries without breaking words.
4. Syntax highlighting mustn't be too garrish.
    - But headers, list items, citations, and code must be signified.
5. Where possible, Vim's defaults are to be preserved.
6. Configuration should only be required for interfacing with external tools
7. Interface well with other tools.  Not to be limited to Vim plugins.

Usage
-----

### Headers
#### Jumping
| Key        | Action           |
| ---------- | -----------------|
| `<Tab>`    | Next header.     |
| `S-<Tab>`  | Previous header. |

#### Promotion and Demotion
| Key |  Action         |
| --- | ----------------|
| `=` | Promote header. |
| `-` | Demote header.  |


### Folding (Vim Defaults)
| Key     |       Action                  |
| ------- | ----------------------------- |
| `zc`    |       Close fold.             |
| `zo`    |       Open fold.              |
| `zm`    |       Fold one more level.    |
| `zM`    |       Maximum fold-level.     |
| `zr`    |       Reveal one fold level.  |
| `zR`    |       Reveal all fold levels. |

### Pandoc Export
| Key            | Action                                        |
| -------------- | --------------------------------------------- |
| `<Leader>html` | Export to `out.html` in the parent directory. |
| `<Leader>pdf`  | Export to `out.pdf` in the parent directory.  |
