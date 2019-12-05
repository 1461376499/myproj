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
	MusicManager:playMusic()

	--开始第三方登录
	LoginManager:start3rdLogin(handler(self, self.login3rdResult))
end

function GameSceneLogin:loadWidget()
	cc.Label:createWithSystemFont("login", "Arial", 40)
		:move(display.cx, display.cy + 400)
		:addTo(self)

	self.loginLayer = CommonHelper:addPopupWindow(UIDefine.LoginLayer)
		:setAfterCloseCallback(function() print("关闭了界面",self.loginLayer.name)  end )
		:setWillCloseCallback(function() print("即将关闭界面", self.loginLayer.name)  end )

	local btn = ccui.Button:create("update/login_btn_account.png","")
	:addTo(self)
	:setPosition(500,300)
	:setContentSize(cc.size())
--	self.pvpSpine = SpineManager:createSpine("spine/test/lueduo_jiesuan", spineEvent)
--	self.pvpSpine:addTo(btn:getRendererNormal())
----	self.pvpSpine:setAnimation(0,animations[1],false)
--	self.pvpSpine:setPosition(0,0)
	
end

--第三方登录结果
function GameSceneLogin:login3rdResult(result)
	
end


return GameSceneLogin
