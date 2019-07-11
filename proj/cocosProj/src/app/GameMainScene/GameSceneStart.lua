--code by zpc
local LuaClass = class("LuaClass", cc.Scene)


function LuaClass:ctor()
	self:enableNodeEvents()
	cc.Director:getInstance():replaceScene(self)

    local is_hot_finish = cc.UserDefault:getInstance():getIntegerForKey("is_hot_finish", 0)
    if is_hot_finish == 1 then
        ccFileUtils:removeDirectory(ccFileUtils:getWritablePath().."update/")
        ccUserDefault:setIntegerForKey("is_hot_finish", 0)
    end


	--todo  load logo and splash
end


function LuaClass:onEnterTransitionFinish()
   __App = require("app.MyApp").new()
   __App:run("GameSceneLogin")  
end
return LuaClass