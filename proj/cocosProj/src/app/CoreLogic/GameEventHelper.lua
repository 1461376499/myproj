local GameEventHelper = GameEventHelper or {}

function GameEventHelper:init()
	--观察者容器--所有baseUI容器
	self.m_UIContainer = {}

	--动态引用计数，每添加一个UI组件都会分配一个唯一值
	self.uiRefernceIndex = 0
end

--发送订阅的自定义事件/接收者只有一个
function GameEventHelper:dispathEvent(events,  sub,  data)
	local customEvent = cc.EventCustom:new(events["KEY"])
	customEvent["_userData"] = {
		sub = events[sub],
		data = data
	}
	ccDirector:getEventDispatcher():dispatchEvent(customEvent)
end

--注册广播监听观察者
--参数:baseUI组件
function GameEventHelper:registerListener(target)
	self.uiRefernceIndex = self.uiRefernceIndex + 1

	table.insert(self.m_UIContainer, {ui = target, referenceIndex = self.uiRefernceIndex})
end

--移除广播监听观察者
function GameEventHelper:removeListener(index)
	for j = #self.m_UIContainer, 1, -1 do
		local layer = self.m_UIContainer[j]
		if layer.referenceIndex == index then
			table.remove(self.m_UIContainer, j)
		end
	end
	print("#self.m_UIContainer == ",#self.m_UIContainer)
end

--广播一条消息/接收者是所有BaseUI组件
function GameEventHelper:broadcastEvent(key, data)
	self:_broadcastEvent(key, data)
end

--广播一条消息(内部函数)
function GameEventHelper:_broadcastEvent(key, data)
	--让后添加的监听器先接收事件
	print("#self.m_UIContainer == ",#self.m_UIContainer)
	for j = #self.m_UIContainer, 1, -1 do
		local element = self.m_UIContainer[j]
		if element and element.ui and element.ui.onEvent then
			if not element.ui:onEvent(key, data) then	--不在继续分发事件
				break;
			end
		end
	end
end
GameEventHelper:init()
return GameEventHelper