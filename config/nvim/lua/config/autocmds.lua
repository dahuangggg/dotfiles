local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  desc = "复制文本后短暂高亮",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  desc = "重新打开文件时恢复上次光标位置",
  callback = function(event)
    if vim.bo[event.buf].filetype == "gitcommit" then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPre", {
  group = augroup("bigfile"),
  desc = "大文件使用轻量模式",
  callback = function(event)
    local size = vim.fn.getfsize(event.file)
    if size <= vim.g.bigfile_size then
      return
    end

    vim.b[event.buf].bigfile = true
    vim.bo[event.buf].swapfile = false
    vim.bo[event.buf].undofile = false
    vim.bo[event.buf].syntax = "off"
    vim.diagnostic.enable(false, { bufnr = event.buf })
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("terminal"),
  desc = "终端 Buffer 隐藏行号",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  desc = "窗口尺寸变化时平衡分屏",
  command = "tabdo wincmd =",
})

-- 启动参数中的 Lua 文件可能在 init.lua 执行前就触发 FileType，补载它的专属配置。
vim.schedule(function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].filetype ~= "" then
      local ftplugin = vim.fn.stdpath("config") .. "/after/ftplugin/" .. vim.bo[bufnr].filetype .. ".lua"
      if vim.fn.filereadable(ftplugin) == 1 then
        vim.api.nvim_buf_call(bufnr, function()
          dofile(ftplugin)
        end)
      end
    end
  end
end)
