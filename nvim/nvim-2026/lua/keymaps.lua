-- ============================================================
-- Keymaps (Vim parity)
-- ============================================================

local keymap = vim.keymap.set
local opts = { silent = true }

-- -----------------------
-- NERDTree
-- -----------------------
keymap("n", "<leader>n", ":NERDTreeFocus<CR>", opts)
keymap("n", "<C-n>", ":NERDTree<CR>", opts)
keymap("n", "<C-t>", ":NERDTreeToggle<CR>", opts)
keymap("n", "<C-f>", ":NERDTreeFind<CR>", opts)

-- -----------------------
-- CoC.nvim
-- -----------------------

-- Completion navigation
keymap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true, silent = true })
keymap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<C-h>"', { expr = true, silent = true })

-- Confirm completion
keymap("i", "<CR>", 'pumvisible() ? coc#_select_confirm() : "<CR>"', { expr = true, silent = true })

-- Trigger completion
keymap("i", "<C-Space>", "coc#refresh()", { expr = true, silent = true })

-- LSP navigation
keymap("n", "gd", "<Plug>(coc-definition)", opts)
keymap("n", "gy", "<Plug>(coc-type-definition)", opts)
keymap("n", "gi", "<Plug>(coc-implementation)", opts)
keymap("n", "gr", "<Plug>(coc-references)", opts)

-- Hover
keymap("n", "K", ":call CocActionAsync('doHover')<CR>", opts)

-- Rename
keymap("n", "<leader>rn", "<Plug>(coc-rename)", opts)

-- Format
keymap("n", "<leader>f", ":call CocAction('format')<CR>", opts)

-- Code actions
keymap("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)
keymap("x", "<leader>ac", "<Plug>(coc-codeaction-selected)", opts)

-- Diagnostics
keymap("n", "[g", "<Plug>(coc-diagnostic-prev)", opts)
keymap("n", "]g", "<Plug>(coc-diagnostic-next)", opts)

