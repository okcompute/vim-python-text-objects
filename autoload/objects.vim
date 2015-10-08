" vim:fdm=marker
"
" Location: autoload/objects.vim
" Author: Pascal Lalancette (okcompute@icloud.com)


" Patterns {{{

let s:class_pattern = '^\s*class\s'
let s:method_pattern = '^\s*def\s'
let s:closing_pattern = '^\s*):'

" }}}

"{{{

" Select a text object (class or method).
function! s:select(pattern, ...)
    let inner = a:0 ? a:1 =~ 'inner' : 0
    let repeats = v:count1 - 1
    let origin = getpos('.')[1:2]
    let start = s:object_start(origin[0], a:pattern, inner)
    let end = s:object_end(start, indent(start))
    while repeats
        let line_number = search(a:pattern, 'nW')
        if line_number
            let end = s:object_end(line_number, indent(line_number))
            call cursor(end, 1)
        endif
        let repeats = repeats - 1
    endwhile
    if !s:validate_selection(origin[0], start, end)
        echo "Cannot select text object!"
        return
    endif
    if inner
        while start <= (end - 1)
            let line = getline(start)
            let start = start + 1
            if line =~ '^.*):$'  " Function or class ending marker
                break
            endif
        endwhile
        let end = prevnonblank(end)
    endif
    call cursor(start, 1)
    normal! v
    call cursor(end, len(getline(end)))
endfunction

" Compute text object start line number.
function! s:object_start(line_number, pattern, inner)
    let line_number = a:line_number + 1
    let lowest_indent = 100
    while line_number
        let line_number = prevnonblank(line_number - 1)
        let indent = indent(line_number)
        let line = getline(line_number)
        if line =~ '^\s*#' " Skip comments
            continue
        elseif line =~ '^\s*):'  " Skip function or class closing parenthesis
            continue
        elseif indent >= lowest_indent " Skip deeper or equal lines
            continue
        elseif line =~ '^\s*@' " Skip decorators (TODO: include them!)
            continue
        " Indent is strictly less at this point: check for def/class
        elseif line =~ a:pattern
            if !a:inner
                while 1
                    let previous = prevnonblank(line_number - 1)
                    if getline(previous) =~ '^\s*@'
                        let line_number = previous
                    else
                        break
                    endif
                endwhile
            endif
            return line_number
        endif
        let lowest_indent = indent(line_number)
    endwhile
    return 0
endfunction


" Compute text object end line number.
function! s:object_end(line_number, indent)
    let line_number = a:line_number
    " Skip decorators
    while 1
        if getline(line_number) =~ '^\s*@'
            let line_number = nextnonblank(line_number + 1)
        else
            break
        endif
    endwhile
    while line_number
        let line_number = nextnonblank(line_number + 1)
        if getline(line_number) =~ '^\s*#' | continue
        elseif getline(line_number) =~ s:closing_pattern | continue
        elseif line_number && indent(line_number) <= a:indent
            return line_number - 1
        endif
    endwhile
    return line('$')
endfunction

" Validate the selection is surrounding the cursor position (origin).
function! s:validate_selection(origin, selection_start, selection_end)
    if a:selection_start <= a:origin && a:selection_end >= a:origin
        return 1
    endif
    return 0
endfunction

"}}}

" {{{

function! objects#select_inner_class()
    call s:select(s:class_pattern, 'inner')
endfunction

function! objects#select_a_class()
    call s:select(s:class_pattern)
endfunction

function! objects#select_inner_method()
    call s:select(s:method_pattern, 'inner')
endfunction

function! objects#select_a_method()
    call s:select(s:method_pattern)
endfunction

"}}}
