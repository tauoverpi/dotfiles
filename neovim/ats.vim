if exists("b:current_syntax") && b:current_syntax == "ats"
  finish
endif

syn case match

syn keyword  atsTodo contained TODO FIXME XXX NOTE TBD
syn match    atsComment   "^#!.*" contains=@Spell
syn region   atsComment start="(\*" end="\*)" contains=@Spell,atsComment,atsTodo
syn region   atsComment start="//" skip="\\$" end="$" contains=@spell,atsComment,atsTodo
syn match    atsIdentifier "[a-zA-Z][a-zA-Z0-9_]*"
syn region   atsConstraint start="<" end=">" contains=atsIdentifier
syn keyword  atsKeyword let in end local where
syn keyword  atsKeyword fn fun fnx
syn keyword  atsKeyword overload implement extern staload
syn keyword  atsConditional if then else case
syn match    atsConditional "case+"
syn match    atsConditional "case-"
syn keyword  atsValue   val var
syn match    atsValue   "val+"
syn match    atsValue   "val-"
syn match    atsTermMetric "\.<\w*>\." contains=atsIdentifier,atsNumber,atsOperator
syn match    atsOperator "+"
syn match    atsOperator "-"
syn match    atsOperator "/"
syn match    atsOperator "\*"
syn match    atsOperator ">="
syn match    atsOperator "<="
syn match    atsOperator     "&&"
syn match    atsOperator     "<"
syn match    atsOperator     ">"
syn match    atsAnyVar       "\<_\>"
syn match    atsRefAssign ":="
syn region   atsString start=+"+ skip=+\\\\\\|\\"+ end=+"+ contains=@Spell
syn match    atsInclude "#include"
syn match    atsStaload "staload"
syn match    atsNumber        "\<-\=\d\(_\|\d\)*[l|L|n]\?\>"
syn match    atsNumber        "\<-\=0[x|X]\(\x\|_\)\+[l|L|n]\?\>"
syn match    atsNumber        "\<-\=0[o|O]\(\o\|_\)\+[l|L|n]\?\>"
syn match    atsNumber        "\<-\=0[b|B]\([01]\|_\)\+[l|L|n]\?\>"
syn match    atsFloat         "\<-\=\d\(_\|\d\)*\.\?\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"
syn match    atsTypeAnnot ":"
syn region   atsConstraint start="{" end="}" contains=atsOperator,atsNumber,atsTypeAnnot

hi def link atsComment Comment
hi def link atsFloat Float
hi def link atsNumber Number
hi def link atsConditional Conditional
hi def link atsOperator Operator
hi def link atsInclude Include
hi def link atsStaload Include
hi def link atsConstraint Macro
hi def link atsKeyword Keyword
