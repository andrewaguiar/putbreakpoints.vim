# PutBreakPoints

Use `:PutBreakPoint` or `<Leader>p` to insert a breakpoint according the file type and some other particulars 
in the current project

## Languages

### Ruby

Inserts a `byebug` if Gemfile does not have any `pry` related gem, (`rb`, `rake`, `html.erb` files)
Inserts a `(require 'pry'; binding.pry)` if Gemfile DO have any `pry` related gem, (`rb`, `rake`, `html.erb` files)

### Elixir

Inserts a `require 'IEX; IE.pry` (`ex`, `exs`, `html.eex` files)

### Javascript

Inserts a `debugger` (`js`, `jsx` files)

### Other comming soon!
