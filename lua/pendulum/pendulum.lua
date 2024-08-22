--local Timer = {}
--Timer.__index = Timer

--function Timer:new()
--  return 5
--end
--
---- Function to check if a plugin module is loaded
local M = {}
function M.is_plugin_loaded(plugin_name)
    local ok, result = pcall(require, plugin_name)
    --print("Results: ", _)
    --for key, value in pairs(_) do
    --            print(key, value)
    --        end
    --if ok then
    --  result.setup({
    --    sections={ lualine_x = { hello } }
    --  })
    --end
    return ok, result
end

-- Print whether the plugin is loaded
function M.print_plugin_status(plugin_name)
    if is_plugin_loaded(plugin_name) then
        print('Plugin "' .. plugin_name .. '" is loaded.')
    else
        print('Plugin "' .. plugin_name .. '" is NOT loaded.')
    end
end
--print_plugin_status('')
return M

