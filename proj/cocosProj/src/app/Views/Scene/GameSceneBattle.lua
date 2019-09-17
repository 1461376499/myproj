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
	CommonHelper:addUIModal(UIDefine.RegisterLayer)
end

return GameSceneBattle
