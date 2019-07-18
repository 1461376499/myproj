--code by zpc
local LuaClass = class("LuaClass", BaseScene)


function LuaClass:ctor()
	LuaClass.super.ctor(self)
	self:enableNodeEvents()
	self:setName("GameSceneLogin")
end

function LuaClass:onEnter()
	self:loadWidget()
end

function LuaClass:onEnterTransitionFinish()
	--todo play music
	AudioEngine.playMusic("music/Music1.mp3", true)
	--AudioEngine.setMusicVolume(0.01)
	--tode start login
end

function LuaClass:loadWidget()
	self.loginLayer = CommonHelper:addUI(UIDefine.UILoginLayer, true)
		:setClosedCallback(function() print("关闭了界面")  end )
end
return LuaClass
