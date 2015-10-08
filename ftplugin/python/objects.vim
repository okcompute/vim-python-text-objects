" vim:fdm=marker
"
" Location: ftplugin/objects.vim
" Author: Pascal Lalancette (okcompute@icloud.com)

onoremap <buffer> C  :<C-U>call objects#select_a_class()<CR>
onoremap <buffer> aC :<C-U>call objects#select_a_class()<CR>
onoremap <buffer> iC :<C-U>call objects#selec_inner_classt()<CR>

vnoremap <buffer> aC :<C-U>call objects#selec_a_classt()<CR>
vnoremap <buffer> iC :<C-U>call objects#selec_inner_classt()<CR>

onoremap <buffer> M  :<C-U>call objects#select_a_method()<CR>
onoremap <buffer> aM :<C-U>call objects#select_a_method()<CR>
onoremap <buffer> iM :<C-U>call objects#select_inner_method()<CR>

vnoremap <buffer> aM :<C-U>call objects#select_a_method()<CR>
vnoremap <buffer> iM :<C-U>call objects#select_inner_method()<CR>

