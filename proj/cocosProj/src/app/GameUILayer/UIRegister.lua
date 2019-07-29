local UIRegister = class("UIRegister", BaseUI)

function UIRegister:init()
	CommonHelper:addUIModal(UIDefine.UILoginLayer)
	self:initUI()
end


function UIRegister:initUI()
	self.close = self.widget:getChildByName("closeBtn")
		:addClickEventListener(handler(self, self.close))

	self.btnYes = self.widget:getChildByName("btnYes")
		:addClickEventListener(function()
			CommonHelper:showOkPopup("system msg",
				"congratulation you get a equipment",
				function()
--					SceneHelper:popScene()
					EventHelper:broadcastEvent("keykey", "你好")
				end,
				false, 
				true)
		end)

end

function UIRegister:onEvent(key, data)
	print("收到了事件UIRegister",key, data)
	return true
end

return UIRegister