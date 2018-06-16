---@class CoC_Creature
---@field public short FlashString

---@class Creature
---@field private ref CoC_Creature
---@field public extra table
Creature = {}

---@param ref CoC_Creature
---@return Creature
function Creature:wrap(ref)
    local inst = {}
    setmetatable(inst, self)
    self.__index = self
    inst.ref = ref
    inst.extra = {}
    return inst
end

function Creature:addHP(amount)
    self.ref:addHP(amount)
end

function Creature:maxHP()
    return flash.asnumber(self.ref:maxHP())
end

---@param text string
function Print(text)
    EngineCore:rawOutputText(text)
end
---@param text string
function Output(text)
    EngineCore:outputText(text)
end

---@return CoC_Creature
function GetPlayer()
    return coc.player
end

---@param creature CoC_Creature
---@return string
function GetName(creature)
    return creature.short
end
