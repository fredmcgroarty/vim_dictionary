" Test lookup for first and last entries.

" Load auxiliary code.
source ./test_helpers_vimscript/vim_dictionary.vim

call VimDictTestWaitForServer()

let first_entry = VimDictGetNthEntry(0)
let last_entry = VimDictGetNthEntry(-1)

execute "Dictionary " . first_entry
execute "Dictionary " . last_entry

sleep 15000 m

call assert_true(bufexists('vim_dictionary-scratch'))

call VimDictClose()

call VimDictFinishTest()
