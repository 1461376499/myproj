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
	for i = 1, 100 do
		local hero = sp.SkeletonAnimation:createWithBinaryFile("spine/test/npc_xy.skel","spine/test/npc_xy.atlas")
		hero:addTo(self)
		hero:setPosition(ccp(i * 10, 200))
	end
end

return UIRegister