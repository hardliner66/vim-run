function! s:saveRun(cmd)
    execute ":w"
    execute ":AsyncRun -raw ".a:cmd
endf

function! vimRun#Run()
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
            call s:saveRun(cmd)
            return 0
        endif

        let i += 1
    endwhile

    " if no explicitly set RUN was found, run something depending on syntax
    let filetype = &filetype
    if filetype == "nim"
        call s:saveRun("nim c -r %")
    elseif filetype == "python"
        call s:saveRun("python %")
    elseif filetype == "php"
        call s:saveRun("php %")
    elseif filetype == "html"
        call s:saveRun("chromium %")
    elseif filetype == "go"
        " check if file ends with `_test`
        if expand("%:r") =~ "_test"
            let l:currentTag = tagbar#currenttag('[%s] ','')[1:-5]
            call s:saveRun("go test -run " . l:currentTag)
        else
            call s:saveRun("go run %")
        endif
    elseif filetype == "elixir"
        call s:saveRun("elixir %")
    elseif filetype == "groovy"
        call s:saveRun("groovy %")
    elseif filetype == "perl"
        call s:saveRun("perl %")
    elseif filetype == "javascript"
        call s:saveRun("node %")
    else
        call s:saveRun("./%")
    endif
endf
