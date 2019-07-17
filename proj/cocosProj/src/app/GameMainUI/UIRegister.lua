local UIRegister = class("UIRegister", BaseUI)

UIRegister.CSB_BINDING = "layer/bangzhu.csb"

function UIRegister:ctor()
	UIRegister.super.ctor(self)
end


function UIRegister:initUI()
	self.close = self.widget:getChildByName("closeBtn")
		:addClickEventListener(handler(self, self.close))
end

return UIRegister