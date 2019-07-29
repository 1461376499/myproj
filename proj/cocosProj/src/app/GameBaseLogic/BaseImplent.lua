--code by ZPC 2019/07/16
local BaseImplent = class("BaseImplent")

BaseImplent.VIEW_EVENT_BINDING = ""

function BaseImplent:ctor()
	
end

function BaseImplent:init(params)
	
end

function BaseImplent:dispatchEvent(sub, data)
	EventHelper:dispathEvent(self.VIEW_EVENT_BINDING, sub, data)
end

--销毁实例
function BaseImplent:destory()
	
end


return BaseImplent