--code by ZPC 2019/07/15

local UILoginLayer = class("UILoginLayer", require('app.GameBaseLogic.BaseUI'))

function UILoginLayer:init()
	self.aniamtionIdx = 1
	self.aniamtions = {"shengli_in","shengli_in2", "shengli_out", "shibai_in", "shibai_out"  }
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
--		SceneHelper:gotoScene("GameSceneBattle")
		self.pvpSpine:setAnimation(0, self.aniamtions[self.aniamtionIdx], false)
		self.aniamtionIdx = self.aniamtionIdx + 1
		if self.aniamtionIdx > #self.aniamtions then
			self.aniamtionIdx = 1
		end
	end)

	local text = CommonHelper:createBMFontLabel("5")
	:addTo(self)
	:setPosition(400,300)

	CommonHelper:shader_Custom(self, Macros.ShaderResources.Grey)

	self.pvpSpine = SpineHelper:createSpine("spine/test/pvp_jiesuan", 0.6)
	self.pvpSpine:addTo(self)
	:setPosition(500,300)
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