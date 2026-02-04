vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- We are adding blink after all other plugin for performance reasons, just it

		-- FIX: This is not working in my setup ZZZ...
		vim.api.nvim_create_autocmd("PackChanged", {
			callback = function(ev)
				-- Use available |event-data|
				local name, kind = ev.data.spec.name, ev.data.kind
				-- Run build script after plugin's code has changed
				if name == "blink.cmp" and (kind == "install" or kind == "update") then
					-- Append `:wait()` if you need synchronous execution
					vim.system({ "cargo build --release" }, { cwd = ev.data.path }):wait()
				end
			end,
		})

		-- -- use a release tag to download pre-built binaries
		-- version = "1.*",
		-- -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- -- build = 'cargo build --release',
		-- -- If you use nix, you can build from source using latest nightly rust with:
		-- -- build = 'nix run .#build-plugin',
		--
		-- ---@module 'blink.cmp'
		-- ---@type blink.cmp.Config
		require("blink.cmp").setup({
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "default" },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = true } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				providers = {
					buffer = {
						opts = {
							-- -- get all buffers, even ones like neo-tree
							-- get_bufnrs = vim.api.nvim_list_bufs,
							-- or (recommended) filter to only "normal" buffers
							get_bufnrs = function()
								return vim.tbl_filter(function(bufnr)
									return vim.bo[bufnr].buftype == ""
								end, vim.api.nvim_list_bufs())
							end,
						},
					},
				},
				default = { "lsp", "path", "snippets" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			-- fuzzy = { implementation = "prefer_rust_with_warning" },
			fuzzy = { implementation = "lua" },
			-- Cmdline
			cmdline = {
				enabled = true,
				keymap = {
					-- preset = "inherit",
					-- recommended, as the default keymap will only show and select the next item
					-- ["<Tab>"] = { "show", "accept" },

				["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
				["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },

					["<C-space>"] = { "show", "fallback" },

					["<C-n>"] = { "select_next", "fallback" },
					["<C-p>"] = { "select_prev", "fallback" },
					-- ["<Right>"] = { "select_next", "fallback" },
					-- ["<Left>"] = { "select_prev", "fallback" },

					["<C-y>"] = { "select_and_accept", "fallback" },
					["<C-e>"] = { "cancel", "fallback" },
				},
				completion = { menu = { auto_show = false } },
			},
		})
	end,
})
