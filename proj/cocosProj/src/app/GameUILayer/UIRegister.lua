local UIRegister = class("UIRegister", BaseUI)


function UIRegister:ctor()
	UIRegister.super.ctor(self)
end


function UIRegister:initUI()
	self.close = self.widget:getChildByName("closeBtn")
		:addClickEventListener(handler(self, self.close))

	self.btnYes = self.widget:getChildByName("btnYes")
		:addClickEventListener(function()
			CommonHelper:showOkPopup("system msg",
				"congratulation you get a equipment",
				function()
					print("点击ok")
				end,
				false, 
				true)
		end)
end

return UIRegister