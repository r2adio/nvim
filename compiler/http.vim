" compiler/kulala-fmt.vim

if exists("current_compiler")
  finish
endif
let current_compiler = "kulala-fmt"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

" Check the current HTTP file.
CompilerSet makeprg=kulala-fmt\ check\ %

" One quickfix entry per file needing formatting.
CompilerSet errorformat=File\ not\ pretty:\ %f

" Ignore the unified diff output.
CompilerSet errorformat+=%-G---\ %f
CompilerSet errorformat+=%-G+++\ %f
CompilerSet errorformat+=%-G@@\ %.%#
CompilerSet errorformat+=%-G~%.%#
CompilerSet errorformat+=%-G%.%#
