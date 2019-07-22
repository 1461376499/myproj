--code by ZPC 2019/07/16
local BaseImplent = class("BaseImplent")

BaseImplent.EVENT_TAG_BINDING = ""
BaseImplent.VIEW_EVENT_BINDING = ""

function BaseImplent:ctor()

end

function BaseImplent:dispatchEvent(sub, data)
	EventDefine.DispathEvent(self.VIEW_EVENT_BINDING, sub, data)
end

--销毁实例
function BaseImplent:destory()
	
end


return BaseImplent