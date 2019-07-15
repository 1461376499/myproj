--code by ZPC 2019/07/15

local UILoginLayer = class("UILoginLayer", require('app.GameBaseLogic.BaseUI'))

UILoginLayer.UI_File_CSB = "layer/login/login_register_mail.csb"
UILoginLayer.Event_Tag = "EVENT_UILoginLayer"

function UILoginLayer:ctor()
	UILoginLayer.super.ctor(self)
end

function UILoginLayer:initUI()
	self.closeBtn = ccUtils.findChild(self.widget, "closeBtn")
	self.closeBtn:addClickEventListener(handler(self, self.close))

	self.panel_mail = self.widget:getChildByName("panel_mail")
	self.panel_mail:setVisible(false)
	self.panel_password = self.widget:getChildByName("panel_password")
	self.panel_password:setVisible(false)
end

function UILoginLayer:initEvents()
	
end

return UILoginLayer