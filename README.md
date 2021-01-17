# Vim Run
Checks if one of the first lines contains a the string `[RUN]` and executes whats comes after that.

# Usage
The plugin provides the command VRun in order to exectue the `[RUN]` section

This can be bound to whatever you like. For example:
```vim
nnoremap <silent><leader>r
```

# Settings

If you have [skywind3000/asyncrun.vim](https://github.com/skywind3000/asyncrun.vim)
installed you can use the following to make use of it.

```vim
let g:use_async_vrun = 1
```

In that case the output will be sent to the quickfix windows. (`:copen`)
