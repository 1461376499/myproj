local GameSceneBattle = class("GameSceneBattle", BaseScene)

function GameSceneBattle:ctor()
	GameSceneBattle.super.ctor(self)

	cc.Label:createWithSystemFont("battle", "Arial", 40)
		:move(display.cx, display.cy + 200)
		:addTo(self)

	CommonHelper:addUIModal(UIDefine.RegisterLayer)
	print("popwindnum = ", #PopWindowManager:getPopWindows())
	--CommonHelper:shader_Default(self)
end

return GameSceneBattle
