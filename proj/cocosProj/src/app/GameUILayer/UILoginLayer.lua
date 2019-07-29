--code by ZPC 2019/07/15

local UILoginLayer = class("UILoginLayer", require('app.GameBaseLogic.BaseUI'))

function UILoginLayer:init()
	self:initUI()
	self:addEvents()
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
--		CommonHelper:addUIModal(UIDefine.UIRegister)
--		CommonHelper:shader_Default(self)
		SceneHelper:gotoScene("GameSceneBattle")
	end)

	local text = CommonHelper:createBMFontLabel("5")
	:addTo(self)
	:setPosition(500,300)

	CommonHelper:shader_Custom(self, Macros.ShaderResources.Grey)


end


--多态函数
function UILoginLayer:addEvents()
	self:addCustomEvent("LVUP", function(data)
		print("你好",data)
	end)
end

function UILoginLayer:onEvent(key, data)
	print("收到了事件UILoginLayer",key, data)
	return true
end

return UILoginLayer