" Highlight common types
syntax keyword Type shared_ptr
syntax keyword Type string
syntax keyword Type unique_ptr
syntax keyword Type vector

" Define simple highlight groups
syntax match cCustomParen "(" contains=cParen contains=cCppParen

" Highlight function names
syntax match cCustomFunc "\w\+\s*(\@=" contains=cCustomParen
highlight link cCustomFunc Function

" Highlight class and namespace scope
syntax match cCustomScope "\w\+\s*::"me=e-2 contains=cCustomColon
highlight link cCustomScope Constant
