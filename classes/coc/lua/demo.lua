local function show(name,value)
    Print('var ' .. name .. ': ' .. typeof(value))
    if type(value)=='table' then
        Print(' = [')
        for k,v in pairs(value) do
            Print(k)
            --       Print(': ' .. type(value))
            Print( '; ')
        end
        Print(']')
    elseif type(value)=='userdata' then
        Print(' = ' .. tostring(value))
        value = flash_convert(value)
        Print(' => ' .. type(value))
        Print(' = ' .. tostring(value))
    elseif type(value)~='nil' then
        Print(' = ' .. tostring(value))
    end
    Print('\n')
end

--[[local player = coc.player
show('player.short',player.short)
show('builtins',builtins)
local fmt = flash_metatable
show('fmt',fmt)
show('fmt.__index',fmt.__index)
show('old_flash_index',old_flash_index)
show('new_flash_index',old_flash_index)
function new_flash_index(table,key)
    return flash_convert(old_flash_index(table,key))
end
show('old_flash_index(player,"short")',old_flash_index(player,"short"))
show('new_flash_index(player,"short")',new_flash_index(player,"short"))
show('player.short',player.short)
fmt.__index = new_flash_index
show('player.short',player.short)

if true then return end]]
show('flash', flash)
show('EngineCore', EngineCore)
show('coc', coc)
show('coc.visible', coc.visible)
show('flash.asnumber(coc.visible)', flash.asnumber(coc.visible))
show('flash.asstring(coc.visible)', flash.asstring(coc.visible))
show('typeof', typeof)
show('builtins.typeof', builtins.typeof)
local demo = builtins.demo
show('demo', demo)
show('demo.a', demo.a)
show('demo.a equals 1', flash_equals(demo.a, 1))
show('demo.b', demo.b)
show('demo.c', demo.c)
show('demo.d', demo.d)
show('demo.e', demo.e)
show('demo.e equals null', flash_equals(demo.e, builtins.null))
show('demo.f', demo.f)
show('demo.g', demo.g)
show('demo.h', demo.h)
show('demo.i', demo.i)