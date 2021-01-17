" File: vim-run.vim
" Last Modified: 2021-01-12
" Version: 0.0.1
" Description: Vim Run -- allows putting start command as command in the top
" of the file
" Website: 
" Author: Steve Biedermann
" License: MIT + Apache 2.0

function! vimRun#saveRun(cmd)
    execute ":w"
    execute ":AsyncRun -raw ".a:cmd
endf

function! vimRun#run()
    " stop already potential running process
    if g:asyncrun_status == "running"
        execute ":AsyncStop!"
        " for it to quit
        while g:asyncrun_status == "running"
            sleep 200m
        endwhile
    endif

    " RUN lines always take priority
    let i = 0
    while i < 22
        let line=getline(i)
        let induceResult=matchlist(line, '^\A\+\[RUN\]\s*\(.*\)') " regex: start-of-string, one-and-more-non-alphabetic-chars,[RUN],any-whitespaces,group-0-any
        if !empty(induceResult)
            let cmd = get(induceResult, 1)
            call vimRun#saveRun(cmd)
            return 0
        endif

        let i += 1
    endwhile

    " if no explicitly set RUN was found, run something depending on syntax
    let filetype = &filetype
    if filetype == "nim"
        call vimRun#saveRun("nim c -r %")
    elseif filetype == "python"
        call vimRun#saveRun("python %")
    elseif filetype == "php"
        call vimRun#saveRun("php %")
    elseif filetype == "html"
        call vimRun#saveRun("chromium %")
    elseif filetype == "go"
        " check if file ends with `_test`
        if expand("%:r") =~ "_test"
            let l:currentTag = tagbar#currenttag('[%s] ','')[1:-5]
            call vimRun#saveRun("go test -run " . l:currentTag)
        else
            call vimRun#saveRun("go run %")
        endif
    elseif filetype == "elixir"
        call vimRun#saveRun("elixir %")
    elseif filetype == "groovy"
        call vimRun#saveRun("groovy %")
    elseif filetype == "perl"
        call vimRun#saveRun("perl %")
    elseif filetype == "javascript"
        call vimRun#saveRun("node %")
    else
        call vimRun#saveRun("./%")
    endif
endf

command! VRun call vimRun#run()
