vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohlsearch<CR><ESC>', {})

-- coc系
vim.api.nvim_set_keymap('n', '<leader>d', '<Plug>(coc-definition)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>d', '<Plug>(coc-definition)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>d', '<Plug>(coc-definition)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>t', '<Plug>(coc-type-definition)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>t', '<Plug>(coc-type-definition)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>t', '<Plug>(coc-type-definition)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>c', '<Plug>(coc-declaration)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>c', '<Plug>(coc-declaration)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>c', '<Plug>(coc-declaration)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>i', '<Plug>(coc-implementation)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>i', '<Plug>(coc-implementation)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>i', '<Plug>(coc-implementation)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>r', '<Plug>(coc-references)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>r', '<Plug>(coc-references)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>r', '<Plug>(coc-references)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>re', '<Plug>(coc-rename)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>re', '<Plug>(coc-rename)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>re', '<Plug>(coc-rename)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>h', ':call CocAction(\'doHover\')<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('o', '<leader>h', ':call CocAction(\'doHover\')<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('x', '<leader>h', ':call CocAction(\'doHover\')<CR>', {silent = true, noremap = true})

-- telescope系
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fcl', '<cmd>Telescope commands<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ft', '<cmd>Telescope tags<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>Telescope command_history<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fj', '<cmd>Telescope jumplist<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>Telescope search_history<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fz', '<cmd>Telescope frecency<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fl', '<cmd>Telescope live_grep<cr>', {silent = true, noremap = true})

-- 翻訳
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(Translate)', {silent = true})
vim.api.nvim_set_keymap('v', 't', '<Plug>(VTranslate)', {silent = true})

-- タブ関連
vim.api.nvim_set_keymap('n', 'tn', '<cmd>tabnew<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('o', 'tn', '<cmd>tabnew<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('x', 'tn', '<cmd>tabnew<cr>', {silent = true, noremap = true})

vim.api.nvim_set_keymap('n', '<TAB>', ':BufferLineCycleNext<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', {silent = true, noremap = true})

-- 矩形選択
vim.api.nvim_set_keymap('n', '<Leader>v', '<C-v>', {noremap = true})
vim.api.nvim_set_keymap('x', '<Leader>v', '<C-v>', {noremap = true})
vim.api.nvim_set_keymap('o', '<Leader>v', '<C-v>', {noremap = true})

-- 全選択
vim.api.nvim_set_keymap('n', 'vv', 'G$Vgg0', {noremap = true})

-- ノーマルモードのキーマッピング
vim.api.nvim_set_keymap('n', 'dx', 'dd', {noremap = true})
vim.api.nvim_set_keymap('n', 'dd', '"_dd', {noremap = true})
vim.api.nvim_set_keymap('n', 'd', '"_d', {noremap = true})
vim.api.nvim_set_keymap('n', 'c', '"_c', {noremap = true})
vim.api.nvim_set_keymap('n', 'D', '"_D', {noremap = true})
vim.api.nvim_set_keymap('n', 'C', '"_C', {noremap = true})
vim.api.nvim_set_keymap('n', 'S', '"_S', {noremap = true})
vim.api.nvim_set_keymap('n', 's', '"_s', {noremap = true})
vim.api.nvim_set_keymap('n', 'm', '^', {noremap = true})
vim.api.nvim_set_keymap('n', '^', '+', {noremap = true})

-- ビジュアルモードのキーマッピング
vim.api.nvim_set_keymap('x', 'd', '"_d', {noremap = true})
vim.api.nvim_set_keymap('x', 'c', '"_c', {noremap = true})
vim.api.nvim_set_keymap('x', 'D', '"_D', {noremap = true})
vim.api.nvim_set_keymap('x', 'C', '"_C', {noremap = true})
vim.api.nvim_set_keymap('x', 'S', '"_S', {noremap = true})
vim.api.nvim_set_keymap('x', 's', '"_s', {noremap = true})
vim.api.nvim_set_keymap('x', 'm', '^', {noremap = true})
vim.api.nvim_set_keymap('x', '^', '+', {noremap = true})

-- オペレータモードのキーマッピング
vim.api.nvim_set_keymap('o', 'd', '"_d', {noremap = true})
vim.api.nvim_set_keymap('o', 'c', '"_c', {noremap = true})
vim.api.nvim_set_keymap('o', 'D', '"_D', {noremap = true})
vim.api.nvim_set_keymap('o', 'C', '"_C', {noremap = true})
vim.api.nvim_set_keymap('o', 'S', '"_S', {noremap = true})
vim.api.nvim_set_keymap('o', 's', '"_s', {noremap = true})
vim.api.nvim_set_keymap('o', 'm', '^', {noremap = true})
vim.api.nvim_set_keymap('o', '^', '+', {noremap = true})

-- ノーマル、ビジュアル、オペレータモードでのキーマッピング
vim.api.nvim_set_keymap('n', 'o', 'o<Esc>', {noremap = true})
vim.api.nvim_set_keymap('x', 'o', 'o<Esc>', {noremap = true})
vim.api.nvim_set_keymap('o', 'o', 'o<Esc>', {noremap = true})

vim.api.nvim_set_keymap('n', 'O', 'O<Esc>', {noremap = true})
vim.api.nvim_set_keymap('x', 'O', 'O<Esc>', {noremap = true})
vim.api.nvim_set_keymap('o', 'O', 'O<Esc>', {noremap = true})

vim.api.nvim_set_keymap('n', '(', 'i<Space><Esc>', {noremap = true})
vim.api.nvim_set_keymap('x', '(', 'i<Space><Esc>', {noremap = true})
vim.api.nvim_set_keymap('o', '(', 'i<Space><Esc>', {noremap = true})

vim.api.nvim_set_keymap('n', ')', 'a<Space><Esc>', {noremap = true})
vim.api.nvim_set_keymap('x', ')', 'a<Space><Esc>', {noremap = true})
vim.api.nvim_set_keymap('o', ')', 'a<Space><Esc>', {noremap = true})

vim.api.nvim_set_keymap('n', '<Space>', '$', {noremap = true})
vim.api.nvim_set_keymap('x', '<Space>', '$', {noremap = true})
vim.api.nvim_set_keymap('o', '<Space>', '$', {noremap = true})

vim.api.nvim_set_keymap('n', 'J', '10j', {noremap = true})
vim.api.nvim_set_keymap('x', 'J', '10j', {noremap = true})
vim.api.nvim_set_keymap('o', 'J', '10j', {noremap = true})

vim.api.nvim_set_keymap('n', 'K', '10k', {noremap = true})
vim.api.nvim_set_keymap('x', 'K', '10k', {noremap = true})
vim.api.nvim_set_keymap('o', 'K', '10k', {noremap = true})

