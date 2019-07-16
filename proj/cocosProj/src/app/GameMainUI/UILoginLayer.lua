--code by ZPC 2019/07/15

local UILoginLayer = class("UILoginLayer", require('app.GameBaseLogic.BaseUI'))

UILoginLayer.CSB_BINDING = "layer/login/login_register_mail.csb"
UILoginLayer.IMPLENT_BINDING = "UILoginLayerImplent"

function UILoginLayer:ctor()
	UILoginLayer.super.ctor(self)
end

--��̬����
function UILoginLayer:initUI()
	self.closeBtn = ccUtils.findChild(self.widget, "closeBtn")
	self.closeBtn:addClickEventListener(function()
		self.Implent:dispatchEvent("LVUP", "���")
	end)

	self.panel_mail = self.widget:getChildByName("panel_mail")
	self.panel_mail:setVisible(false)
	self.panel_password = self.widget:getChildByName("panel_password")
	self.panel_password:setVisible(false)
end


--��̬����
function UILoginLayer:addEvents()
	self:addCustomEvent("LVUP", function(data)
		print("���",data)
	end)
end

return UILoginLayer