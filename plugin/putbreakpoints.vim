function! s:UsingPry() abort
  if (filereadable("Gemfile"))
    return system("cat Gemfile|grep pry-|wc -l") > 0
  else
    return 0
  end
endfunction

function! s:BreakPointString() abort
  if (&ft == 'elixir')
    return "require IEx; IEx.pry"

  elseif (&ft == 'eelixir')
    return "<% require IEx; IEx.pry %>"

  elseif (&ft == 'javascript.jsx')
    return "debugger"

  elseif (&ft == 'ruby')
    if (s:UsingPry() == 1)
      return "(require 'pry'; binding.pry)"
    else
      return "byebug"
    endif

  elseif (&ft == 'eruby')
    if (s:UsingPry() == 1)
      return "<% (require 'pry'; binding.pry) %>"
    else
      return "<% byebug %>"
    endif

  endif
endfunction

command! -bar -nargs=? PutBreakPoint
      \ call s:PutBreakPoint() |

function! s:PutBreakPoint() abort
  let break_point = s:BreakPointString()
  if (break_point != 0)
    :put =break_point
    execute ("norm ==")
  endif
endfunction

map <Leader>p :PutBreakPoint()<CR>
