" Highlight common types
syntax keyword Type array
syntax keyword Type deque
syntax keyword Type forward_list
syntax keyword Type function
syntax keyword Type list
syntax keyword Type map
syntax keyword Type multimap
syntax keyword Type multiset
syntax keyword Type pair
syntax keyword Type priority_queue
syntax keyword Type queue
syntax keyword Type set
syntax keyword Type shared_ptr
syntax keyword Type stack
syntax keyword Type string
syntax keyword Type unique_ptr
syntax keyword Type unordered_map
syntax keyword Type unordered_multimap
syntax keyword Type unordered_multiset
syntax keyword Type unordered_set
syntax keyword Type vector

" Define simple highlight groups
syntax match cCustomParen "(" contains=cParen contains=cCppParen

" Highlight function names
syntax match cCustomFunc "\w\+\s*(\@=" contains=cCustomParen
highlight link cCustomFunc Function

" Highlight class and namespace scope
syntax match cCustomScope "\w\+\s*::"me=e-2 contains=cCustomColon
highlight link cCustomScope Constant
