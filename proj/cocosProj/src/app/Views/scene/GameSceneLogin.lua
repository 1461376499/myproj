--code by zpc
local LuaClass = class("LuaClass", BaseScene)


function LuaClass:ctor()
	LuaClass.super.ctor(self)
	self:enableNodeEvents()
	self:setName("GameSceneLogin")
	self:loadWidget()
end


function LuaClass:onEnterTransitionFinish()
	--开始播放音乐
	AudioEngine.playMusic("music/Music1.mp3", true)

	--开始第三方登录
	LoginHelper:start3rdLogin(handler(self, self.login3rdResult))
end

function LuaClass:loadWidget()
	cc.Label:createWithSystemFont("login", "Arial", 40)
		:move(display.cx, display.cy + 200)
		:addTo(self)

	self.loginLayer = CommonHelper:addUIModal(UIDefine.UILoginLayer)
		:setClosedCallback(function() print("关闭了界面")  end )
end

--第三方登录结果
function LuaClass:login3rdResult(result)
	
end


return LuaClass
