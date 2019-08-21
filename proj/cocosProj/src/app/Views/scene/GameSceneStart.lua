--code by zpc
SceneHelper		= require("app.GameCoreLogic.GameSceneHelper").new()
LoginHelper = require("app.GameCoreLogic.GameLoginHelper").new()

local LuaClass = class("LuaClass", cc.Scene)

function LuaClass:ctor()
	self:enableNodeEvents()
	self:setName("GameSceneStart")
	cc.Director:getInstance():replaceScene(self)

	SceneHelper:setRunningScene(self)

    local is_hot_finish = cc.UserDefault:getInstance():getIntegerForKey("is_last_update_finish", 0)
    if is_hot_finish == 1 then
        ccFileUtils:removeDirectory(ccFileUtils:getWritablePath().."update/")
        ccUserDefault:setIntegerForKey("is_last_update_finish", 0)
    end
	--todo  load logo and splash
end


function LuaClass:onEnterTransitionFinish()
	--开始登录加载必要的资源
	

    __App = require("app.MyApp").new()

	LoginHelper:preLoading(function()
		__App:run()
	end)
   	
end

return LuaClass