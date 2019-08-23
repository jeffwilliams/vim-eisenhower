" Set this to the directory that will contain the TODO list
let s:todo_dir='~/todo/'


function! SetStatusline()
  let l:filename = expand('%:t:r')
  if l:filename ==# "urgent_and_important"
    return 'Urgent and Important. Do it now.'
  elseif l:filename ==# "important_not_urgent"
    return 'Important, not Urgent. Decide or Schedule it.'
  elseif l:filename ==# "urgent_not_important"
    return 'Urgent, not Important. Delegate.'
  elseif l:filename ==# "not_important_not_urgent"
    return 'Not Important or Urgent. Delete.'
  else
    return @%
  endif
endfunction

" Close all windows and open the Eisenhower matrix files
function! Eisenhower()
  " Close all other windows
  new
  only


  split
  vertical split
  wincmd b
  vertical split

  " Move to top left
  wincmd t
  "e ~/todo/urgent_and_important.md
  execute 'edit ' s:todo_dir . 'urgent_and_important.md'

  " Move right
  wincmd l
  execute 'edit ' s:todo_dir . 'important_not_urgent.md'

  " Move to bottom right
  wincmd b
  execute 'edit ' s:todo_dir . 'not_important_and_not_urgent.md'

  " Move Left
  wincmd h
  execute 'edit ' s:todo_dir . 'urgent_not_important.md'

  set statusline=%{SetStatusline()}
endfunction

command! Eisenhower :call Eisenhower()

function! EisenhowerOpenSingle(num)
  " Close all other windows
  new
  only

  if a:num ==# "1"
    execute 'edit ' s:todo_dir . 'urgent_and_important.md'
  elseif a:num ==# "2"
    execute 'edit ' s:todo_dir . 'important_not_urgent.md'
  elseif a:num ==# "3"
    execute 'edit ' s:todo_dir . 'not_important_and_not_urgent.md'
  elseif a:num ==# "4"
    execute 'edit ' s:todo_dir . 'urgent_not_important.md'
  endif
endfunction

autocmd! * *urgent_and_important.md
autocmd! * *important_not_urgent.md
autocmd! * *urgent_not_important.md
autocmd! * *not_important_and_not_urgent.md
autocmd BufNewFile *urgent_and_important.md :call append(line('^'), ['# Urgent and Important. Do it now.'])
autocmd BufNewFile *important_not_urgent.md :call append(line('^'), ['# Important, not Urgent. Decide or Schedule it.'])
autocmd BufNewFile *urgent_not_important.md :call append(line('^'), ['# Urgent, not Important. Delegate.'])
autocmd BufNewFile *not_important_and_not_urgent.md :call append(line('^'), ['# Not Important or Urgent. Delete.'])

:nmap <Leader>1 :call EisenhowerOpenSingle('1')<CR>
:nmap <Leader>2 :call EisenhowerOpenSingle('2')<CR>
:nmap <Leader>3 :call EisenhowerOpenSingle('3')<CR>
:nmap <Leader>4 :call EisenhowerOpenSingle('4')<CR>

