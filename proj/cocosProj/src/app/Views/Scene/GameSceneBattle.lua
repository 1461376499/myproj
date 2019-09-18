local GameSceneBattle = class("GameSceneBattle", BaseScene)

function GameSceneBattle:ctor()
	GameSceneBattle.super.ctor(self)
	self:setName("GameSceneBattle")
	
	self:loadWidget()
end

function GameSceneBattle:loadWidget()
	cc.Label:createWithSystemFont("battle", "Arial", 40)
		:move(display.cx, display.cy + 400)
		:addTo(self)
	local register = CommonHelper:addUIModal(UIDefine.RegisterLayer)
	register:setClosedCallback(function() print("关闭了界面",register.name)  end )
	register:setWillCloseCallback(function() print("即将关闭界面", register.name)  end )
end

return GameSceneBattle
