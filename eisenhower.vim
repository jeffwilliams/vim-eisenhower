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
  execute 'edit ' s:todo_dir . 'not_important_not_urgent.md'

  " Move Left
  wincmd h
  execute 'edit ' s:todo_dir . 'urgent_not_important.md'

  set statusline=%{SetStatusline()}
endfunction

command! Eisenhower :call Eisenhower()

"call Eisenhower()
