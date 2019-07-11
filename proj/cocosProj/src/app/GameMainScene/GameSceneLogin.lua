--code by zpc
local LuaClass = class("LuaClass", cc.Scene)


function LuaClass:ctor()
	self:enableNodeEvents()
end


function LuaClass:onEnterTransitionFinish()
	cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)
end
return LuaClass
