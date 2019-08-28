--code by ZPC 2019/07/15

local LoginLayer = class("LoginLayer", BaseUI)


function LoginLayer:init()
	print("LoginLayer:init")
	self.aniamtionIdx = 1
	self.aniamtions = {"shengli_in","shengli_in2", "shengli_out", "shibai_in", "shibai_out"  }
	self:initUI()
	self:addEvents()
end

--多态函数
function LoginLayer:initUI()
	self.closeBtn = ccUtils.findChild(self.widget, "closeBtn")
	self.closeBtn:addClickEventListener(function()
		self:close()
	end)

	self.panel_mail = self.widget:getChildByName("panel_mail")
	self.panel_mail:setVisible(false)

	self.panel_password = self.widget:getChildByName("panel_password")
	self.panel_password.button = self.panel_password:getChildByName("button")
	self.panel_password.button:addClickEventListener(function()
--		CommonHelper:addUIModal(UIDefine.RegisterLayer)
--		CommonHelper:shader_Default(self)
--		SceneManager:gotoScene("GameSceneBattle")
		self.pvpSpine:setAnimation(0, self.aniamtions[self.aniamtionIdx], false)
		self.aniamtionIdx = self.aniamtionIdx + 1
		if self.aniamtionIdx > #self.aniamtions then
			self.aniamtionIdx = 1
		end
	end)

	local text = CommonHelper:createBMFontLabel("5")
	:addTo(self)
	:setPosition(400,300)

	CommonHelper:shader_Custom(self, GlobalConfig.ShaderResources.Grey)
	local index = 1
	local animations = {"shengli_in", "shengli_in2", "shibai_in", "shengli_out","shibai_out"}
	local function spineEvent(spine, event)
		if event.type == "complete" then
			self.pvpSpine:setAnimation(0, animations[index], false)
			index = index + 1
			if index > #animations then
				index = 1
			end
		end
	end
	self.pvpSpine = SpineManager:createSpine("spine/test/lueduo_jiesuan", spineEvent)
	self.pvpSpine:addTo(self)
	self.pvpSpine:setAnimation(0,animations[1],false)
	self.pvpSpine:setPosition(500,300)

	local groupUI = require("app.views.ui.GroupUI.GroupMain").new()
end


--多态函数
function LoginLayer:addEvents()
	self:addCustomEvent("LVUP", function(data)
		print("你好",data)
	end)
end

function LoginLayer:onEvent(key, data)
	print("收到了事件LoginLayer",key, data)
	return true
end

return LoginLayer