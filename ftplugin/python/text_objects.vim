" vim:fdm=marker
"
" Location: ftplugin/objects.vim
" Author: Pascal Lalancette (okcompute@icloud.com)

onoremap <buffer> C  :<C-U>call python#text_objects#select_a_class()<CR>
onoremap <buffer> aC :<C-U>call python#text_objects#select_a_class()<CR>
onoremap <buffer> iC :<C-U>call python#text_objects#select_inner_class()<CR>

vnoremap <buffer> aC :<C-U>call python#text_objects#select_a_class()<CR>
vnoremap <buffer> iC :<C-U>call python#text_objects#select_inner_class()<CR>

onoremap <buffer> M  :<C-U>call python#text_objects#select_a_method()<CR>
onoremap <buffer> aM :<C-U>call python#text_objects#select_a_method()<CR>
onoremap <buffer> iM :<C-U>call python#text_objects#select_inner_method()<CR>

vnoremap <buffer> aM :<C-U>call python#text_objects#select_a_method()<CR>
vnoremap <buffer> iM :<C-U>call python#text_objects#select_inner_method()<CR>

