local RegisterLayer = class("RegisterLayer", BaseUI)

function RegisterLayer:init()
	self:initUI()
end


function RegisterLayer:initUI()
	self.close = self.widget:getChildByName("closeBtn")
		:addClickEventListener(handler(self, self.close))

	self.btnYes = self.widget:getChildByName("btnYes")
		:addClickEventListener(function()
			CommonHelper:showOkPopup("system msg",
				"congratulation you get a equipment",
				function()
					print("点击了确定")
					EventDispatcher:broadcastEvent("keykey", "你好")
--					SceneManager:popScene()
					
				end,
				false, 
				true)
		end)

end

function RegisterLayer:onEvent(key, data)
	print("收到了事件RegisterLayer",key, data)
end

return RegisterLayer