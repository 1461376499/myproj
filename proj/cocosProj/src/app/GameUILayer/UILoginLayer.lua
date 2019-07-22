--code by ZPC 2019/07/15

local UILoginLayer = class("UILoginLayer", require('app.GameBaseLogic.BaseUI'))

function UILoginLayer:ctor()
	UILoginLayer.super.ctor(self)
end

--多态函数
function UILoginLayer:initUI()
	self.closeBtn = ccUtils.findChild(self.widget, "closeBtn")
	self.closeBtn:addClickEventListener(function()
		self:close()
	end)

	self.panel_mail = self.widget:getChildByName("panel_mail")
	self.panel_mail:setVisible(false)

	self.panel_password = self.widget:getChildByName("panel_password")
	self.panel_password.button = self.panel_password:getChildByName("button")
	self.panel_password.button:addClickEventListener(function()
		CommonHelper:addUI(UIDefine.UIRegister)
	end)

	local text = CommonHelper:newBMFontLabel("5")
	:addTo(self)
	:setPosition(500,300)
end


--多态函数
function UILoginLayer:addEvents()
	self:addCustomEvent("LVUP", function(data)
		print("你好",data)
	end)
end

return UILoginLayer