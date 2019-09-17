--code by ZPC 2019/07/16
local BaseModel = class("BaseModel")

BaseModel.VIEW_EVENT_BINDING = ""

function BaseModel:ctor()
	
end

function BaseModel:init(params)
	
end

--定向发送消息到绑定的view去
function BaseModel:dispatchEvent(sub, data)
	EventDispatcher:dispatchEvent(self.VIEW_EVENT_BINDING, sub, data)
end

--销毁实例
function BaseModel:destory()
	
end


return BaseModel