# Vim Run
Checks if one of the first lines contains a the string `[RUN]` and executes whats comes after that.

# Usage
The plugin provides the command VRun in order to exectue the `[RUN]` section

C Example:
```c
// [RUN] gcc % && ./a.out
#include <stdio.h>

int main() {
    printf("Hello world!");
}
```

This can be bound to whatever you like. For example:
```vim
nnoremap <silent><leader>r :VRun<cr>
nnoremap <silent><leader>ra :VRun<Asynccr>
```

# Settings

The async function depends on: [skywind3000/asyncrun.vim](https://github.com/skywind3000/asyncrun.vim)

In case of the async function the output will be sent to the quickfix windows. (`:copen`)
