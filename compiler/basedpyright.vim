if exists("current_compiler")
  finish
endif
let current_compiler = "basedpyright"

CompilerSet makeprg=basedpyright

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=%f:%l:%c\ -\ %t%*[^:]:\ %m
CompilerSet errorformat+=%f:%l:%c\ -\ %m
