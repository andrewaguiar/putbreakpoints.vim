command! -bar -nargs=? PutBreakPoint
      \ call s:PutBreakPoint() |

function! s:PutBreakPoint() abort
  :read ! $HOME/.config/nvim/plugged/putbreakpoints/plugin/putbreakpoints.sh %
  execute "norm =="
endfunction

map <Leader>p :PutBreakPoint()<CR>
