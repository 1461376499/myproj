local EventDispatcher = EventDispatcher or {}

function EventDispatcher:init()
	--所有baseUI容器
	self.uiMap = {}

	--动态索引，每添加一个ui组件唯一值
	self.uiIndex = 1
end

--发送订阅事件
function EventDispatcher:dispatchEvent(events,  sub,  data)
	local customEvent = cc.EventCustom:new(events["KEY"])
	customEvent["_userData"] = {
		sub = events[sub],
		data = data
	}
	ccDirector:getEventDispatcher():dispatchEvent(customEvent)
end

--注册广播监听观察者
--参数:baseUI组件
function EventDispatcher:registerListener(target)	
	target.uiIndex = self.uiIndex
	table.insert(self.uiMap, target)

	self.uiIndex = self.uiIndex + 1
	print("注册广播",#self.uiMap)
end

--移除监听者
function EventDispatcher:removeListener(target)
	for j = #self.uiMap, 1, -1 do
		local layer = self.uiMap[j]
		if layer.uiIndex == target.uiIndex then
			table.remove(self.uiMap, j)
		end
	end
end

--广播消息
function EventDispatcher:broadcastEvent(key, data)
	self:_broadcastEvent(key, data)
end

--广播消息(内部函数)
function EventDispatcher:_broadcastEvent(key, data)
	--让后添加的监听器先接收事件
	for j = #self.uiMap, 1, -1 do
		local ui = self.uiMap[j]
		if ui and ui.onEvent then
			--通过返回值设置不在继续分发事件
			if ui:onEvent(key, data) then	
				break;
			end
		end
	end
end
EventDispatcher:init()
return EventDispatcher