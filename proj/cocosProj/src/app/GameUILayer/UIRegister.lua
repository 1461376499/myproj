local UIRegister = class("UIRegister", BaseUI)

UIRegister.EventTag = "UIRegisterTag"

function UIRegister:ctor()
	UIRegister.super.ctor(self)

	CommonHelper:addUIModal(UIDefine.UILoginLayer)
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
					GlobalHelper:notifyEvent(nil, "你好")
				end,
				false, 
				true)
		end)

end

function UIRegister:onEvent(key, data)
	print("收到了事件UIRegister",data)
	return true
end

return UIRegister