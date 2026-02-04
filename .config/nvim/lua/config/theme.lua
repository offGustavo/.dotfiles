-- Caminho para salvar o tema escolhido
local theme_file = vim.fn.stdpath("config") .. "/.theme"

-- Última versão do tema carregado
local last_theme = nil
local file_stat_cache = nil

-- Função para obter estatísticas do arquivo
local function get_file_stat()
  return vim.loop.fs_stat(theme_file)
end

-- Função para carregar o tema do arquivo
local function load_theme()
  local current_stat = get_file_stat()
  
  -- Verifica se o arquivo existe e foi modificado
  if not current_stat or 
     (file_stat_cache and 
      file_stat_cache.mtime.sec == current_stat.mtime.sec and
      file_stat_cache.size == current_stat.size) then
    return
  end
  
  file_stat_cache = current_stat
  
  local f = io.open(theme_file, "r")
  if not f then return end
  
  local theme = f:read("*l")
  f:close()
  
  if theme and #theme > 0 and theme ~= last_theme then
    local ok = pcall(vim.cmd.colorscheme, theme)
    if ok then
      last_theme = theme
      -- vim.notify("Tema atualizado para: " .. theme, vim.log.levels.INFO)
    end
  end
end

-- Carrega o tema na inicialização
load_theme()

-- Função para salvar o tema ao trocar
local function save_theme(theme)
  local f = io.open(theme_file, "w")
  if f then
    f:write(theme)
    f:close()
    -- Atualiza cache após salvar
    file_stat_cache = get_file_stat()
  end
end

-- Autocomando: quando você muda manualmente o colorscheme, salva no arquivo
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local theme = vim.g.colors_name
    if theme then
      save_theme(theme)
    end
  end,
})

-- Usa vim.loop para polling mais eficiente
local poll_handle = nil

local function setup_file_polling()
  poll_handle = vim.loop.new_timer()
  
  poll_handle:start(100, 100, vim.schedule_wrap(function()
    load_theme()
  end))
end

-- Inicia o polling apenas se não estiver rodando
if not poll_handle then
  setup_file_polling()
end

-- Função para limpar recursos (opcional)
_G.cleanup_theme_watcher = function()
  if poll_handle then
    poll_handle:stop()
    poll_handle:close()
    poll_handle = nil
  end
end
