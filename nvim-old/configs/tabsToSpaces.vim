function! TabsTo2Spaces()
    set tabstop=2 softtabstop=0 expandtab shiftwidth=2
    %retab!
endfunction

function! TabsTo4Spaces()
    set tabstop=4 softtabstop=0 expandtab shiftwidth=4
    %retab!
endfunction

function! TabsToSpaces(width)
    if a:width == 4
        call TabsTo4Spaces()
    else
        call TabsTo2Spaces()
    endif
endfunction

function! SpacesToTabs2()
    set noexpandtab
    %retab!
    set tabstop=2 shiftwidth=2
endfunction

function! SpacesToTabs4()
    set noexpandtab
    %retab!
    set tabstop=4 shiftwidth=4
endfunction

function! SpacesToTabs(width)
    if a:width == 4
      call SpacesToTabs4()
    else
      call SpacesToTabs2()
    endif
endfunction

function! ConvertThenSave(name, bang, width)
    call TabsToSpaces(a:width)
    if a:bang == '!'
        execute "w!" a:name
    else
        execute "w" a:name
    endif
endfunction

command -bang -nargs=* W call ConvertThenSave(<q-args>, '<bang>', 2)
command -bang -nargs=* W4 call ConvertThenSave(<q-args>, '<bang>', 4)
command -bang -nargs=* T2 call SpacesToTabs(2)
command -bang -nargs=* T4 call SpacesToTabs(4)
command -bang -nargs=* S2 call TabsToSpaces(2)
command -bang -nargs=* S4 call TabsToSpaces(4)
