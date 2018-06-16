---@class CoC_Creature
---@field short FlashString

---@param text string
function Print(text)
    EngineCore:outputText(text)
end

---@return CoC_Creature
function GetPlayer()
    return coc.player
end

---@param creature CoC_Creature
---@return string
function GetName(creature)
    return flash.asstring(creature.short)
end
