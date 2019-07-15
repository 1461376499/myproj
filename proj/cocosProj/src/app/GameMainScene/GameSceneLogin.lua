--code by zpc
local LuaClass = class("LuaClass", require('app.GameBaseLogic.BaseScene'))


function LuaClass:ctor()
	self:enableNodeEvents()
	self:setName("GameSceneLogin")

	self:loadWidget()
end


function LuaClass:onEnterTransitionFinish()
	--todo play music
	AudioEngine.playMusic("music/Music1.mp3", true)

	--tode start login
end

function LuaClass:loadWidget()
	self.loginLayer = require("app.GameMainUI.UILoginLayer").new()
		:addTo(self)
end
return LuaClass
