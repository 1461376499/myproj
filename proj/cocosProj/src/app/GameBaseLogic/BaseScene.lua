
local BaseScene = class("BaseScene", cc.Scene)
BaseScene.SceneName = ""

function BaseScene:ctor()	
	SceneHelper:setRunningScene(self)
end

--please override
function BaseScene:onEnter()
	
end

--please override
function BaseScene:onEnterTransitionFinish()

end


--please override
function BaseScene:onExitTransitionStart()
	
end

--please override
function BaseScene:onExit()
	self:disableNodeEvents()
	PopWindowHelper:cleanup(true)	
end


--please override
function BaseScene:onCleanup()
	
end



return BaseScene