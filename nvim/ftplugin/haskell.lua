local M = {}
local autocmd_group = vim.api.nvim_create_augroup("Haskell", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.hs"
    ,
    callback = function()
      vim.lsp.buf.format({ timeout_ms = 1000 })
    end
    ,
    group = autocmd_group
  })


--M.formatFourmolu = function()
--  local bufnr = vim.api.nvim_get_current_buf()
--  local filepath = vim.api.nvim_buf_get_name(bufnr)
--
--  if vim.fn.executable("fourmolu") ~= 1 then
--    vim.notify("❌ fourmolu not found in PATH", vim.log.levels.ERROR)
--    return
--  end
--
--  local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
--  local original_modifiable = vim.api.nvim_get_option_value("modifiable", { buf = bufnr })
--  local cursor = vim.api.nvim_win_get_cursor(0)
--
--  -- Disable edition
--  vim.api.nvim_set_option_value('modifiable', false, { buf = bufnr })
--  vim.system({ "fourmolu", "--mode", "check", "--stdin-input-file", filepath }, {
--    stdin = content,
--  }, function(obj_check)
--    if obj_check.code == 0 then
--      -- File is formatted
--      vim.schedule(function()
--        vim.bo[bufnr].modifiable = original_modifiable
--        vim.notify("✔️ Already formatted.", vim.log.levels.INFO)
--      end)
--    else
--      vim.system({ "fourmolu", "--stdin-input-file", filepath }, {
--        stdin = content,
--      }, function(obj)
--        -- Making the buffer modifiable again
--        vim.schedule(function()
--          vim.api.nvim_set_option_value('modifiable', original_modifiable, { buf = bufnr })
--        end)
--
--        if obj.code ~= 0 then
--          vim.schedule(function()
--            vim.notify("❌ Formatting failed! :\n" .. table.concat(obj.stderr, "\n"), vim.log.levels.ERROR)
--          end)
--          return
--        end
--
--        local lines = vim.split(obj.stdout, "\n", { plain = true })
--
--        vim.schedule(function()
--          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
--          vim.api.nvim_win_set_cursor(0, cursor)
--          vim.notify("✔️ Formatted.", vim.log.levels.INFO)
--        end)
--      end)
--    end
--  end
--  )
--end
--
--
--vim.api.nvim_create_user_command('FormatFourmolu', M.formatFourmolu, {})

return M
-- depends on zfc and an available hoogle instance

-- vim.api.nvim_create_autocmd({ "BufWritePre" },
--   {
--     pattern = "*.hs"
--     ,
--     callback =
--         function()
--           vim.api.nvim_set_keymap('<buffer>gf', ':execute ":Hoogle " . expand(\'<cword>\')<esc>')
--         end
--     ,
--     group = autocmd_group
--   })
