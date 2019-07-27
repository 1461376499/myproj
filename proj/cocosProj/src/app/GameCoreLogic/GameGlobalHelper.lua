local GameGlobalHelper = class("GameGlobalHelper")


GameGlobalHelper.m_UIContainer	= {}	--所有ui和场景容器
GameGlobalHelper.m_language = 1			--语言

function GameGlobalHelper:ctor()
	
end

function GameGlobalHelper:registerListener(target, tag)
	table.insert(self.m_UIContainer, {ui = target, tag = tag})
end
function GameGlobalHelper:removeListener(tag)
	for j = #self.m_UIContainer, 1, -1 do
		local layer = self.m_UIContainer[j]
		if layer.tag == tag then
			table.remove(self.m_UIContainer, j)
		end
	end
	print("#self.m_UIContainer == ",#self.m_UIContainer)
end

function GameGlobalHelper:notifyEvent(key, data)
	self:dispathEvent(key, data)
end

--广播消息
function GameGlobalHelper:dispathEvent(key, data)
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

return GameGlobalHelper