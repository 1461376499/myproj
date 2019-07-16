--code by ZPC 2019/07/16
local BaseImplent = class("BaseImplent")

BaseImplent.EVENT_TAG_BINDING = ""
BaseImplent.VIEW_EVENT_BINDING = ""

function BaseImplent:ctor()

end

function BaseImplent:dispatchEvent(sub, data)
	GameEventDef.DispathEvent(self.VIEW_EVENT_BINDING, sub, data)
end

return BaseImplent