---@param text string
function Print(text)
    EngineCore:rawOutputText(text)
end
---@param text string
function PrintLn(text)
    EngineCore:rawOutputText(text)
    EngineCore:rawOutputText('\n')
end
---@param text string
function Output(text)
    EngineCore:outputText(text)
end

---@return Creature
function GetPlayer()
    return coc.player
end

---@param creature Creature
---@return string
function GetName(creature)
    return creature.short
end
