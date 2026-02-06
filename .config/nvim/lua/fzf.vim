au User VeryLazy lua require('fzf-lua').setup( { 'fzf-native', })

au User VeryLazy FzfLua setup_fzfvim_cmds
au User VeryLazy FzfLua register_ui_select

" FZF Keymaps
nmap <silent> <leader><space> :Files<Cr>
nmap <leader>fa :FzfLua builtin<Cr>
nmap <silent> <leader>/ :RG<Cr>
nmap <silent> <leader>, :Buffers<Cr>
nmap <silent> <leader>bl :BLines<Cr>
