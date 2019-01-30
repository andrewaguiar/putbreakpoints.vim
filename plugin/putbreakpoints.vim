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
  else
    return ""
  endif
endfunction

command! -bar -nargs=? PutBreakPoint
      \ call s:PutBreakPoint() |

function! s:PutBreakPoint() abort
  let l:break_point = s:BreakPointString()

  if l:break_point != ""
    :put =l:break_point
    execute ("norm ==")
  else
    echo 'no breakpoint found for file type!'
  endif
endfunction

map <Leader>p :PutBreakPoint()<CR>
