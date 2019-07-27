--code by ZPC 2019/07/15

local UILoginLayer = class("UILoginLayer", require('app.GameBaseLogic.BaseUI'))

UILoginLayer.EventTag = "UILoginLayerTag"

function UILoginLayer:ctor()
	UILoginLayer.super.ctor(self)
end

--��̬����
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
--		CommonHelper:addUIModal(UIDefine.UIRegister)
--		CommonHelper:shader_Default(self)
		SceneHelper:pushScene("GameSceneBattle")
	end)

	local text = CommonHelper:newBMFontLabel("5")
	:addTo(self)
	:setPosition(500,300)

	CommonHelper:shader_Custom(self, Macros.ShaderResources.Grey)

end


--��̬����
function UILoginLayer:addEvents()
	self:addCustomEvent("LVUP", function(data)
		print("���",data)
	end)
end

function UILoginLayer:onEvent(key, data)
	print("�յ����¼�UILoginLayer", data)
	return true
end

return UILoginLayer