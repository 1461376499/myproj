--code by zpc
local GameSceneLogin = class("GameSceneLogin", BaseScene)


function GameSceneLogin:ctor()
	print("GameSceneLogin:ctor")
	GameSceneLogin.super.ctor(self)
	self:enableNodeEvents()
	self:setName("GameSceneLogin")
	self:loadWidget()
end


function GameSceneLogin:onEnterTransitionFinish()
	--开始播放音乐
	AudioEngine.playMusic("music/Music1.mp3", true)

	--开始第三方登录
	LoginManager:start3rdLogin(handler(self, self.login3rdResult))
end

function GameSceneLogin:loadWidget()
	cc.Label:createWithSystemFont("login", "Arial", 40)
		:move(display.cx, display.cy + 200)
		:addTo(self)

	self.loginLayer = CommonHelper:addUIModal(UIDefine.LoginLayer)
		:setClosedCallback(function() print("关闭了界面")  end )
end

--第三方登录结果
function GameSceneLogin:login3rdResult(result)
	
end


return GameSceneLogin
